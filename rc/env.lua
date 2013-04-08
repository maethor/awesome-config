-- The main goal of this file is to put almost everything that might change, like browsers or whatever.

-- Requires 
local io = io
local os = os
local table = table

-- {{{1 Directories
awesome_config = awful.util.getdir("config")
awesome_bins = awesome_config .. "/bin"

-- {{{1 Terminal and Editor 
terminal = "urxvtc"
terminal_full = "/usr/bin/urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal_full .. " -e " .. editor
hostname = awful.util.pread('uname -n'):gsub('\n', '')

-- {{{1 Modkeys 
-- Usually, Mod4 is the 'windows' key, between ctrl and alt
modkey = "Mod4"
modkey2 = "Mod1"

-- {{{1 Table of layouts, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-- {{{1 Beautiful init
beautiful.init(awesome_config .. "/themes/maethor/theme.lua")

-- {{{1 Naughty theming
naughty.config.defaults.font = beautiful.notify_font
naughty.config.defaults.fg = beautiful.notify_fg
naughty.config.defaults.bg = beautiful.notify_bg
naughty.config.defaults.border_color = beautiful.notify_border

-- {{{1 Applications
apps = {
    term = terminal,
    term_full = terminal_full,
    term_tabbed = terminal .. " -pe tabs",
    term_screen = terminal .. " -e screen",
    filemanager = terminal .. " -e ranger",
    music = terminal .. " -pe tabs -name ncmpcpp -T ncmpcpp -e ncmpcpp",
    irc = terminal .. " -name weechat -T weechat -e weechat-curses",
    mail = terminal .. " -name mutt -T mutt -e mutt",
    im = "psi-plus",
    sys = terminal .. " -name htop -T htop -e htop",
    browser = "chromium",
    torrents = "transmission-qt",
    wifi = "/usr/sbin/wpa_gui"
}

if hostname == "rhodes" or hostname == "stark" then
    apps.filemanager = "dolphin"
    apps.browser = "iceweasel"
end

-- {{{1 Useful functions
settings = {}
func = {
    -- Ssh 
    ssh = {
        -- Auto completion for ssh prompt
        -- I'm not sure this works, I've to work on it...
        completion = function (cmd, cur_pos, ncomp)
            -- Get hosts
            local hosts = {}
            f = io.popen('cut -d " " -f1 ' .. os.getenv("HOME") .. '/.ssh/known_hosts | cut -d, -f1')
            for host in f:lines() do
                table.insert(hosts, host)
            end
            f:close()
            
            -- Abord completion under certain circumstances
            if #cmd == 0 or (cur_pos ~= cmd + 1 and cmd:sub(cur_pos, cur_pos) ~= " ") then
                return cmd, cur_pos
            end

            -- match
            local matches = {}
            table.foreach(hosts, function (x)
                if hosts[x]:find("^" .. cmd:sub(1, cur_pos)) then
                    table.insert(matches, hosts[x])
                end
            end)

            -- no matches
            if #matches == 0 then
                return
            end

            -- cycle 
            while ncomp > #matches do
                ncomp = ncomp - #matches
            end

            -- return matches and position
            return matches[ncomp], cur_pos
        end,
    },

    -- Misc
    misc = {
        -- Take a screenshot, requires scrot 
        screenshot = function () awful.util.spawn("scrot -e 'mv $f ~/pics/screenshots/ 2>/dev/null'") end,

        -- Lock screen, requires slock
        lock = function () awful.util.spawn("xscreensaver-command -lock") end,
    },

}
