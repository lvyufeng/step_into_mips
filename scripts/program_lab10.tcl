set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir ..]]
set bit_file [file normalize [file join $repo_dir build lab10_top.bit]]

if {![file exists $bit_file]} {
    error "Bitstream not found: $bit_file"
}

open_hw_manager
connect_hw_server -allow_non_jtag
set targets [get_hw_targets]
if {[llength $targets] == 0} {
    error "No hardware targets found"
}
current_hw_target [lindex $targets 0]
open_hw_target

# DDR designs are more sensitive during configuration startup. Slow JTAG down
# if the cable exposes the parameter; older lab scripts leave the default.
catch {set_property PARAM.FREQUENCY 6000000 [current_hw_target]}

set devs [get_hw_devices xc7a100t*]
if {[llength $devs] == 0} {
    error "No xc7a100t hardware device found"
}
set dev [lindex $devs 0]
current_hw_device $dev
refresh_hw_device $dev
set_property PROGRAM.FILE $bit_file $dev

set programmed 0
for {set attempt 1} {$attempt <= 2} {incr attempt} {
    puts "LAB10_PROGRAM_ATTEMPT=$attempt"
    if {[catch {program_hw_devices $dev} err]} {
        puts "LAB10_PROGRAM_ATTEMPT_${attempt}_ERROR=$err"
        after 1000
        refresh_hw_device $dev
    } else {
        set programmed 1
        break
    }
}

if {!$programmed} {
    error "lab_10 program failed after retries"
}

refresh_hw_device $dev
puts "LAB10_PROGRAMMED=$dev BITSTREAM=$bit_file"
close_hw_manager
