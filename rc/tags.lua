local shifty = loadrc("shifty", "shifty")

local tagicon = function(icon)
   if screen.count() > 1 then
      return beautiful.icons .. "/taglist/" .. icon .. ".png"
   end
   return nil
end

--------------
-- Tag list --
--------------

shifty.config.tags = {
    ["main"]  = { position = 1, spawn = apps.term_tabbed, init = true, icon = tagicon("main") },
    ["ssh"]   = { position = 2, spawn = apps.term .. " -name ssh -T ssh -e zsh -c 'ssh subiron.org'" },
    ["www"]   = { position = 3, spawn = apps.browser, nopopup = true, max_clients = 1, icon = tagicon("web") },
    ["xanadu"]= { position = 4, spawn = apps.term .. " -name xanadu -T xanadu -e ssh aquilenet.fr" },
    ["music"] = { position = 5, spawn = apps.music, exclusive = true },
    ["test"]  = { position = 6, spawn = apps.term .. " -T Xephyr -e Xephyr -ac -br -noreset -screen 600x400 :1"},
    ["dl"]    = { position = 7, spawn = apps.torrents},
    ["dev"]   = { position = 8, spawn = "qtcreator", exclusive = true, max_clients = 1 },
    ["net"]   = { position = 9, spawn = apps.wifi, exclusive = true, nopopup = true },
    ["irc"]   = { position = 10, spawn = apps.irc, nopopup = true },
    ["mail"]  = { position = 11, spawn = apps.mail, exclusive = true, nopopup = true },
    ["media"] = { position = 12, nopopup = true,  },
    ["view"]  = { position = 13, nopopup = true,  },
    ["im"]    = { position = 14, spawn = apps.im, exclusive = true, layout = layouts[6] },
    ["sys"]   = { position = 15, spawn = apps.sys, nopopup = true, layout = layouts[3] },
    ["foo"]   = { position = 16, nopopop = true, init = true, },
}

-------------------
-- Clients rules --
-------------------

shifty.config.apps = {
    { match = {"ssh"                                       }, tag = "ssh" },
    { match = {"Iceweasel", "Chromium", "dwb", "midori"    }, tag = "www" } ,
    { match = {"^Shared links on"                          }, float = true, intrusive = true },
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
    { match = {"gpicview","Epdfview", "okular", "gwenview", "evince" }, tag = "view", float = true },
    { match = {"^Download$", "Preferences", "VideoDownloadHelper","Downloads", "Firefox Preferences", }, float = true, intrusive = true },
    { match = { "" }, 
        buttons = awful.util.table.join(
            awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
            awful.button({ modkey }, 1, awful.mouse.client.move),
            awful.button({ modkey }, 3, awful.mouse.client.resize))
    }
}

---------------------
-- Default options --
---------------------

shifty.config.defaults = {
    layout = awful.layout.suit.tile,
    ncol = 1,
    mwfact = 0.50,
    floatBars = false,
}

-----------------
-- Init shifty --
-----------------

shifty.config.taglist = mytaglist
shifty.init()

