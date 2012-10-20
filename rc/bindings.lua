local keydoc = loadrc("keydoc", "vbe/keydoc")

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
    keydoc.group("Focus"),
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

-- Tag manipulation : Shifty
----------------------------

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

-- Layout manipulation : Awful
------------------------------

    keydoc.group("Layout manipulation"),
    awful.key({ modkey, "Shift"     }, "j", function () awful.client.swap.byidx(  1)    end, "Swap with next window"),
    awful.key({ modkey, "Shift"     }, "k", function () awful.client.swap.byidx( -1)    end, "Swap with previous window"),
    awful.key({ modkey, "Control"   }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control"   }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,             }, "l", function () awful.tag.incmwfact( 0.05)      end, "Increase master-width factor"),
    awful.key({ modkey,             }, "h", function () awful.tag.incmwfact(-0.05)      end, "Decrease master-width factor"),
    awful.key({ modkey, "Shift"     }, "h", function () awful.tag.incnmaster( 1)        end, "Increase number of masters"),
    awful.key({ modkey, "Shift"     }, "l", function () awful.tag.incnmaster(-1)        end, "Decrease number of masters"),
    awful.key({ modkey, "Control"   }, "h", function () awful.tag.incncol( 1)           end, "Increase number of columns"),
    awful.key({ modkey, "Control"   }, "l", function () awful.tag.incncol(-1)           end, "Decrease number of columns"),
    awful.key({ modkey,             }, "space", function () awful.layout.inc(layouts,  1) end, "Next layout"),
    awful.key({ modkey, "Shift"     }, "space", function () awful.layout.inc(layouts, -1) end, "Previous layout"),
    awful.key({ modkey, "Control"   }, "n", awful.client.restore),
    awful.key({ modkey,             }, "u", awful.client.urgent.jumpto),

-- Standard program
-------------------

    keydoc.group("Misc"),
    awful.key({ modkey,             }, "Return", function () awful.util.spawn(apps.term) end, "Spawn a terminal"),
    awful.key({ modkey, "Shift"     }, "Return", function () awful.util.spawn(apps.term_tabbed) end, "Spawn a tabbed terminal"),
    awful.key({ modkey, "Control"   }, "Return", function () awful.util.spawn(apps.filemanager) end, "Spawn a filemanager"),
    awful.key({ modkey, "Control"   }, "r", awesome.restart, "Restart awesome"),
    awful.key({ modkey, "Shift"     }, "q", awesome.quit, "Quit awesome"),

-- Sound
--------

    --awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 2dB+") end),
    --awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 2dB-") end),
    --awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -q sset Master toogle") end),
    awful.key({ }, "XF86AudioRaiseVolume", function () volume.setvolume("up") end),
    awful.key({ }, "XF86AudioLowerVolume", function () volume.setvolume("down") end),
    awful.key({ }, "XF86AudioMute", function () volume.setvolume("mute") end),
    awful.key({ modkey2, "Control" }, "l", function () awful.util.spawn("xscreensaver-command -lock") end),
   
-- Prompts
----------

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
    end, "Browse"),

-- Useful keybindings
---------------------

    -- Take a screenshot
    awful.key({ modkey,             }, "Print", func.misc.screenshot),
    -- Open system monitoring
    awful.key({                     }, "#156", function () awful.util.spawn(apps.sys)end),

    -- Mpd functions
    awful.key({ modkey,             }, "p", func.mpd.play_pause),
    awful.key({ modkey, "Shift"     }, "p", func.mpd.notify),
    awful.key({ modkey, "Control"   }, "p", func.mpd.vol_high_low),
    awful.key({ modkey,             }, "<", func.mpd.prev),
    awful.key({ modkey, "Shift"     }, "<", func.mpd.next),

    -- Keydoc
    awful.key({ modkey, "Shift"     }, "F1", keydoc.display),

    -- Lock screen
    awful.key({                     }, "#252", func.misc.lock)
)

-- Manage tags with Mod4+[1-9]
------------------------------

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

-- Client keys
--------------

clientkeys = awful.util.table.join(
    keydoc.group("Window-specific bindings"),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end, "Fullscreen"),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end, "Close"),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle, "Toggle floating"),
    awful.key({ modkey, "Control" }, "m", function (c) c:swap(awful.client.getmaster()) end, "Switch with master window"),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end, "Raise window"),
    awful.key({ modkey,           }, "i",      dbg, "Get client-related information"),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, "Minimize"),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end, "Maximise")
)

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

