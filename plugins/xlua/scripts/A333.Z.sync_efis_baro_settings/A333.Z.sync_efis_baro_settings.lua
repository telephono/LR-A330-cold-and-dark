barometer_knob_reference = {}
barometer_knob_pos_pilot = find_dataref("laminar/A333/barometer/capt_knob_pos")
barometer_knob_pos_copilot = find_dataref("laminar/A333/barometer/fo_knob_pos")

function A333_sync_baro_settings()
    if barometer_knob_reference ~= barometer_knob_pos_pilot then
        barometer_knob_reference = barometer_knob_pos_pilot
        barometer_knob_pos_copilot = barometer_knob_pos_pilot
    elseif barometer_knob_reference ~= barometer_knob_pos_copilot then
        barometer_knob_reference = barometer_knob_pos_copilot
        barometer_knob_pos_pilot = barometer_knob_pos_copilot
    end
end

barometer_mode_reference = {}
barometer_mode_pilot = find_dataref("laminar/A333/barometer/capt_mode")
barometer_mode_copilot = find_dataref("laminar/A333/barometer/fo_mode")

function A333_sync_baro_mode()
    if barometer_mode_reference ~= barometer_mode_pilot then
        barometer_mode_reference = barometer_mode_pilot
        barometer_mode_copilot = barometer_mode_pilot
    elseif barometer_mode_reference ~= barometer_mode_copilot then
        barometer_mode_reference = barometer_mode_copilot
        barometer_mode_pilot = barometer_mode_copilot
    end
end

barometer_inHg_hPa_reference = {}
barometer_inHg_hPa_pos_pilot = find_dataref("laminar/A333/barometer/capt_inHg_hPa_pos")
barometer_inHg_hPa_pos_copilot = find_dataref("laminar/A333/barometer/fo_inHg_hPa_pos")

function A333_sync_baro_inHg_hPa_settings()
    if barometer_inHg_hPa_reference ~= barometer_inHg_hPa_pos_pilot then
        barometer_inHg_hPa_reference = barometer_inHg_hPa_pos_pilot
        barometer_inHg_hPa_pos_copilot = barometer_inHg_hPa_pos_pilot
    elseif barometer_inHg_hPa_reference ~= barometer_inHg_hPa_pos_copilot then
        barometer_inHg_hPa_reference = barometer_inHg_hPa_pos_copilot
        barometer_inHg_hPa_pos_pilot = barometer_inHg_hPa_pos_copilot
    end
end

function flight_start()
    barometer_knob_reference = barometer_knob_pos_pilot
    barometer_knob_pos_copilot = barometer_knob_pos_pilot

    barometer_mode_reference = barometer_mode_pilot
    barometer_mode_copilot = barometer_mode_pilot

    barometer_inHg_hPa_reference = barometer_inHg_hPa_pos_pilot
    barometer_inHg_hPa_pos_copilot = barometer_inHg_hPa_reference
end

run_at_interval(A333_sync_baro_settings, 1.0)
run_at_interval(A333_sync_baro_mode, 1.0)
run_at_interval(A333_sync_baro_inHg_hPa_settings, 1.0)
