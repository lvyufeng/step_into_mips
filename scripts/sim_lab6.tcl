set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set sim_dir [file normalize [file join $repo_dir build lab6_sim]]
set proj_dir [file normalize [file join $sim_dir vivado]]
file mkdir $sim_dir
cd $sim_dir

create_project lab6_sim $proj_dir -part xc7a100tcsg324-1 -force
file copy -force [file join $repo_dir src lab_6_uart_boot lab_6_boot.mem] [file join $sim_dir lab_6_boot.mem]
file mkdir [file join $proj_dir lab6_sim.sim sim_1 behav xsim]
file copy -force [file join $repo_dir src lab_6_uart_boot lab_6_boot.mem] [file join $proj_dir lab6_sim.sim sim_1 behav xsim lab_6_boot.mem]

add_files [glob [file join $repo_dir src common *.v]]
add_files [glob [file join $repo_dir src lab_6_uart_boot mips_core *.v]]
add_files [glob [file join $repo_dir src lab_6_uart_boot *.v]]
add_files -fileset sim_1 [file join $repo_dir sim lab_6_uart_boot_tb.v]
set_property top lab_6_uart_boot_tb [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -simset sim_1 -mode behavioral
restart
run all
close_sim
puts "LAB6_SIM_DONE"
