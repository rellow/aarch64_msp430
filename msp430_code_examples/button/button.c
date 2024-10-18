#include <msp430.h>

int main(void) 
{
	WDTCTL = WDTPW | WDTHOLD;

	PM5CTL0 &= ~LOCKLPM5;

	P1DIR |= BIT0;
	P1OUT |= BIT0;

	P1DIR &= ~BIT1;
	P1REN |= BIT1;
	P1OUT |= BIT1;

	while (1) {
		if ((P1IN & BIT1) == 0) {
			P1OUT &= ~BIT0;
		} else {
			P1OUT |= BIT0;
		}

	}

	return 0;
}
