# run at linux command line 
#       xsct setup.tcl
#       vitis --classic --workspace ./workspace
#
file delete -force ./workspace

set hw ../implement/results/top.xsa
#set proc "ps7_cortexa9_0"
#set proc "psu_cortexr5_0"
#set proc "psu_cortexa53_0"
set proc "microblaze_0"

setws ./workspace

platform create -name "standalone_plat"    -hw $hw -proc $proc -os standalone

app create -name led_flasher -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
file link -symbolic ./workspace/led_flasher/src/led_flasher.c ../../../src/led_flasher.c

app create -name command_proc -platform standalone_plat -domain standalone_domain -template "Empty Application(C)"
file link -symbolic ./workspace/command_proc/src/command_proc.c ../../../src/command_proc.c



