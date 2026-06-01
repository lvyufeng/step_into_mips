set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set sim_dir [file normalize [file join $repo_dir build lab5_sim]]
set proj_dir [file normalize [file join $sim_dir vivado]]
file mkdir $sim_dir
cd $sim_dir

create_project lab5_sim $proj_dir -part xc7a100tcsg324-1 -force
file copy -force [file join $repo_dir src lab_5_soc lab_5_boot.mem] [file join $sim_dir lab_5_boot.mem]
file mkdir [file join $proj_dir lab5_sim.sim sim_1 behav xsim]
file copy -force [file join $repo_dir src lab_5_soc lab_5_boot.mem] [file join $proj_dir lab5_sim.sim sim_1 behav xsim lab_5_boot.mem]

add_files [glob [file join $repo_dir src lab_5_soc mips_core *.v]]
add_files [glob [file join $repo_dir src lab_5_soc *.v]]
add_files -fileset sim_1 [file join $repo_dir sim lab_5_soc_tb.v]
set_property top lab_5_soc_tb [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -simset sim_1 -mode behavioral
restart
run all
close_sim
puts "LAB5_SIM_DONE"
