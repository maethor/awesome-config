----------------------------------------------------------
-- Licensed under GPLv2
-- @author Guillaume Subiron <maethor+awesome@subiron.org>
----------------------------------------------------------

battery = {}

local naughty = naughty
local vicious = vicious
local format = string.format
local wibox = wibox

function battery:create()
    -- Initialization
    instance = {}
    setmetatable(instance,self)
    self.__index = self
    instance.widget = wibox.widget.textbox()
    instance.popup = nil
    instance.level = -1 -- -2 = No Battery; -1 = Fully Charged; 0 = AC plugged; 1 = AC unplugged; 2 = Battery < 15%; 3 = Battery < 5%;

    -- Default user options
    instance.battery_name = "BAT0"           -- Battery name (for vicious' bat widget)
    instance.update_interval = 30            -- Update interval, in seconds
    instance.path_to_icons = ""              -- Path to icons directory (usually ~/.config/awesome/battery/icons)
    instance.icons_size = 32                 -- Icons size : 32 is great because it takes precisely 2 line, as text
    instance.notification_title = "Battery"  -- Notification's title
    instance.notification_timeout = 5        -- Notification's timeout in seconds

    instance.warning_message      = "Battery level is under "
    instance.critical_message     = "WARNING : Battery level is now under "
    instance.plugged_message      = "AC is plugged. Battery is charging."
    instance.fullycharged_message = "Battery is fully charged !"
    instance.unplugged_message    = "AC adapter is unplugged."
    instance.nobattery_message    = "No battery found."

    instance.warning_level  = 15  -- Battery warning level, in percent
    instance.critical_level = 5   -- Battery critical level, in percent
    instance.warning_notification_timeout  = 5  -- Timeout of warning notification, in seconds
    instance.critical_notification_timeout = 5  -- Timeout of critical notification, in seconds

    instance.warning_color      = "#edd400"
    instance.critical_color     = "#ef2929"
    instance.fullycharged_color = "#8ae234"
    instance.plugged_color      = "#fce94f"

    instance.prefix = '<b>ϟ</b>'


    return instance
end

function battery:run()
    vicious.register(self.widget, vicious.widgets.bat, function (widget, args)
        ----------------
        -- No Battery --
        ----------------
        if args[1] == "⌁" then
            if self.level > -2 then
                self:add_popup(self.nobattery_message, self.notification_timeout, self.path_to_icons .. "/caution.png")
                self.level = -2
            end
            return self.prefix.." N/A"

        ------------------------
        -- AC Adapter plugged --
        ------------------------
        elseif args[1] == "+" then
            if self.level > 0 then
                self:add_popup(self.plugged_message, self.notification_timeout, self.path_to_icons .. "/charging.png")
                self.level = 0
            end
            return "<span color='"..self.plugged_color.."'>"..self.prefix.."</span> "..args[2].."% - "..args[3]

        -------------------
        -- Fully Charged --
        -------------------
        elseif args[1] == "↯" and args[2] == 100 then
            if self.level > -1 then  -- Uncomment if you don't want repetition
                self:add_popup(self.fullycharged_message, self.notification_timeout, self.path_to_icons .. "/battery.png")
                self.level = -1
            end
            return "<span color='"..self.plugged_color.."'>"..self.prefix.."</span> <span color='"..self.fullycharged_color.."'>"..args[2].."% - "..args[3].."</span>"
            
        --------------------------
        -- AC Adapter unplugged --
        --------------------------
        else 
            if self.level < 1 then
                self:add_popup(self.unplugged_message, self.notification_timeout, self.path_to_icons .. "/battery.png")
                self.level = 1
            end
        end

        local cap = args[2].."% - "..args[3]
        -- Battery < warning_level
        if args[2] <= self.warning_level then
            if self.level < 2 then
                self:add_popup(self.warning_message..tostring(self.warning_level).."%.", self.warning_notification_timeout, self.path_to_icons .. "/warning.png")
                self.level = 2
            end
            cap = "<span color='"..self.warning_color.."'>"..cap.."</span>"
        end
        
        --Battery < critical_level
        if args[2] <= self.critical_level then
            if self.level < 3 then
                self:add_popup(self.critical_message..tostring(self.critical_level).."% !", self.critical_notification_timeout, self.path_to_icons .. "/urgent.png")
                self.level = 3
            end
            cap = "<span color='"..self.critical_color.."'>"..cap.."</span>"
        end

        return self.prefix.." "..cap
    end, self.update_interval, self.battery_name)
end

function battery:add_popup(popup_text, popup_timeout, popup_image)
   if self.popup ~= nil then
      naughty.destroy(self.popup)
      self.popup = nil
   end
   self.popup = naughty.notify({ title      = self.notification_title
					, text       = popup_text
					, timeout    = popup_timeout
					, position   = "top_right"
                                        , icon       = popup_image
                                        , icon_size  = self.icons_size,
				     })
end

module("maethor/batterywidget")

