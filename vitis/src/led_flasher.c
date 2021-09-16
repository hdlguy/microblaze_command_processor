#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"

#define LED 0x0f   /* Assumes bit 0 of GPIO is connected to an LED  */

#define GPIO_EXAMPLE_DEVICE_ID  XPAR_GPIO_0_DEVICE_ID

#define LED_DELAY     1000000

#define LED_CHANNEL 1

#ifdef PRE_2_00A_APPLICATION

/*
 * The following macros are provided to allow an application to compile that
 * uses an older version of the driver (pre 2.00a) which did not have a channel
 * parameter. Note that the channel parameter is fixed as channel 1. */
#define XGpio_SetDataDirection(InstancePtr, DirectionMask) \
        XGpio_SetDataDirection(InstancePtr, LED_CHANNEL, DirectionMask)

#define XGpio_DiscreteRead(InstancePtr) \
        XGpio_DiscreteRead(InstancePtr, LED_CHANNEL)

#define XGpio_DiscreteWrite(InstancePtr, Mask) \
        XGpio_DiscreteWrite(InstancePtr, LED_CHANNEL, Mask)

#define XGpio_DiscreteSet(InstancePtr, Mask) \
        XGpio_DiscreteSet(InstancePtr, LED_CHANNEL, Mask)

#endif

XGpio Gpio; /* The Instance of the GPIO Driver */


int main(void)
{
	int Status;
	volatile int Delay;

	print("initializing the XGpio driver\n\r");
	Status = XGpio_Initialize(&Gpio, GPIO_EXAMPLE_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}

	/* Set the direction for all signals as inputs except the LED output */
	XGpio_SetDataDirection(&Gpio, LED_CHANNEL, ~LED);


	while (1) {
		XGpio_DiscreteWrite(&Gpio, LED_CHANNEL, LED);

		for (Delay = 0; Delay < LED_DELAY; Delay++);

		XGpio_DiscreteClear(&Gpio, LED_CHANNEL, LED);

		for (Delay = 0; Delay < LED_DELAY; Delay++);
	}

}
