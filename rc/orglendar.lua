-- Calendar with Emacs org-mode agenda for Awesome WM
-- Inspired by and contributed from the org-awesome module, copyright of Damien Leone
-- Licensed under GPLv2
-- @author Alexander Yakushev <yakushev.alex@gmail.com>
-- @improved by Guillaume Subiron <maethor+awesome@subiron.org>

--TODO Bug : taille retournée par parse_agenda
--TODO Bug : Tomorrow ne s'affiche jamais, probablement un problème de typage String - Int
--TODO Bug : Seuls les TODO du mois actuel apparaissent dans le calendrier
--TODO Bug : Les TODO ne sont pas dans l'ordre chronologique 
--TODO Idée : Afficher les TODO du mois que l'on regarde
--TODO Idée : Icone sur TODO list

--TODO Improvement : Gérer VRAIMENT la syntaxe de orgmode - http://orgmode.org/
--TODO Improvement : Autre solution, ne plus utiliser org, mais lua ! Parsing beaucoup plus simple, beaucoup plus de possibilités

--module("maethor/orglendar")

orglendar = {}

local naughty = naughty

-- Default user options
orglendar.files = {}
orglendar.todo_title = "TODO list"
orglendar.today_color = "#00FF00"
orglendar.tomorrow_color = "#AA0000"
orglendar.tasks_color = "#AA0000"
orglendar.today = "TODAY"
orglendar.tomorrow = "Tomorrow"
orglendar.period = 604800 -- In seconds : 1 week

local function parse_agenda(today)
   local result = {}
   local dates = {}
   local maxlen = 20
   local task_name
   local category_name
   local new_category_name
   local category = {}
   for _, file in pairs(orglendar.files) do
      local fd = io.open(file, "r")
      for line in fd:lines() do
         local scheduled = string.find(line, "SCHEDULED:")
         local closed    = string.find(line, "CLOSED:")
         local deadline  = string.find(line, "DEADLINE:")
         
         if new_category_name then
             if category_name then
                local len = string.len(category_name)
                if (len > maxlen) then
                     maxlen = len
                end
                table.insert(result, { name = category_name, tasks = category }) 
                category = {}
             end
             category_name = new_category_name
         end

         if (scheduled and not closed) or (deadline and not closed) then
            local _, _, y, m, d  = string.find(line, "(%d%d%d%d)%-(%d%d)%-(%d%d)")
            local task_date = y .. "-"  .. m .. "-" .. d
            
            if d and task_name and (task_date >= today) then 
               local find_begin, task_start = string.find(task_name, "[A-Z]*%s+")
               if task_start and find_begin == 1 then
                  task_name = string.sub(task_name, task_start + 1)
               end
               local task_end, _, task_tags = string.find(task_name,"%s+(:.+):")
               if task_tags then
                  task_name = string.sub(task_name, 1, task_end - 1)
               else
                  task_tags = " "
               end            
               
               local len = string.len(task_name) + string.len(task_tags)
               if (len > maxlen) and (task_date >= today) then
                  maxlen = len
               end

               table.insert(category, { name = task_name, 
                                        tags = task_tags,
                                        date = task_date,
                                        d = d,
                                        m = m,
                                        y = y })
               if string.sub(d,1,1) == "0" then
                  d = string.sub(d,2,2)
               end
               table.insert(dates,{ y, m, d})
            end
         end
         _, _, task_name = string.find(line, "^%*%*%s+(.+)")
         _, _, new_category_name = string.find(line, "^%*%s+(.+)")
      end
      if category_name then
        local len = string.len(category_name)
        if (len > maxlen) then
             maxlen = len
        end
        table.insert(result, { name = category_name, tasks = category }) 
      end
   end
   for _, tasks in ipairs(result) do
      table.sort(tasks, function (a, b) return a.date < b.date end)
   end
   return result, maxlen, dates
end

