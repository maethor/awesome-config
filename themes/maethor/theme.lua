----------------------------------------------------------
--  "Maethor" awesome-git theme  --  Based on "Zenburn" --
----------------------------------------------------------

local na = awful.util.color_strip_alpha

-- Main
theme = {}
theme.wallpaper = "/usr/local/share/awesome/themes/default/background.png"
theme.font      = "Profont 8"
theme.path = awful.util.getdir("config").."/themes/maethor"
theme.icons = theme.path .. "/icons"

-- Plalette : from my Vim theme
theme.palette = {}
theme.palette.plain         = "#f8f6f2"
theme.palette.snow          = "#ffffff"
theme.palette.coal          = "#000000"
theme.palette.brightgravel  = "#d9cec3"
theme.palette.lightgravel   = "#998f84"
theme.palette.gravel        = "#857f78"
theme.palette.mediumgravel  = "#666462"
theme.palette.deepgravel    = "#45413b"
theme.palette.deepergravel  = "#35322d"
theme.palette.darkgravel    = "#242321"
theme.palette.blackgravel   = "#1c1b1a"
theme.palette.blackestgravel= "#141413"
theme.palette.dalespale     = "#fade3e"
theme.palette.dirtyblonde   = "#f4cf86"
theme.palette.taffy         = "#ff2c4b" -- red
theme.palette.saltwatertaffy= "#8cffba" -- use sparingly!
theme.palette.tardis        = "#0a9dff" -- blue
theme.palette.orange        = "#ffa724"
theme.palette.lime          = "#aeee00" -- limier green
theme.palette.dress         = "#ff9eb8" -- rose
theme.palette.toffee        = "#b88853" -- brown
theme.palette.coffee        = "#c7915b" -- brown
theme.palette.darkroast     = "#88633f" -- brown


-- Colors
theme.fg_normal   = theme.palette.plain
theme.fg_focus    = theme.palette.tardis
theme.fg_urgent   = theme.palette.taffy
theme.fg_important= theme.palette.orange
theme.fg_minimize = theme.palette.gravel
theme.bg_normal   = theme.palette.blackgravel
theme.bg_focus    = theme.bg_normal
theme.bg_urgent   = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray  = theme.bg_normal

-- Borders
theme.border_width  = "1"
theme.border_normal = theme.palette.deepgravel
theme.border_focus  = theme.palette.tardis
theme.border_marked = theme.palette.taffy

-- Widget stuff
theme.bg_widget        = na(theme.bg_normal)
theme.fg_widget_label  = theme.palette.mediumgravel
theme.fg_widget_value  = na(theme.fg_normal)
theme.fg_widget_value_important  = na(theme.fg_important)
theme.fg_widget_border = theme.fg_widget_label
naughty.config.presets.normal.bg = theme.bg_widget

-- Titlebars
theme.titlebar_bg_focus  = theme.palette.tardis
theme.titlebar_bg_normal = theme.palette.deepergravel

-- Mouse finder
theme.mouse_finder_color = "#CC9393"

-- Menu
theme.menu_height = 15
theme.menu_width  = 100

-- Icons
theme.taglist_squares_sel    = theme.path.."/taglist/squarefz.png"
theme.taglist_squares_unsel  = theme.path.."/taglist/squarez.png"
theme.awesome_icon           = "/usr/local/share/awesome/themes/zenburn/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/local/share/awesome/themes/default/submenu.png"

-- Layout
for _, l in pairs(layouts) do
   theme["layout_" .. l.name] = theme.icons .. "/layouts/" .. l.name .. ".png"
end

return theme
