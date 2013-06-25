/*
  DIY Servo - Arduino driving VNH2SP30 Motor Driver Carrier MD01B
 
  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
 */

#include <PololuDriver.h>

#define ENCODER_A_PIN 2
#define ENCODER_B_PIN 3

long position;

PololuDriver myPololuDriver(11,10,12); // initialize instance of class

const int ledPin = 13; //LED connected to digital pin 13
const int clockPin = 7; //output to clock
const int CSnPin = 6; //output to chip select
const int inputPin = 2; //read AS5040

int debug = 1; //SET THIS TO 0 TO DISABLE PRINTING OF ERROR CODES


// the setup routine runs once when you press reset:
void setup() { 
   Serial.begin(19200);
   Serial.setTimeout(50);
   Serial.println("Started");
 
   pinMode(ENCODER_A_PIN, INPUT);
   pinMode(ENCODER_B_PIN, INPUT);
   
   pinMode(ledPin, OUTPUT); // visual signal of I/O to chip
   pinMode(clockPin, OUTPUT); // SCK
   pinMode(CSnPin, OUTPUT); // CSn -- has to toggle high and low to signal chip to start data transfer
   pinMode(inputPin, INPUT); // SDA
   myPololuDriver.Run(POLOLU_STOP);
}

int mySpeed = 70; // 40 is the minimum to make the gearbox turn
int positionGoal = 0;
String currentState = "stop";
String lastState = "stop";
long lastAngle = 0;

long angle_diff(long angle1, long angle2) {
  return (abs(angle1 + 180 - angle2) % 360 - 180); 
}

boolean should_go_forward(long angle1, long angle2) {
  return ((angle1 - angle2 + 360)%360>180);
}

// the loop routine runs over and over again forever:
void loop() {
  lastState = currentState;
  
  position = read_angle();
  
  // send data only when you receive data:
  if (Serial.available() > 0) {
    myPololuDriver.Run(POLOLU_STOP);
    currentState = "stop";
    lastState = "stop";
    // read the incoming byte:
    positionGoal = Serial.parseInt();

    // say what you got:
    Serial.print("I received: ");
    Serial.println(positionGoal, DEC);
    Serial.print("myangle: ");
    Serial.println(position, DEC);
  } else {
    if (abs(angle_diff(lastAngle,position)) > 1) {
      Serial.print("myangle: ");
      Serial.println(position, DEC);
      Serial.print("positionGoal: ");
      Serial.println(positionGoal, DEC);
      Serial.print("angle_diff: ");
      Serial.println(angle_diff(position, positionGoal), DEC);
    }
  }
  
  if (abs(angle_diff(position, positionGoal)) <= 6) {
    if (lastState != "stop") {
      Serial.println("stop");
      Serial.print("position: ");
      Serial.println(position, DEC);
      myPololuDriver.SetSpeed(mySpeed);
      currentState = "stop";
      myPololuDriver.Run(POLOLU_STOP);
    }
  } else {
    if (!should_go_forward(position, positionGoal)) {
      Serial.println("should go forward");
      if (lastState != "forward") {
        Serial.println("forward");
        myPololuDriver.SetSpeed(mySpeed);
        currentState = "forward";
        myPololuDriver.Run(POLOLU_FORWARD);
      }
    } else {
      Serial.println("should reverse");

      if (lastState != "reverse") {
        Serial.println("reverse");
        myPololuDriver.SetSpeed(mySpeed);
        currentState = "reverse";
        myPololuDriver.Run(POLOLU_REVERSE);
      }
    }
  }
  lastAngle = position;
}

long read_angle()
{
  int inputstream = 0; //one bit read from pin
  long packeddata = 0; //two bytes concatenated from inputstream
  long angle = 0; //holds processed angle value
  long anglemask = 65472; //0x1111111111000000: mask to obtain first 10 digits with position info
  long statusmask = 63; //0x000000000111111; mask to obtain last 6 digits containing status info
  long statusbits; //holds status/error information
  int DECn; //bit holding decreasing magnet field error data
  int INCn; //bit holding increasing magnet field error data
  int OCF; //bit holding startup-valid bit
  int COF; //bit holding cordic DSP processing error data
  int LIN; //bit holding magnet field displacement error data
  int shortdelay = 100; // this is the microseconds of delay in the data clock
  int longdelay = 10; // this is the milliseconds between readings
  
  // CSn needs to cycle from high to low to initiate transfer. Then clock cycles. As it goes high
  // again, data will appear on sda
  digitalWrite(CSnPin, HIGH); // CSn high
  digitalWrite(clockPin, HIGH); // CLK high
  delay(longdelay);// time between readings
  digitalWrite(ledPin, HIGH); // signal start of transfer with LED
  digitalWrite(CSnPin, LOW); // CSn low: start of transfer
  delayMicroseconds(shortdelay); // delay for chip initialization
  digitalWrite(clockPin, LOW); // CLK goes low: start clocking
  delayMicroseconds(shortdelay); // hold low
  for (int x=0; x <16; x++) // clock signal, 16 transitions, output to clock pin
  {
    digitalWrite(clockPin, HIGH); //clock goes high
    delayMicroseconds(shortdelay); // 
    inputstream =digitalRead(inputPin); // read one bit of data from pin
    //Serial.print(inputstream, DEC);
    packeddata = ((packeddata << 1) + inputstream);// left-shift summing variable, add pin value
    digitalWrite(clockPin, LOW);
    delayMicroseconds(shortdelay); // end of one clock cycle
  }
  // end of entire clock cycle
  //Serial.println(" ");
  digitalWrite(ledPin, LOW); // signal end of transmission
  // lots of diagnostics for verifying bitwise operations
  //Serial.print("packed:");
  //Serial.println(packeddata,DEC);
  //Serial.print("pack bin: ");
  // Serial.println(packeddata,BIN);
  angle = packeddata & anglemask; // mask rightmost 6 digits of packeddata to zero, into angle.
  //Serial.print("mask: ");
  //Serial.println(anglemask, BIN);
  //Serial.print("bin angle:");
  //Serial.println(angle, BIN);
  //Serial.print("angle: ");
  //Serial.println(angle, DEC);
  angle = (angle >> 6); // shift 16-digit angle right 6 digits to form 10-digit value
  //Serial.print("angleshft:");
  //Serial.println(angle, BIN);
  //Serial.print("angledec: ");
  //Serial.println(angle, DEC);
  angle = angle * 0.3515; // angle * (360/1024) == actual degrees
  //Serial.print("angle: "); // and, finally, print it.
  //Serial.println(angle, DEC);
  //Serial.println("--------------------");
  //Serial.print("raw: "); // this was the prefix for the bit-by-bit diag output inside the loop.
  if (debug)
  {
    statusbits = packeddata & statusmask;
    DECn = statusbits & 2; // goes high if magnet moved away from IC
    INCn = statusbits & 4; // goes high if magnet moved towards IC
    LIN = statusbits & 8; // goes high for linearity alarm
    COF = statusbits & 16; // goes high for cordic overflow: data invalid
    OCF = statusbits & 32; // this is 1 when the chip startup is finished.
    if (DECn && INCn) { Serial.println("magnet moved out of range"); }
    else
    {
      if (DECn) { Serial.println("magnet moved away from chip"); }
      if (INCn) { Serial.println("magnet moved towards chip"); }
    }
      if (LIN) { Serial.println("linearity alarm: magnet misaligned? Data questionable."); }
      if (COF) { Serial.println("cordic overflow: magnet misaligned? Data invalid."); }
  }
  
  return angle;
  
  packeddata = 0; // reset both variables to zero so they don't just accumulate
  angle = 0;
}
