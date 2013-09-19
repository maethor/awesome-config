-- Setup display
local xrandr = {
    rhodes = "--output VGA-1 --auto --output DVI-I-1 --auto --right-of VGA-1",
}
if xrandr[hostname] then
   os.execute("xrandr " .. xrandr[hostname])
end

-- Spawn a composoting manager
awful.util.spawn("xcompmgr", false)

-- Keyboard map
awful.util.spawn("setxkbmap fr oss")
awful.util.spawn("xmodmap -e 'keysym Menu = Super_L'")

if hostname == "logan" or hostname == "stark" then
    -- Synaptics
    awful.util.spawn_with_shell(awesome_bins .. "/synaptics")
end

if hostname == "stark" then
    xrun("owncloud", "owncloud")
end

if hostname == "rhodes" then
    xrun("owncloud", "owncloud")
    xrun("transmission", "transmission-qt -m")
end
