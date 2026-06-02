set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set sim_dir [file normalize [file join $repo_dir build lab9_sim]]
set proj_dir [file normalize [file join $sim_dir vivado]]
file mkdir $sim_dir
cd $sim_dir

create_project lab9_sim $proj_dir -part xc7a100tcsg324-1 -force
file copy -force [file join $repo_dir src lab_9_ddr lab_9_boot.mem] [file join $sim_dir lab_9_boot.mem]
file mkdir [file join $proj_dir lab9_sim.sim sim_1 behav xsim]
file copy -force [file join $repo_dir src lab_9_ddr lab_9_boot.mem] [file join $proj_dir lab9_sim.sim sim_1 behav xsim lab_9_boot.mem]

add_files [glob [file join $repo_dir src common *.v]]
add_files [glob [file join $repo_dir src lab_9_ddr mips_core *.v]]
foreach rtl [glob [file join $repo_dir src lab_9_ddr *.v]] {
    if {[lsearch -exact {top.v clk_100_to_200.v mig_axi_adapter.v} [file tail $rtl]] < 0} {
        add_files $rtl
    }
}
add_files -fileset sim_1 [file join $repo_dir sim lab_9_ddr_tb.v]
set_property top lab_9_ddr_tb [get_filesets sim_1]
update_compile_order -fileset sim_1

launch_simulation -simset sim_1 -mode behavioral
restart
run all
close_sim
puts "LAB9_SIM_DONE"
