awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
beautiful = require("beautiful")
naughty = require("naughty")
gears = require("gears")

-- {{{ Simple function to load additional LUA files from rc/.
function loadrc(name, mod)
   local success
   local result

   -- Which file? In rc/ or in lib/?
   local path = awful.util.getdir("config") .. "/" ..
      (mod and "lib" or "rc") ..
      "/" .. name .. ".lua"

   -- If the module is already loaded, don't load it again
   if mod and package.loaded[mod] then return package.loaded[mod] end

   -- Execute the RC/module file
   success, result = pcall(function() return dofile(path) end)
   if not success then
      naughty.notify({ title = "Error while loading an RC file",
		       text = "When loading `" .. name ..
			  "`, got the following error:\n" .. result,
		       preset = naughty.config.presets.critical
		     })
      return print("E: error loading RC file '" .. name .. "': " .. result)
   end

   -- Is it a module?
   if mod then
      print("Module '"..name.."' loaded")
      return package.loaded[mod]
   end

   return result
end
-- }}}

loadrc("errors")		-- errors and debug stuff
loadrc("xrun")
loadrc("env")           -- global config & variables
loadrc("debug")         -- debugging primitive dbg()
loadrc("start")         -- programs to run on start
loadrc("wallpaper")     -- wallpaper settings
loadrc("topbar")        -- topbar configuration
loadrc("tags")          -- tags handling
loadrc("xrandr")        -- xrandr handling
loadrc("bindings")      -- key bindings
loadrc("rules")         -- window rules
loadrc("signals")       -- window manager behaviour

