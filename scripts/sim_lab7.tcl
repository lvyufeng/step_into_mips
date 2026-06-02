set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set sim_dir [file normalize [file join $repo_dir build lab7_sim]]
set proj_dir [file normalize [file join $sim_dir vivado]]
file mkdir $sim_dir
cd $sim_dir

create_project lab7_sim $proj_dir -part xc7a100tcsg324-1 -force
file copy -force [file join $repo_dir src lab_7_c_runtime lab_7_boot.mem] [file join $sim_dir lab_7_boot.mem]
file mkdir [file join $proj_dir lab7_sim.sim sim_1 behav xsim]
file copy -force [file join $repo_dir src lab_7_c_runtime lab_7_boot.mem] [file join $proj_dir lab7_sim.sim sim_1 behav xsim lab_7_boot.mem]

add_files [glob [file join $repo_dir src common *.v]]
add_files [glob [file join $repo_dir src lab_7_c_runtime mips_core *.v]]
add_files [glob [file join $repo_dir src lab_7_c_runtime *.v]]
add_files -fileset sim_1 [file join $repo_dir sim lab_7_c_runtime_tb.v]
set_property top lab_7_c_runtime_tb [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -simset sim_1 -mode behavioral
restart
run all
close_sim
puts "LAB7_SIM_DONE"