function create_string(today,date_cl,font)
   date_cl = date_cl or orglendar.tomorrow_color
   font = font or "monospace"
   local todos, ml, dates = parse_agenda(today)
   local result = ""
   for _, todo in ipairs(todos) do
       local prev_date
       result = result .. '\n<span weight = "bold">» ' .. todo.name .. '</span>' .. "\n"
       for _, task in ipairs(todo.tasks) do
            if task.date <= os.date("%Y-%m-%d", os.time() + orglendar.period ) then
                if prev_date ~= task.date then
                   -- Cool date display
                   if task.d == os.date("%d") and task.m == os.date("%m") and task.y == os.date("%Y") then
                       task_date = orglendar.today
                   elseif (task.d - 1) == os.date("%d") and task.m == os.date("%m") and task.y == os.date("%Y") then -- Ne marche pas le dernier jour du mois
                       task_date = orglendar.tomorrow
                   else
                       task_date = task.d .. "/" .. task.m .. "/" .. task.y 
                   end
                   result = result .. '<span weight = "bold" foreground = "'..date_cl..'">' .. 
                      pop_spaces("",task_date,ml+3) .. '</span>' .. "\n"
                end
                result = result .. pop_spaces(task.name,task.tags,ml+3) .. "\n"
                prev_date = task.date
            end
       end
   end
   return '<span font="'..font..'">' .. string.sub(result,1,string.len(result)-1) .. '</span>', dates, ml+3
end

function pop_spaces(s1,s2,maxsize)
   local sps = ""
   for i = 1, maxsize-string.len(s1)-string.len(s2) do
      sps = sps .. " "
   end
   return s1 .. sps .. s2
end

function center(s, maxsize)
   local sps = ""
   for i = 1, (maxsize-string.len(s))/2 do
      sps = sps .. " "
   end
   return sps .. s .. sps
end

local calendar = nil
local offset = 0

local function remove_calendar()
   if calendar ~= nil then
      naughty.destroy(calendar)
      naughty.destroy(todo)
      calendar = nil
      offset = 0
   end
end

function generate_calendar(offset,today_cl,event_cl,font)
   today_cl = today_cl or orglendar.today_color
   event_cl = event_cl or orglendar.tomorrow_color
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
   local cal = awful.util.pread("cal -h -m " .. cur_month)
   cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
   local _, _, head, cal = string.find(cal,"(%u[%léû]*%s%d%d%d%d%s*)\n(.+)")

   local todotext, datearr, leng = create_string(query,event_cl,font)
   for ii = 1, table.getn(datearr) do
      if cur_year == datearr[ii][1] and cur_month == tonumber(datearr[ii][2]) then
	 cal = string.gsub(cal, "(" .. datearr[ii][3] .."[^f])", 
                           '<span weight="bold" foreground = "'..event_cl..'">%1</span>', 1)
      end
   end

   if string.sub(cur_day,1,1) == "0" then
      cur_day = string.sub(cur_day,2)
   end 
   if offset == 0 then
      cal = string.gsub(cal, "(" .. cur_day .."[%s/])", 
                        '<span weight="bold" foreground = "'..today_cl..'">%1</span>', 1)
   end

   cal = head .. "\n" .. cal
   cal = string.format('<span font = "%s">%s</span>', font, cal)
   return { calendar = cal, todo = todotext, length = leng }
end

function add_calendar(inc_offset)
   local save_offset = offset
   remove_calendar()
   offset = save_offset + inc_offset
   local data = generate_calendar(offset)
   calendar = naughty.notify({ title = os.date("%a, %d %B %Y"),
				text = data.calendar,
				timeout = 0, --hover_timeout = 0.5,
				--width = 176,
			     })
   todo = naughty.notify({ title = center(orglendar.todo_title, data.length),
			   text = data.todo,
			   timeout = 0, --hover_timeout = 0.5,
			   --width = data.length * 7,
			})
end

function orglendar.register(widget)
   widget:connect_signal("mouse::enter", function()
                                            add_calendar(0)
                                         end)
   widget:connect_signal("mouse::leave", remove_calendar)
   
   widget:buttons(awful.util.table.join( awful.button({ }, 4, function()
                                                                  add_calendar(-1)
                                                              end),
                                         awful.button({ }, 5, function()
                                                                  add_calendar(1)
                                                              end),
                                         awful.button({ }, 1, function()
                                                                  add_calendar(-1)
                                                              end),
                                         awful.button({ }, 3, function()
                                                                  add_calendar(1)
                                                              end)))
end
