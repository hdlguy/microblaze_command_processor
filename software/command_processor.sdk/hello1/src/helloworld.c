
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"


int main()
{
    init_platform();

    xil_printf("\n\rHello World1\n\r");

    xil_printf("Hello World2\n\r");

    cleanup_platform();
    return 0;
}
