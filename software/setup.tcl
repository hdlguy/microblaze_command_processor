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
# If non-empty 'Error setting workspace'
setws $sdk_dir

# If non-empty 'Error creating hardware project'
createhw -name $hwproject -hwspec $hwspec

# If non-empty 'Error creating board support package'
createbsp -name $bsp -hwproject $hwproject -proc $proc -os $os

# Update the microprocessor software spec (MSS) and regenerate the BSP
updatemss -mss $sdk_dir/$bsp/system.mss
regenbsp -bsp $bsp

# Create new application project as Empty Application (use repo -apps) to see available
# applications for each architecture - here you need to specify everything I think
createapp -name $application -app {Empty Application} -proc $proc -hwproject $hwproject -bsp $bsp -os $os

# Clean and build all projects
projects -clean
projects -build

