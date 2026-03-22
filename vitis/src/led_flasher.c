#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"

#define LED_DELAY     1000000
#define LED_MASK 0x000f
#define RGB_MASK 0x0fff

int main(void)
{

	volatile int Delay;
	u32* gpio_ptr = (u32*)XPAR_AXI_GPIO_0_BASEADDR;

	*(gpio_ptr+XGPIO_DATA_OFFSET) = 0x00000000;
	*(gpio_ptr+XGPIO_TRI_OFFSET)  = 0xfffffff0;

	*(gpio_ptr+XGPIO_DATA2_OFFSET) = 0x00000fa3;
	*(gpio_ptr+XGPIO_TRI2_OFFSET)  = 0xfffff000;

	u32 count = 0;
	while(1) {
		for (Delay = 0; Delay < LED_DELAY; Delay++);
		*(gpio_ptr+XGPIO_DATA_OFFSET)  = count & LED_MASK;
		*(gpio_ptr+XGPIO_DATA2_OFFSET) = count & RGB_MASK; // the rgb leds don't work
		count++;
	}
}
