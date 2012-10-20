-- Synaptics
awful.util.spawn_with_shell(awesome_bins .. "/synaptics")

-- Spawn a composoting manager
awful.util.spawn("xcompmgr", false)
