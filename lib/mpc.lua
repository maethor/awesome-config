----------------------------------------------------------
-- Licensed under GPLv2
-- @author Guillaume Subiron <maethor+awesome@subiron.org>
----------------------------------------------------------

-- Require mpc

local os = os
local io = io
local string = string

local naughty = naughty

local default_cover = "~/.config/awesome/default_cover.jpg"
local COVER_SIZE = 75
local music_folder = "~/Musique"

module("maethor/mpc")

function next_track()
    os.execute("mpc next", false)
    notify()
end

function prev_track()
    os.execute("mpc prev", false)
    notify()
end

function play_pause()
    os.execute("mpc toggle", false)
    notify()
end

function get_cover()
    local filename = io.popen("mpc -f '%file%' | head -n 1"):read("*all")
    if string.sub(music_folder, 1, 1) == "~" then
       local user_folder = io.popen("echo ~"):read("*line")
       music_folder = user_folder .. string.sub(music_folder, 2)
    end
    local folder = music_folder.."/"..filename:sub(0, filename:find("/", filename:reverse():find("/")))
    local cover = io.popen("ls " .. string.gsub(string.gsub(folder, "'", "\\'"), " ", "\\ ") .. 
                            " | grep -P '.jpg|.png|.gif|.jpeg' | head -n 1"):read("*line")
    if cover == "" then
        if string.sub(default_cover, 1, 1) == "~" then
           local user_folder = io.popen("echo ~"):read("*line")
           default_cover = user_folder .. string.sub(default_cover, 2)
        end
        return default_cover 
    else
        return folder .. cover
    end
end

local nid = nil
function notify() 
    local info1 = io.popen("mpc -f '%track% - %title%' | head -n 1"):read("*all")
    local info2 = io.popen("mpc -f '%artist% - %album%' | head -n 1"):read("*all")
    local info_misc = io.popen("mpc | tail -n 2 | head -n 1 | sed -e 's/\"//g' -e 's/&/&amp;/g'"):read("*line")
    if info_misc:match("playing") then
        info3 = string.gsub(info_misc, "playing", "<span color='#73d216'>playing</span>")
    elseif info_misc:match("paused") then
        info3 = string.gsub(info_misc, "paused", "<span color='#f57900'>paused</span>")
    else
        info3 = info_misc
    end
    local info = info1..info2..info3
    nid = naughty.notify({title="Now playing: \n", replaces_id=nid, text=info, icon=get_cover(), icon_size=COVER_SIZE, timeout=5}).id
end
