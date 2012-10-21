-----------
-- WIBOX --
-----------

wibox = require("wibox")
vicious = require("vicious")

-- Initialization :
-- Create a wibox for each screen and add it
--------------------------------------------

-- Create a wibox for each screen and add it
mywibox = {}
mylayoutbox = {}
mypromptbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

-- Widgets
--------------

    -- Taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Date & Calendar Widget
    myclock = wibox.widget.textbox()
    vicious.register(myclock, vicious.widgets.date, "%a %d/%m, %R", 60)
    loadrc("orglendar")
    orglendar.files = { "/home/maethor/.orglendar/birthdays.org" }
    orglendar.register(myclock)
    --myclock:connect_signal("mouse::enter", function() orglendar:add_calendar(0) end)
    --myclock:connect_signal("mouse::leave", remove_calendar)
    --myclock:buttons(awful.util.table.join( awful.button({ }, 4, function() add_calendar(-1) end),
    --                                       awful.button({ }, 5, function() add_calendar(1) end),
    --                                       awful.button({ }, 1, function() add_calendar(-1) end),
    --                                       awful.button({ }, 3, function() add_calendar(1) end)))
    
    -- Battery Widget
    loadrc("batterywidget", "maethor/batterywidget")
    batterywidget = battery:create() -- Create battery widget
    batterywidget.path_to_icons = awesome_config.."/lib/battery/icons" 
    batterywidget.critical_notification_timeout = 60
    batterywidget:run() 
    
    -- Memory Widget
    mymem = wibox.widget.textbox()
    vicious.register(mymem, vicious.widgets.mem, "$2MB/$3MB", 13)
    
    -- CPU Widget
    mycpu = wibox.widget.textbox()
    vicious.register(mycpu, vicious.widgets.cpu, "$1%")

    -- Volume Widget
    myvolume = wibox.widget.textbox()
    local volume = loadrc("volume", "maethor/volume")
    vicious.register(myvolume, function() return volume.getvolume() end, "$1", 5)
    --vicious.register(myvolume, vicious.widgets.volume, " $2 $1%", 5, "Master")
     
-- Icons
--------

    myspacer          = wibox.widget.textbox()
    wibox.widget.textbox.set_text(myspacer, " ")

    separator = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(separator, beautiful.icons .. "/widgets/spacer.png")

    right = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(right, beautiful.icons .. "/widgets/right.png")

    left = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(left, beautiful.icons .. "/widgets/left.png")

    dateicon = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(dateicon, beautiful.icons .. "/widgets/clock.png")

    volicon = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(volicon, beautiful.icons .. "/widgets/vol.png")

    memicon = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(memicon, beautiful.icons .. "/widgets/mem.png")

    cpuicon = wibox.widget.imagebox()
    wibox.widget.imagebox.set_image(cpuicon, beautiful.icons .. "/widgets/cpu.png")

-- Launcher
-----------

    --mylauncher = wibox.widget.imagebox()
    --wibox.widget.imagebox.set_image(mylauncher, beautiful.awesome_icon)
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
    --                                { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })


-- Create the wibox
-------------------

    mywibox[s] = awful.wibox({ position = "top", screen = s })
    
    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(myspacer)
    left_layout:add(mypromptbox[s])
    left_layout:add(mylayoutbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(myspacer)
    right_layout:add(left)
    right_layout:add(cpuicon)
    right_layout:add(mycpu)
    right_layout:add(separator)
    right_layout:add(memicon)
    right_layout:add(mymem)
    right_layout:add(separator)
    right_layout:add(volicon)
    right_layout:add(myvolume)
    right_layout:add(separator)
    right_layout:add(batterywidget.widget)
    right_layout:add(separator)
    right_layout:add(dateicon)
    right_layout:add(myclock)
    right_layout:add(right)
    right_layout:add(myspacer)
    right_layout:add(mylauncher)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
