#include "PololuDriver.h"

PololuDriver::PololuDriver(byte pwmPin, byte inA, byte inB)
{
	m_pwm = pwmPin;
	m_inA = inA;
	m_inB = inB;
	
	pinMode(inA, OUTPUT); //can send +/0 voltage 3.3v/0
	pinMode(inB, OUTPUT);
	analogWrite(m_pwm, 0);
}

void PololuDriver::SetSpeed(byte speed)
{	
	analogWrite(m_pwm, speed);
}

void PololuDriver::Run(byte direction)
{	
	switch (direction)
	{
		case POLOLU_STOP:
			digitalWrite(m_inA, LOW);
			digitalWrite(m_inB, LOW);
			break;
		case POLOLU_FORWARD:
			digitalWrite(m_inA, HIGH);
			digitalWrite(m_inB, LOW);
			break;
		case POLOLU_REVERSE	:
			digitalWrite(m_inA, LOW);
			digitalWrite(m_inB, HIGH);
			break;
	}
}

void PololuDriver::Run(byte direction, byte speed)
{
	SetSpeed(speed);
	Run(direction);
}
