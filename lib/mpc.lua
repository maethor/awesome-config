----------------------------------------------------------
-- Licensed under GPLv2
-- @author Guillaume Subiron <maethor+awesome@subiron.org>
----------------------------------------------------------

-- Require mpc

local os = os
local io = io

local naughty = naughty

module("maethor/mpc")

--function toggle_high_low()
--    if settings._mpd_volume == nil then
--        settings._mpd_volume = 30
--    end
--    if settings._mpd_volume == 30 then
--        awful.util.spawn_with_shell("mpc volume 74")
--        settings._mpd_volume = 74
--    else
--        awful.util.spawn_with_shell("mpc volume 30")
--        settings._mpd_volume = 30
--    end
--end

function next_track()
    os.execute("mpc next", false)
end

function prev_track()
    os.execute("mpc prev", false)
end

function play_pause()
    os.execute("mpc toggle", false)
end

local nid = nil
function notify() 
    --local info = io.popen(awesome_bins .. "/mpc_show"):read("*all")
    local info = io.popen("mpc | head -n 2 | sed -e 's/\"//g' -e 's/&/&amp;/g'"):read("*all")
    nid = naughty.notify({title="Now playing:", replaces_id=nid, text=info, timeout=5}).id
end
