local io = io
local string = string

module("volume")

local cardid = 0
local channel = "Master"

function setvolume(mode)
    if mode == "update" then
        local fd = io.popen("amixer -c "..cardid.." -- sget "..channel)
        local status = fd:read("*all")
        fd:close()

        local volume = string.match(status, "(%d?%d?%d)%%")
        volume = string.format("% 3d", volume)
        status = string.match(status, "%[(o[^%]]*)%]")

        if string.find(status, "on", 1, true) then
            volume = volume .. "%"
        else
            volume = "M"
        end
        return volume
    elseif mode == "up" then
        io.popen("amixer -q -c "..cardid.." sset "..channel.." 5%+"):read("*all")
        return setvolume("update", widget)
    elseif mode == "down" then
        io.popen("amixer -q -c "..cardid.." sset "..channel.." 5%-"):read("*all")
        return setvolume("update", widget)
    else
        io.popen("amixer -q -c "..cardid.." sset "..channel.." toggle"):read("*all")
        return setvolume("update", widget)
    end
end



