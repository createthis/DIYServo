#include "Arduino.h"

#define POLOLU_STOP					0
#define POLOLU_FORWARD				1
#define POLOLU_REVERSE				2

class PololuDriver
{
public:
	PololuDriver(byte pwmPin, byte inA, byte inB);
	void SetSpeed(byte speed);
	void Run(byte direction);
	void Run(byte direction, byte speed);
private:
	byte m_pwm;
	byte m_inA;
	byte m_inB;
};
