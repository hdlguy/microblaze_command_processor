# run at linux command line 
#       xsct setup.tcl
#       vitis -workspace ./workspace
#
file delete -force ./workspace

set hw ../implement/results/top.xsa
#set proc "ps7_cortexa9_0"
#set proc "psu_cortexr5_0"
#set proc "psu_cortexa53_0"
set proc "microblaze_0"

setws ./workspace

platform create -name "standalone_plat"    -hw $hw -proc $proc -os standalone

app create -name xscugic_test -platform standalone_plat -domain standalone_domain -template "Empty Application"
#file link -symbolic ./workspace/xscugic_test/src/xuartlite_polled_example.c ../../../src/xuartlite_polled_example.c



