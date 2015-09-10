
open_checkpoint ./results/post_route.dcp

# This associates the SDC elf output with the microblaze processor.
set elf_file ../petes_sdk/uart2led/Release/uart2led.elf
add_files -norecurse $elf_file
set_property SCOPED_TO_REF pcie_sys [get_files -all -of_objects [get_fileset sources_1] $elf_file]
set_property SCOPED_TO_CELLS { mblaze/microblaze_0 } [get_files -all -of_objects [get_fileset sources_1] $elf_file]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 9 [current_design]
#
write_bitstream -force $outputDir/top.bit

close_project

write_cfgmem -force -format MCS -size 128 -interface BPIx16 -loadbit "up 0x0 ./results/top.bit" -verbose ./results/top.mcs


