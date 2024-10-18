#include <msp430.h>

int main(void) 
{
	volatile unsigned int i;

	WDTCTL = WDTPW | WDTHOLD;
	PM5CTL0 &= ~LOCKLPM5;

	P1DIR |= BIT0;
	P1OUT &= ~BIT0;

	while(1) {
		P1OUT ^= BIT0;
		for (i = 10000; i > 0; i--) {}
	}

	return 1;
}
