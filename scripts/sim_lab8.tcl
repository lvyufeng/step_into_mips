set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set sim_dir [file normalize [file join $repo_dir build lab8_sim]]
set proj_dir [file normalize [file join $sim_dir vivado]]
file mkdir $sim_dir
cd $sim_dir

create_project lab8_sim $proj_dir -part xc7a100tcsg324-1 -force
file copy -force [file join $repo_dir src lab_8_interrupt lab_8_boot.mem] [file join $sim_dir lab_8_boot.mem]
file mkdir [file join $proj_dir lab8_sim.sim sim_1 behav xsim]
file copy -force [file join $repo_dir src lab_8_interrupt lab_8_boot.mem] [file join $proj_dir lab8_sim.sim sim_1 behav xsim lab_8_boot.mem]

add_files [glob [file join $repo_dir src common *.v]]
add_files [glob [file join $repo_dir src lab_8_interrupt mips_core *.v]]
add_files [glob [file join $repo_dir src lab_8_interrupt *.v]]
add_files -fileset sim_1 [file join $repo_dir sim lab_8_interrupt_tb.v]
set_property top lab_8_interrupt_tb [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -simset sim_1 -mode behavioral
restart
run all
close_sim
puts "LAB8_SIM_DONE"
