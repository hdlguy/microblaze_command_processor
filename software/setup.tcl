set proj_name command_processor
set sdk_dir ./$proj_name.sdk

file delete -force $sdk_dir/.metadata
file delete -force $sdk_dir/hw_platform_0
file delete -force $sdk_dir/standalone_bsp_0

set hwproject "hw_platform_0"
set hwspec ../implement/results/top.hdf
set bsp "standalone_bsp_0"
set proc "microblaze_0"
set os "standalone"
set application "hello1"

# Create workspace and import the project into
setws $sdk_dir

createhw -name $hwproject -hwspec $hwspec

createbsp -name $bsp -hwproject $hwproject -proc $proc -os $os

# Update the microprocessor software spec (MSS) and regenerate the BSP
updatemss -mss $sdk_dir/$bsp/system.mss
regenbsp -bsp $bsp

# Create new application project as Empty Application 
# Note that previously created source files will not be overwritten.
createapp -name $application -app {Empty Application} -proc $proc -hwproject $hwproject -bsp $bsp -os $os

# Clean and build all projects
projects -clean
projects -build

