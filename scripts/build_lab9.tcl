set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set proj_dir [file normalize [file join $repo_dir build lab9_vivado]]
set bit_out  [file normalize [file join $repo_dir build lab9_top.bit]]

create_project lab9_ddr $proj_dir -part xc7a100tcsg324-1 -force

create_ip -name mig_7series -vendor xilinx.com -library ip -version 4.2 -module_name lab9_mig
set_property -dict [list CONFIG.XML_INPUT_FILE [file join $repo_dir src lab_9_ddr mig nexys4ddr_mig.prj]] [get_ips lab9_mig]
generate_target all [get_ips lab9_mig]

add_files [glob [file join $repo_dir src common *.v]]
add_files [glob [file join $repo_dir src lab_9_ddr mips_core *.v]]
foreach rtl [glob [file join $repo_dir src lab_9_ddr *.v]] {
    if {[file tail $rtl] ne "ddr_model.v"} {
        add_files $rtl
    }
}
add_files [file join $repo_dir src lab_9_ddr lab_9_boot.mem]
add_files -fileset constrs_1 [file join $repo_dir constr nexys4ddr_lab9.xdc]
set_property top top [current_fileset]
update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 16
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "lab_9 synthesis failed"
}

launch_runs impl_1 -to_step write_bitstream -jobs 16
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    error "lab_9 implementation/bitstream failed"
}

set generated_bit [file join $proj_dir lab9_ddr.runs impl_1 top.bit]
file copy -force $generated_bit $bit_out
puts "LAB9_BITSTREAM=$bit_out"
