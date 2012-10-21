----------------------------------------------------------
-- Licensed under GPLv2
-- @author Guillaume Subiron <maethor+awesome@subiron.org>
----------------------------------------------------------

local os = os
local io = io
local string = string

module("maethor/volume")

local cardid = 0
local channel = "Master"

function getvolume()
    local status = io.popen("amixer -c "..cardid.." -- sget "..channel):read("*all")

    local volume = string.match(status, "(%d?%d?%d)%%")
    volume = string.format("% 3d", volume)
    status = string.match(status, "%[(o[^%]]*)%]")

    if string.find(status, "on", 1, true) then
        volume = volume .. "%"
    else
        volume = "M"
    end
    return volume
end

function change(what)
    os.execute("amixer -q -c "..cardid.." sset "..channel.." "..what, false)
end

function increase()
    change ("5%+")
end
function decrease()
   change("5%-")
end

function toggle()
   change("toggle")
end


