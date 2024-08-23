flight_director_reference = {}
flight_director_bars_pilot = find_dataref("sim/cockpit2/autopilot/flight_director_command_bars_pilot")
flight_director_bars_copilot = find_dataref("sim/cockpit2/autopilot/flight_director_command_bars_copilot")

function A333_sync_fd_mode()
    if flight_director_reference ~= flight_director_bars_pilot then
        flight_director_reference = flight_director_bars_pilot
        flight_director_bars_copilot = flight_director_bars_pilot
    elseif flight_director_reference ~= flight_director_bars_copilot then
        flight_director_reference = flight_director_bars_copilot
        flight_director_bars_pilot = flight_director_bars_copilot
    end
end

ls_bars_reference = {}
ls_bars_pilot = find_dataref("laminar/A333/status/capt_ls_bars")
ls_bars_copilot = find_dataref("laminar/A333/status/fo_ls_bars")

function A333_sync_ls_mode()
    if ls_bars_reference ~= ls_bars_pilot then
        ls_bars_reference = ls_bars_pilot
        ls_bars_copilot = ls_bars_pilot
    elseif ls_bars_reference ~= ls_bars_copilot then
        ls_bars_reference = ls_bars_copilot
        ls_bars_pilot = ls_bars_copilot
    end
end

function flight_start()
    flight_director_reference = flight_director_bars_pilot
    flight_director_bars_copilot = flight_director_bars_pilot

    ls_bars_reference = ls_bars_pilot
    ls_bars_copilot = ls_bars_pilot
end

run_at_interval(A333_sync_fd_mode, 1.0)
run_at_interval(A333_sync_ls_mode, 1.0)
