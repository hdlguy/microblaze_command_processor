#include "xparameters.h"
#include "xstatus.h"
#include "xspi_l.h"
#include <stdio.h>
#define SPI_BASEADDR		XPAR_SPI_0_BASEADDR
u32 spi_scan(u32 portnum, u32 tx_data);
#define RF_ADC_MUX_SEL_MASK 0x30000000; // bits 29:28 in register 6.

int main(void)
{
	char out_string[100];
	u32 rx_data;
	u32 i, j, rfadc_a, rfadc_b, reg6;
	u32 *reg_ptr;
	u32 rf_adc_data[4];
	u32 lime_data[4][8];
	u32 flash_id;

	// Let's read some Lime default register values.
	for(j=0; j<4; j++){
		for(i=2; i<8; i++){
			lime_data[j][i] = spi_scan(j, i<<8);
		}
	}

//	// Let's read the RF ADC.
//	reg_ptr = XPAR_AXI_PERIPHS_REGFILEX16_V1_0_0_BASEADDR+0x04*6;
//	for(i=0; i<4; i++){
//		reg6 = *reg_ptr;
//		reg6 &= ~RF_ADC_MUX_SEL_MASK; // clear the rf adc mux select bits.
//		reg6 |= i<<28; // set the mux select bits.
//		*reg_ptr = reg6;
//		rf_adc_data[i] = spi_scan(7, 0);
//	}

	// print lime data.
	for(j=0; j<4; j++){
		for(i=2; i<8; i++){
			sprintf(out_string,"lime(%d), rx_data(%d) = %4x\r\n", (int)j, (int)i, (unsigned int)lime_data[j][i]);	print(out_string);
		}
	}

//	// print rf adc results.
//	for(i=0; i<4; i++){
//		sprintf(out_string,"RF ADC = %4x\r\n", (unsigned int)rf_adc_data[i]);
//		print(out_string);
//		rfadc_a = (rf_adc_data[i]>>18)&0xfff;
//		rfadc_b = (rf_adc_data[i]>> 2)&0xfff;
//		sprintf(out_string,"MuxSel = %d, RF ADC A = %d, RF ADC B = %d\r\n", (int)i, (int)rfadc_a, (int)rfadc_b);
//		print(out_string);
//	}

	// Let's write a value to the AD5621 oscillator control DAC.
	spi_scan(5, 0x10000000); // this should put the dac at 1/4 scale = 0.75V.
	spi_scan(5, 0x20000000); // this should put the dac at 1/2 scale = 0.5V.
	//spi_scan(5, 0x3ffc0000); // this should put the dac at full scale = 3.0V.

	// Let's write something to the Power Amp DAC's.
	spi_scan(4, 0x00600000); // select internal reference, 2.5V.
	spi_scan(4, 0x00001000); // write to DAC A.
	spi_scan(4, 0x00212000); // write to DAC B and power up both DAC's.

	// Let's try to read the device codes from the SPI flash.
	rx_data = spi_scan(6, 0x9f000000);
	flash_id = rx_data&0xffffff;
	sprintf(out_string,"flash_id = 0x%x, should be 0x014013.\r\n", (unsigned int)flash_id); print(out_string);

	return XST_SUCCESS;
}


u32 spi_scan(u32 portnum, u32 tx_data)
// portnum selects the spi slave to access
// portnum = 0 -> Lime 1.
// portnum = 1 -> Lime 2.
// portnum = 2 -> Lime 3.
// portnum = 3 -> Lime 4.
// portnum = 4 -> LTC2632.
// portnum = 5 -> Oscillator DAC.
// portnum = 6 -> Flash Memory.
// portnum = 7 -> RF ADC.
{
	u32 BaseAddress, SS_Vector, cpol, cpha;
	u32 Control, rx_data;

	switch(portnum){
		case 0 : BaseAddress=XPAR_SPI_0_BASEADDR; SS_Vector=0x000000fe; cpol=0; cpha=0; break;
		case 1 : BaseAddress=XPAR_SPI_1_BASEADDR; SS_Vector=0x000000fe; cpol=0; cpha=0; break;
		case 2 : BaseAddress=XPAR_SPI_2_BASEADDR; SS_Vector=0x000000fe; cpol=0; cpha=0; break;
		case 3 : BaseAddress=XPAR_SPI_3_BASEADDR; SS_Vector=0x000000fe; cpol=0; cpha=0; break;
		case 4 : BaseAddress=XPAR_SPI_4_BASEADDR; SS_Vector=0x000000fe; cpol=0; cpha=0; break;
		case 5 : BaseAddress=XPAR_SPI_4_BASEADDR; SS_Vector=0x000000fd; cpol=1; cpha=0; break;
		case 6 : BaseAddress=XPAR_SPI_4_BASEADDR; SS_Vector=0x000000fb; cpol=0; cpha=0; break;
		case 7 : BaseAddress=XPAR_SPI_4_BASEADDR; SS_Vector=0x000000f7; cpol=0; cpha=0; break;
		default: BaseAddress=XPAR_SPI_0_BASEADDR; SS_Vector=0x000000fe; cpol=0; cpha=0; break;
	}

	XSpi_WriteReg(BaseAddress, XSP_SRR_OFFSET, 0x0000000a); // do a software reset on the SPI core.
	XSpi_WriteReg(BaseAddress, XSP_SSR_OFFSET, 0x000000ff); // turn off all slave selects.

	// Configure the SPI core.
	Control = XSpi_ReadReg(BaseAddress, XSP_CR_OFFSET);
	Control &= ~XSP_CR_LSB_MSB_FIRST_MASK; // use MSB first.
	Control &= ~XSP_CR_TRANS_INHIBIT_MASK; // don't inhibit master transactions.
	Control |= XSP_CR_MANUAL_SS_MASK;      // enable manual slave select mode.
	Control |= XSP_CR_RXFIFO_RESET_MASK;   // force reset of rx fifo.
	Control |= XSP_CR_TXFIFO_RESET_MASK;   // force reset of tx fifo.
	Control |= cpha<<4;
	Control |= cpol<<3;
	Control |= XSP_CR_MASTER_MODE_MASK;    // Master mode.
	Control |= XSP_CR_ENABLE_MASK;         // enable SPI core.
	Control &= ~XSP_CR_LOOPBACK_MASK;      // not in loop back.
	XSpi_WriteReg(BaseAddress, XSP_CR_OFFSET, Control);

	XSpi_WriteReg(BaseAddress, XSP_SSR_OFFSET, SS_Vector); // turn on the slave select.

	XSpi_WriteReg((BaseAddress), XSP_DTR_OFFSET, tx_data); // write to the tx fifo.

	// Wait for the receive FIFO to be not empty.
	while ((XSpi_ReadReg(BaseAddress, XSP_SR_OFFSET) & XSP_SR_RX_EMPTY_MASK));

	XSpi_WriteReg(BaseAddress, XSP_SSR_OFFSET, 0x000000ff);  // turn off all slave selects.

	rx_data = XSpi_ReadReg(BaseAddress, XSP_DRR_OFFSET); // get the received word.

	return rx_data;
}

