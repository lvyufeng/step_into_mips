set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set proj_dir [file normalize [file join $repo_dir build lab5_vivado]]
set bit_out  [file normalize [file join $repo_dir build lab5_top.bit]]

create_project lab5_soc $proj_dir -part xc7a100tcsg324-1 -force
add_files [glob [file join $repo_dir src lab_5_soc mips_core *.v]]
add_files [glob [file join $repo_dir src lab_5_soc *.v]]
add_files [file join $repo_dir src lab_5_soc lab_5_boot.mem]
add_files -fileset constrs_1 [file join $repo_dir constr nexys4ddr_lab5.xdc]
set_property top top [current_fileset]
update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 16
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "lab_5 synthesis failed"
}

launch_runs impl_1 -to_step write_bitstream -jobs 16
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "lab_5 implementation/bitstream failed"
}

set generated_bit [file join $proj_dir lab5_soc.runs impl_1 top.bit]
file copy -force $generated_bit $bit_out
puts "LAB5_BITSTREAM=$bit_out"
