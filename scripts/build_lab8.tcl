set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set proj_dir [file normalize [file join $repo_dir build lab8_vivado]]
set bit_out  [file normalize [file join $repo_dir build lab8_top.bit]]

create_project lab8_interrupt $proj_dir -part xc7a100tcsg324-1 -force
add_files [glob [file join $repo_dir src common *.v]]
add_files [glob [file join $repo_dir src lab_8_interrupt mips_core *.v]]
add_files [glob [file join $repo_dir src lab_8_interrupt *.v]]
add_files [file join $repo_dir src lab_8_interrupt lab_8_boot.mem]
add_files -fileset constrs_1 [file join $repo_dir constr nexys4ddr_lab8.xdc]
set_property top top [current_fileset]
update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 16
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "lab_8 synthesis failed"
}

launch_runs impl_1 -to_step write_bitstream -jobs 16
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "lab_8 implementation/bitstream failed"
}

set generated_bit [file join $proj_dir lab8_interrupt.runs impl_1 top.bit]
file copy -force $generated_bit $bit_out
puts "LAB8_BITSTREAM=$bit_out"
