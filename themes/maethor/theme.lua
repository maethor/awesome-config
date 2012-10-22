----------------------------------------------------------
--  "Maethor" awesome-git theme  --  Based on "Zenburn" --
----------------------------------------------------------

local na = awful.util.color_strip_alpha

-- Main
theme = {}
theme.wallpaper = "/usr/share/awesome/themes/default/background.png"
theme.font      = "Profont 8"
theme.path = awful.util.getdir("config").."/themes/maethor"
theme.icons = theme.path .. "/icons"

-- Colors
theme.fg_normal   = "#eeeeec"
theme.fg_focus    = "#73d216"
theme.fg_important= "#f57900"
theme.fg_urgent   = "#ef2929"
theme.fg_minimize = "#f57900"
theme.bg_normal   = "#2e3436"
theme.bg_focus    = theme.bg_normal
theme.bg_urgent   = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray  = theme.bg_normal

-- Borders
theme.border_width  = "1"
theme.border_normal = "#888a85"
theme.border_focus  = "#d3d7cf"
theme.border_marked = "#CC9393"

-- Widget stuff
theme.bg_widget        = na(theme.bg_normal)
theme.fg_widget_label  = "#737d8c"
theme.fg_widget_value  = na(theme.fg_normal)
theme.fg_widget_value_important  = na(theme.fg_important)
theme.fg_widget_border = theme.fg_widget_label
naughty.config.presets.normal.bg = theme.bg_widget

-- Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"

-- Mouse finder
theme.mouse_finder_color = "#CC9393"

-- Menu
theme.menu_height = 15
theme.menu_width  = 100

-- Icons
theme.taglist_squares_sel    = theme.path.."/taglist/squarefz.png"
theme.taglist_squares_unsel  = theme.path.."/taglist/squarez.png"
theme.awesome_icon           = "/usr/share/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"

-- Layout
for _, l in pairs(layouts) do
   theme["layout_" .. l.name] = theme.icons .. "/layouts/" .. l.name .. ".png"
end

return theme
