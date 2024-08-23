pfd_brightness_ref = {}
pfd_brightness_pilot = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[0]")
pfd_brightness_copilot = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[5]")

function A333_sync_pfd_brightness()
    if pfd_brightness_ref ~= pfd_brightness_pilot then
        pfd_brightness_ref = pfd_brightness_pilot
        pfd_brightness_copilot = pfd_brightness_pilot
    elseif pfd_brightness_ref ~= pfd_brightness_copilot then
        pfd_brightness_ref = pfd_brightness_copilot
        pfd_brightness_pilot = pfd_brightness_copilot
    end
end

nd_brightness_ref = {}
nd_brightness_pilot = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[1]")
nd_brightness_copilot = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[4]")

function A333_sync_nd_brightness()
    if nd_brightness_ref ~= nd_brightness_pilot then
        nd_brightness_ref = nd_brightness_pilot
        nd_brightness_copilot = nd_brightness_pilot
    elseif nd_brightness_ref ~= nd_brightness_copilot then
        nd_brightness_ref = nd_brightness_copilot
        nd_brightness_pilot = nd_brightness_copilot
    end
end

ecam_brightness_ref = {}
ecam_upper_brightness = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[2]")
ecam_lower_brightness = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[3]")

function A333_sync_ecam_brightness()
    if ecam_brightness_ref ~= ecam_upper_brightness then
        ecam_brightness_ref = ecam_upper_brightness
        ecam_lower_brightness = ecam_upper_brightness
    elseif ecam_brightness_ref ~= ecam_lower_brightness then
        ecam_brightness_ref = ecam_lower_brightness
        ecam_upper_brightness = ecam_lower_brightness
    end
end

mcdu_brightness_ref = {}
mcdu_brightness_pilot = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[6]")
mcdu_brightness_copilot = find_dataref("sim/cockpit2/switches/instrument_brightness_ratio[7]")

function A333_sync_mcdu_brightness()
    if mcdu_brightness_ref ~= mcdu_brightness_pilot then
        mcdu_brightness_ref = mcdu_brightness_pilot
        mcdu_brightness_copilot = mcdu_brightness_pilot
    elseif mcdu_brightness_ref ~= mcdu_brightness_copilot then
        mcdu_brightness_ref = mcdu_brightness_copilot
        mcdu_brightness_pilot = mcdu_brightness_copilot
    end
end

function flight_start()
    pfd_brightness_ref = pfd_brightness_pilot
    nd_brightness_ref = nd_brightness_pilot
    ecam_brightness_ref = ecam_upper_brightness
    mcdu_brightness_ref = mcdu_brightness_pilot
end

run_at_interval(A333_sync_pfd_brightness, 1.0)
run_at_interval(A333_sync_nd_brightness, 1.0)
run_at_interval(A333_sync_ecam_brightness, 1.0)
run_at_interval(A333_sync_mcdu_brightness, 1.0)
