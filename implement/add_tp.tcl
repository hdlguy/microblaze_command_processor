tclapp::install debugutils -quiet

#Usage: add_probe 
    #[-net <netName>]            - Internal net to probe 
    #[-port <portName>]          - Output port name 
    #[-loc <packagePin>]         - FPGA package pin to use for the probe 
    #[-iostandard <iostandard>]  - IOSTANDARD for probe port 
    #[-usage|-u]                 - This help message 

#xilinx::debugutils::add_probe -net [get_nets [list lime1_spi_sck_OBUF]] -port lime1_spi_sck_tp -loc AD24 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list pcie_sys_i/axi_periphs/axi_quad_spi_0/U0/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_0_GEN.SPI_MODULE_I/D_0]] -port lime1_spi_sck_tp -loc AD24 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime1_spi_sdi_IBUF]] -port lime1_spi_sdi_tp -loc AJ24 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime1_spi_sdo_OBUF]] -port lime1_spi_sdo_tp -loc AE24 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime1_spi_csn_OBUF]] -port lime1_spi_csn_tp -loc AK25 -iostandard LVCMOS33

#xilinx::debugutils::add_probe -net [get_nets [list lime2_spi_sck_OBUF]] -port lime2_spi_sck_tp -loc AC22 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list pcie_sys_i/axi_periphs/axi_quad_spi_1/U0/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_0_GEN.SPI_MODULE_I/SCK_O_1]] -port lime2_spi_sck_tp -loc AC22 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime2_spi_sdi_IBUF]] -port lime2_spi_sdi_tp -loc AE25 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime2_spi_sdo_OBUF]] -port lime2_spi_sdo_tp -loc AF23 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime2_spi_csn_OBUF]] -port lime2_spi_csn_tp -loc AF25 -iostandard LVCMOS33

#xilinx::debugutils::add_probe -net [get_nets [list lime3_spi_sck_OBUF]] -port lime3_spi_sck_tp -loc AD22 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list pcie_sys_i/axi_periphs/axi_quad_spi_2/U0/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_0_GEN.SPI_MODULE_I/SCK_O_1]] -port lime3_spi_sck_tp -loc AD22 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime3_spi_sdi_IBUF]] -port lime3_spi_sdi_tp -loc AA20 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime3_spi_sdo_OBUF]] -port lime3_spi_sdo_tp -loc AB27 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime3_spi_csn_OBUF]] -port lime3_spi_csn_tp -loc AB20 -iostandard LVCMOS33

#xilinx::debugutils::add_probe -net [get_nets [list lime4_spi_sck_OBUF]] -port lime4_spi_sck_tp -loc AC27 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list pcie_sys_i/axi_periphs/axi_quad_spi_3/U0/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_0_GEN.SPI_MODULE_I/SCK_O_1]] -port lime4_spi_sck_tp -loc AC27 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime4_spi_sdi_IBUF]] -port lime4_spi_sdi_tp -loc AB24 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime4_spi_sdo_OBUF]] -port lime4_spi_sdo_tp -loc AD27 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list lime4_spi_csn_OBUF]] -port lime4_spi_csn_tp -loc AC25 -iostandard LVCMOS33

#xilinx::debugutils::add_probe -net [get_nets [list rf_spi_sck_OBUF]] -port rf_spi_sck_tp       -loc AD28 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list pcie_sys_i/axi_periphs/axi_quad_spi_4/U0/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_0_GEN.SPI_MODULE_I/D_0]] -port rf_spi_sck_tp -loc AD28 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list rf_spi_sdi_IBUF]] -port rf_spi_sdi_tp       -loc AD21 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list rf_spi_sdo_OBUF]] -port rf_spi_sdo_tp       -loc AJ26 -iostandard LVCMOS33

xilinx::debugutils::add_probe -net [get_nets [list LTC2632_SPI_SEN_OBUF]] -port LTC2632_SPI_SEN_tp -loc AE21 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list osc_dac_cs_n_OBUF]]       -port osc_dac_cs_n_tp -loc AC24 -iostandard LVCMOS33
xilinx::debugutils::add_probe -net [get_nets [list rf_adc_cs_n_OBUF]]         -port rf_adc_cs_n_tp -loc AK26 -iostandard LVCMOS33
#xilinx::debugutils::add_probe -net [get_nets [list mem_cs_n_OBUF]]               -port mem_cs_n_tp -loc ??? -iostandard LVCMOS33

route_design -preserve

