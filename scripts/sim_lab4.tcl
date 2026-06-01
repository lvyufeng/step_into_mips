set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set sim_dir [file normalize [file join $repo_dir build lab4_sim]]
set proj_dir [file normalize [file join $sim_dir vivado]]
file mkdir $sim_dir
cd $sim_dir

create_project lab4_sim $proj_dir -part xc7a100tcsg324-1 -force
file copy -force [file join $repo_dir src lab_4 lab_4_inst.mem] [file join $sim_dir lab_4_inst.mem]
file mkdir [file join $proj_dir lab4_sim.sim sim_1 behav xsim]
file copy -force [file join $repo_dir src lab_4 lab_4_inst.mem] [file join $proj_dir lab4_sim.sim sim_1 behav xsim lab_4_inst.mem]

set rtl_files [glob [file join $repo_dir src lab_4 *.v]]
add_files $rtl_files
add_files -fileset sim_1 [file join $repo_dir sim lab_4_tb.v]
set_property top testbench [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -simset sim_1 -mode behavioral
restart
run all
close_sim
puts "LAB4_SIM_DONE"
