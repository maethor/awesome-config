local naughty = naughty

local io = io
local os = os
local math = math
local string = string
local tonumber = tonumber

module("maethor/calendar")

local important_color = "#f57900"
local normal_color = "#eeeeec"

local calendar = nil
local offset = 0

function remove_calendar()
   if calendar ~= nil then
      naughty.destroy(calendar)
      calendar = nil
      offset = 0
   end
end

function generate_calendar(offset,today_cl,font)
   today_cl = today_cl or important_color 
   font = font or "monospace"

   local query = os.date("%Y-%m-%d")
   local _, _, cur_year, cur_month, cur_day = string.find(query,"(%d%d%d%d)%-(%d%d)%-(%d%d)")
   cur_month = tonumber(cur_month) + offset
   if cur_month > 12 then
      cur_month = (cur_month % 12) .. "f"
      cur_year = cur_year + 1
   elseif cur_month < 1 then
      cur_month = (cur_month + 12) .. "p"
      cur_year = cur_year - 1
   end
   local cal = io.popen("cal -h -m " .. cur_month):read("*all")
   cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
   local _, _, head, cal = string.find(cal,"(%u[%léû]*%s%d%d%d%d%s*)\n(.+)")

   --local todotext, datearr, leng = create_string(query,event_cl,font)
   --for ii = 1, table.getn(datearr) do
   --   if cur_year == datearr[ii][1] and cur_month == tonumber(datearr[ii][2]) then
   --  cal = string.gsub(cal, "(" .. datearr[ii][3] .."[^f])", 
   --                        '<span weight="bold" foreground = "'..event_cl..'">%1</span>', 1)
   --   end
   --end

   if string.sub(cur_day,1,1) == "0" then
      cur_day = string.sub(cur_day,2)
   end 
   if offset == 0 then
      cal = string.gsub(cal, "(" .. cur_day .."[%s/])", 
                        '<span weight="bold" foreground = "'..today_cl..'">%1</span>', 1)
   end

   cal = head .. "\n" .. cal
   cal = string.format('<span font = "%s">%s</span>', font, cal)
   return cal
end

function add_calendar(inc_offset)
   local save_offset = offset
   remove_calendar()
   offset = save_offset + inc_offset
   local data = generate_calendar(offset)
   calendar = naughty.notify({ title = os.date("%a, %d %B %Y"),
				text = data,
				timeout = 0, --hover_timeout = 0.5,
				--width = 176,
			     })
end


