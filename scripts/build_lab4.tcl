set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set proj_dir [file normalize [file join $repo_dir build lab4_vivado]]

create_project lab4_pipeline_cpu $proj_dir -part xc7a100tcsg324-1 -force
add_files [glob [file join $repo_dir src lab_4 *.v]]
add_files [file join $repo_dir src lab_4 lab_4_inst.mem]
set_property top top [current_fileset]
update_compile_order -fileset sources_1

launch_runs synth_1 -jobs 16
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    error "lab_4 synthesis failed"
}
puts "LAB4_SYNTHESIS_OK"
