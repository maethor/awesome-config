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
theme.fg_urgent   = "#f57900"
theme.fg_minimize = "#f57900"
theme.bg_normal   = "#2e3436"
theme.bg_focus    = "#2e3436"
theme.bg_urgent   = "#2e3436"
theme.bg_minimize = "#2e3436"
theme.bg_systray  = theme.bg_normal

-- Borders
theme.border_width  = "1"
theme.border_normal = "#888a85"
theme.border_focus  = "#d3d7cf"
theme.border_marked = "#CC9393"

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
--theme.layout_tile       = theme.path .. "/icons/layouts/tile.png"
--theme.layout_tileleft   = theme.path .. "/icons/layouts/tileleft.png"
--theme.layout_tilebottom = theme.path .. "/icons/layouts/tilebottom.png"
--theme.layout_tiletop    = theme.path .. "/icons/layouts/tiletop.png"
--theme.layout_fairv      = theme.path .. "/icons/layouts/fairv.png"
--theme.layout_fairh      = theme.path .. "/icons/layouts/fairh.png"
--theme.layout_spiral     = theme.path .. "/icons/layouts/spiral.png"
--theme.layout_dwindle    = theme.path .. "/icons/layouts/dwindle.png"
--theme.layout_max        = theme.path .. "/icons/layouts/max.png"
--theme.layout_fullscreen = theme.path .. "/icons/layouts/fullscreen.png"
--theme.layout_magnifier  = theme.path .. "/icons/layouts/magnifier.png"
--theme.layout_floating   = theme.path .. "/icons/layouts/floating.png"

-- Titlebar
--theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/zenburn/titlebar/close_focus.png"
--theme.titlebar_close_button_normal = "/usr/share/awesome/themes/zenburn/titlebar/close_normal.png"
--
--theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_active.png"
--theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_active.png"
--theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/ontop_focus_inactive.png"
--theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/ontop_normal_inactive.png"
--
--theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_active.png"
--theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_active.png"
--theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/sticky_focus_inactive.png"
--theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/sticky_normal_inactive.png"
--
--theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_active.png"
--theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_active.png"
--theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/floating_focus_inactive.png"
--theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/floating_normal_inactive.png"
--
--theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_active.png"
--theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_active.png"
--theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/zenburn/titlebar/maximized_focus_inactive.png"
--theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/zenburn/titlebar/maximized_normal_inactive.png"

return theme
