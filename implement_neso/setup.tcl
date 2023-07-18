# This script sets up a Vivado project with all ip references resolved.
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -part xc7a100tcsg324-2 -force proj 
set_property target_language VHDL [current_project]
set_property default_lib work [current_project]
load_features ipintegrator
tclapp::install ultrafast -quiet

# Recreate the Block Diagram of the processor system.
source ../source/system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]
set_property synth_checkpoint_mode None    [get_files ./proj.srcs/sources_1/bd/system/system.bd]
write_hwdef -force  -file ./results/top.hdf

# Read in the hdl source.
read_vhdl [glob ../source/top.vhd]

read_xdc ../source/neso_top.xdc

close_project



