local keydoc = loadrc("keydoc", "vbe/keydoc")
local volume = loadrc("volume", "maethor/volume")
local mpc = loadrc("mpc", "maethor/mpc")

--------------------
-- Mouse bindings --
--------------------

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

------------------
-- Key bindings --
------------------

globalkeys = awful.util.table.join(
-- {{{1 Clients

    keydoc.group("Client manipulation"),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end,
        "Focus next window"),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end,
        "Focus previous window"),
    awful.key({ modkey,             }, "u", awful.client.urgent.jumpto, "Jump to next urgent client"),

-- {{{1 Tag manipulation : Shifty

    keydoc.group("Tag manipulation"),
    awful.key({ modkey,             }, "Left",   awful.tag.viewprev, "View previous tag"),
    awful.key({ modkey,             }, "Right",  awful.tag.viewnext, "View next tag"),
    awful.key({ modkey,             }, "Escape", awful.tag.history.restore, "Switch to previous tag"),
    awful.key({ modkey,             }, "t", shifty.add, "Add new tag"),
    awful.key({ modkey,             }, "r", shifty.rename, "Rename tag"),
    awful.key({ modkey,             }, "w", shifty.del, "Delete tag"),
    awful.key({ modkey, "Shift"     }, "Left", shifty.send_prev, "Move client to previous tag"),   -- Move client to previous tag
    awful.key({ modkey, "Shift"     }, "Right", shifty.send_next, "Move client to next tag"),  -- Move client to next tag
    awful.key({ modkey, "Control"   }, "Left", shifty.shift_prev, "Move tag to the left"),  -- Swap tag position with the previous one
    awful.key({ modkey, "Control"   }, "Right", shifty.shift_next, "Move tag to the right"), -- Swap tag position with the next one
    awful.key({ modkey, "Control"   }, "F1", shifty.tagtoscr(1, awful.tag.selected())), -- DO NOT work 
    awful.key({ modkey, "Control"   }, "F2", shifty.tagtoscr(2, awful.tag.selected())), -- DO NOT work
    awful.key({ modkey, "Control"   }, "n",
                function()
                    local t = awful.tag.selected()
                    local s = awful.util.cycle(screen.count(), t.screen + 1)
                    local t2 = shifty.set(t, { screen = s })
                    awful.screen.focus_relative(1)
                    awful.tag.viewonly(t2)
                end,
                "Send tag to next screen"),
    awful.key({ modkey, "Control"   }, "j", function () awful.screen.focus_relative( 1) end, "Jump to next screen"),
    awful.key({ modkey, "Control"   }, "k", function () awful.screen.focus_relative(-1) end, "Jump to previous screen"),


-- {{{1 Layout manipulation : Awful

    keydoc.group("Layout manipulation"),
    awful.key({ modkey, "Shift"     }, "j", function () awful.client.swap.byidx(  1)    end, "Swap with next window"),
    awful.key({ modkey, "Shift"     }, "k", function () awful.client.swap.byidx( -1)    end, "Swap with previous window"),
    awful.key({ modkey,             }, "l", function () awful.tag.incmwfact( 0.05)      end, "Increase master-width factor"),
    awful.key({ modkey,             }, "h", function () awful.tag.incmwfact(-0.05)      end, "Decrease master-width factor"),
    awful.key({ modkey, "Shift"     }, "h", function () awful.tag.incnmaster( 1)        end, "Increase number of masters"),
    awful.key({ modkey, "Shift"     }, "l", function () awful.tag.incnmaster(-1)        end, "Decrease number of masters"),
    awful.key({ modkey, "Control"   }, "h", function () awful.tag.incncol( 1)           end, "Increase number of columns"),
    awful.key({ modkey, "Control"   }, "l", function () awful.tag.incncol(-1)           end, "Decrease number of columns"),
    awful.key({ modkey,             }, "space", function () awful.layout.inc(layouts,  1) end, "Next layout"),
    awful.key({ modkey, "Shift"     }, "space", function () awful.layout.inc(layouts, -1) end, "Previous layout"),
    --awful.key({ modkey, "Control"   }, "n", awful.client.restore),

-- {{{1 Standard program

    keydoc.group("Misc"),
    awful.key({ modkey,             }, "Return", function () awful.util.spawn(apps.term_tabbed) end, "Spawn a tabbed terminal"),
    awful.key({ modkey, "Shift"     }, "Return", function () awful.util.spawn(apps.term_screen) end, "Spawn screen in a terminal"),
    awful.key({ modkey, "Control"   }, "Return", function () awful.util.spawn(apps.filemanager) end, "Spawn a filemanager"),
    awful.key({ modkey, "Control"   }, "r", awesome.restart, "Restart awesome"),
    awful.key({ modkey, "Shift"     }, "q", awesome.quit, "Quit awesome"),

-- {{{1 Sound

    awful.key({ }, "XF86AudioRaiseVolume", function () volume.increase() end),
    awful.key({ }, "XF86AudioLowerVolume", function () volume.decrease() end),
    awful.key({ }, "XF86AudioMute", function () volume.toggle() end),
    awful.key({ }, "XF86AudioStop", function () volume.toggle() end),

-- {{{1 Useful keybindings

    -- Take a screenshot
    awful.key({ modkey,             }, "Print", func.misc.screenshot, "Screenshot"),
    -- Open system monitoring
    awful.key({                     }, "#156", function () awful.util.spawn(apps.sys)end, "Open monitoring"),

    -- Mpd functions
    awful.key({ modkey,             }, "p", function () mpc.play_pause() end, "MPC pause"),
    awful.key({ modkey, "Shift"     }, "p", function () mpc.notify() end, "MPC notify"),
    --awful.key({ modkey, "Control"   }, "p", vol_high_low(), "MPC toogle volume"),
    awful.key({ modkey,             }, "<", function () mpc.prev_track() end, "MPC previous track"),
    awful.key({ modkey, "Shift"     }, "<", function () mpc.next_track() end, "MPC next track"),

    awful.key({ }, "XF86AudioPlay", function () mpc.play_pause() end),
    awful.key({ }, "XF86AudioPrev", function () mpc.prev_track() end),
    awful.key({ }, "XF86AudioNext", function () mpc.next_track() end),

    -- Lock screen
    awful.key({ modkey2, "Control"  }, "l", func.misc.lock, "Lock screen"),

    -- Display
    awful.key({                     }, "XF86Display", xrandr, "Change Display"),

-- {{{1 Help

    -- Keydoc
    keydoc.group("Help"),
    awful.key({ modkey, "Shift" }, "F1", function() keydoc.display("Help") end, "Display this help"),
    awful.key({ modkey, "Shift" }, "F2", function() keydoc.display("Misc") end, "Misc commands"),
    awful.key({ modkey, "Shift" }, "F3", function() keydoc.display("Tag manipulation") end, "Tags commands"),
    awful.key({ modkey, "Shift" }, "F4", function() keydoc.display("Client manipulation") end, "Clients commands"),
    awful.key({ modkey, "Shift" }, "F5", function() keydoc.display("Layout manipulation") end, "Layout commands"),
    awful.key({ modkey, "Shift" }, "F6", function() keydoc.display("Prompts") end, "Prompts commands"),
    awful.key({ modkey, "Shift" }, "F12", keydoc.display, "Display complete help"),

-- {{{1 Prompts

    keydoc.group("Prompts"),
    awful.key({ modkey,             }, "BackSpace",
        function () 
            mypromptbox[mouse.screen]:run() 
        end,
        "Run command"
    ),

     -- Ssh prompt (Mod4 + <F1>)
    awful.key({ modkey,             }, "F1",
        function ()
            awful.prompt.run({ prompt = "Ssh server: " },
            mypromptbox[mouse.screen].widget,
            function (name)
                awful.util.spawn(apps.term .. " -T ssh -e zsh -c 'ssh " .. name .. "'")
            end,
            function (cmd, cur_pos, ncomp)
                func.ssh.completion(cmd, cur_pos, ncomp)
            end,
            awful.util.getdir("cache") .. "/ssh/history")
        end,
        "Ssh prompt"
    ),
   
    -- Manual prompt (Mod4 + <F2>)
    awful.key({ modkey,             }, "F2",
        function ()
            awful.prompt.run({ prompt = "Manual: " },
            mypromptbox[mouse.screen].widget,
            function (name)
                awful.util.spawn(apps.term .. " -T man -e man " .. name)
            end,
            awful.completion.shell,
            awful.util.getdir("cache") .. "/man/history")
        end,
        "Man prompt"
    ),

    -- Command prompt (Mod4 + <F3>)
    awful.key({ modkey,             }, "F3",
        function ()
            awful.prompt.run({ prompt = "Run command: " },
            mypromptbox[mouse.screen].widget,
            function (name)
                awful.util.spawn(apps.term .. " -T " .. name .. " -e " .. name)
            end,
            awful.completion.shell,
            awful.util.getdir("cache") .. "/cmd/history")
        end,
        "Run command"
    ),

    -- Lua prompt (Mod4 + <F4>)
    awful.key({ modkey,             }, "F4",
        function ()
            awful.prompt.run({ prompt = "Run Lua code: " },
            mypromptbox[mouse.screen].widget,
            awful.util.eval, nil,
            awful.util.getdir("cache") .. "/history_eval")
        end,
        "Run Lua code"
    ),

    --Google Search
    awful.key({ modkey }, "F5", function ()
        awful.prompt.run({ prompt = "Google It: " }, mypromptbox[mouse.screen].widget,
            function (command)
                awful.util.spawn(apps.browser .. " 'http://www.google.com/search?q=" .. command .. "'", false)
                if tags[mouse.screen][3] then awful.tag.viewonly(tags[mouse.screen][3]) end
            end)
    end, "Google search"),

    --Wikipedia Search
    awful.key({ modkey }, "F6", function ()
        awful.prompt.run({ prompt = "Wikipedia: " }, mypromptbox[mouse.screen].widget,
            function (command)
                awful.util.spawn(apps.browser .. " 'http://fr.wikipedia.org/wiki/" .. command .. "'", false)
                if tags[mouse.screen][3] then awful.tag.viewonly(tags[mouse.screen][3]) end
            end)
    end, "Wikipedia search"),

    --WebSearch
    awful.key({ modkey }, "F7", function ()
        awful.prompt.run({ prompt = "Web: " }, mypromptbox[mouse.screen].widget,
            function (url)
                awful.util.spawn(apps.browser .. " " .. url, false)
                if tags[mouse.screen][3] then awful.tag.viewonly(tags[mouse.screen][3]) end
            end)
    end, "Browse")
-- }}}
)

-- {{{1 Manage tags with Mod4+[1-9]

for i=10,19 do
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, "#" ..i,
    function ()
        local t = awful.tag.viewonly(shifty.getpos(i-9))
    end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, "#" ..i,
    function ()
        local t = shifty.getpos(i-9)
        t.selected = not t.selected
    end))
    globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, "#" ..i,
    function ()
        if client.focus then
            local t = shifty.getpos(i-9)
            awful.client.movetotag(t)
            awful.tag.viewonly(t)
        end
    end))
end

-- {{{1 Client keys

clientkeys = awful.util.table.join(
    keydoc.group("Client manipulation"),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end, "Fullscreen"),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end, "Close"),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle, "Toggle floating"),
    awful.key({ modkey, "Control" }, "m", function (c) c:swap(awful.client.getmaster()) end, "Switch with master window"),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end, "Raise window"),
    awful.key({ modkey,           }, "i",      dbg, "Get client-related information"),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end, "Minimize"),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end, "Maximise")
)
-- }}}

keydoc.group("Misc")

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

--------------
-- Set keys --
--------------

root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys

