-- Synaptics
awful.util.spawn_with_shell(awesome_bins .. "/synaptics")

-- Spawn a composoting manager
awful.util.spawn("xcompmgr", false)

-- Keyboard map
awful.util.spawn("xmodmap -e 'keysym Menu = Super_L'")
