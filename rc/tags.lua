local shifty = loadrc("shifty", "shifty")

local tagicon = function(icon)
   if screen.count() > 1 then
      return beautiful.icons .. "/taglist/" .. icon .. ".png"
   end
   return nil
end

-- {{{1 Tag list
----------------

shifty.config.tags = {
    ["main"]  = { position = 1, spawn = apps.term_tabbed, init = true },
    ["ssh"]   = { position = 2, spawn = apps.term .. " -name ssh -T ssh -e zsh -c 'ssh subiron.org'" },
    ["www"]   = { position = 3, spawn = apps.browser, nopopup = true },
    ["dev"]   = { position = 4, spawn = apps.term_tabbed .. "&&" .. apps.term_tabbed, nmaster = 3, layout = awful.layout.suit.tile.top },
    ["music"] = { position = 5, spawn = apps.music, exclusive = true },
    ["test"]  = { position = 6, spawn = apps.term .. " -T Xephyr -e Xephyr -ac -br -noreset -screen 600x400 :1"},
    ["dl"]    = { position = 7, spawn = apps.torrents},
    ["mail"]  = { position = 8, spawn = apps.mail, exclusive = true },
    ["net"]   = { position = 9, spawn = apps.wifi, exclusive = true },
    ["irc"]   = { position = 10, spawn = apps.irc },
    ["xanadu"]= { position = 11, spawn = apps.term .. " -name xanadu -T xanadu -e ssh aquilenet.fr" },
    --["dev"]   = { position = 11, spawn = "qtcreator", exclusive = true, max_clients = 1 },
    ["im"]    = { position = 12, spawn = apps.im, exclusive = true, layout = layouts[6] },
    ["sys"]   = { position = 13, spawn = apps.sys, layout = layouts[3] },
    ["foo"]   = { position = 14, nopopop = true, init = true, },
    ["media"] = { position = 15 },
    ["view"]  = { position = 16 },
    ["ftp"]   = { position = 17, spawn = apps.ftp },
}

-- {{{1 Clients rules
---------------------

shifty.config.apps = {
    { match = {"^ssh"                                       }, tag = "ssh" },
    { match = {"Iceweasel", "Chromium", "dwb", "midori"    }, tag = "www" } ,
    { match = {"^Shared links on", "Liens en vrac"         }, float = true, intrusive = true },
    { match = {"KTorrent", "Transmission"                  }, tag = "dl" },
    { match = {"vlc", "MPlayer", "ffplay"                  }, tag = "media" },
    { match = {"mpc"                                       }, tag = "music" },
    { match = {"xanadu"                                    }, tag = "xanadu" },
    { match = {"wpa_gui"                                   }, tag = "net" },
    { match = {"WeeChat 0.2.6","weechat-curses","weechat"  }, tag = "irc" },
    { match = {"man","qtcreator"                           }, tag = "dev", float = false },
    { match = {"mutt", "Mutt"                              }, tag = "mail" },
    { match = {"Psi", "psi"                                }, tag = "im" },
    { match = {"htop", "powertop"                          }, tag = "sys" },
    { match = {"Xephyr"                                    }, tag = "test" },
    { match = {"gpicview","Epdfview", "okular", "gwenview", "evince" }, tag = "view" },
    { match = {"^Download$", "Preferences", "VideoDownloadHelper","Downloads", "Firefox Preferences", }, float = true, intrusive = true },
    { match = { "" }, 
        buttons = awful.util.table.join(
            awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
            awful.button({ modkey }, 1, awful.mouse.client.move),
            awful.button({ modkey }, 3, awful.mouse.client.resize))
    }
}

-- {{{1 Default options
-----------------------

shifty.config.defaults = {
    layout = awful.layout.suit.tile,
    ncol = 1,
    mwfact = 0.50,
    floatBars = false,
}

-- {{{1 Init shifty
-------------------

shifty.config.taglist = mytaglist
shifty.init()

