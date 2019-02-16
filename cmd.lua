local initmsg = "HOPE-SS aviation System. Jekco™\n"..
                "                         \\   /      \n"..
                "            .\\___-/.\\-___/. \n"..
                "                        ~`-'~      \n"..
                "All Rights Reserved 2066.\n"..
                "Invoke the `help` command to review flight instructions\n"..
                "jryzkns 2019\n"..
                "----------------------------------------------\n\n"

local cmd = {}

cmd.prompt = "Chase@HOPE-SS> " -- this will dynamically change with the narrative

cmd.power = 100
cmd.command = ""
cmd.history = {}
cmd.commands_issued = 0
cmd.command_issued = false
cmd.response = ""
cmd.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",30)
cmd.failedcmd = false
cmd.idle = 0
cmd.response = ""
cmd.distance_covered = 0
cmd.modes = {"NONE","RACE","DODGE"}
cmd.mode = "NONE"

function cmd:textinput(char) cmd.command = cmd.command .. char end
cmd.xdim,cmd.ydim = 0,0
function cmd:getGameState(game) if game.xdim and game.ydim then cmd.xdim, cmd.ydim = game.xdim, game.ydim end end

function cmd:update(dt,frames) cmd.idle = cmd.idle + 1 end

function cmd:keypressed(key,scancode,isrepeat)
        cmd.idle = 0
        if key == "backspace" then cmd.command = cmd.command:sub(1,cmd.command:len()-1) end
        if key == "return" then 
                cmd.commands_issued = cmd.commands_issued + 1
                cmd.history[cmd.commands_issued] = cmd.command

                cmd.command = string.upper(cmd.command)
                if cmd.commandtable[cmd.command] then 
                        cmd.commandtable[cmd.command]()
                        cmd.power = cmd.power - math.random(3,5)
                        cmd.failedcmd = false
                        cmd.command_issued = true
                else
                        cmd.power = cmd.power - 1
                        cmd.failedcmd = true
                        cmd.response = ""
                end
                cmd.command = ""
                local delta = math.random() > 0.5 and 2 or 0
                cmd.distance_covered = cmd.distance_covered + delta
        end
end

cmd.commandtable = {}

function cmd.commandtable:EXIT() love.event.quit() end

function cmd.commandtable:PROPEL()
        if math.random() <= 0.1 then cmd.mode = "RACE" end

        cmd.commandtable:CLEAR()
        local result = (math.random(100) <= cmd.power) and "PROPEL SUCCESS" or "Program received signal SIGSEGV, Segmentation fault"
        cmd.response =  "*ENGAGING ENGINES*\n"..
                        "*ACCESSING ENERGY RESERVES*\n"..
                        "*ENGAGING THRUSTERS*\n"..
                        "***"..result.."***\n"
        cmd.power = cmd.power - 10

        if result == "PROPEL SUCCESS" then
                cmd.distance_covered = cmd.distance_covered + 5
        end
end

function cmd.commandtable:PROSPECT()

        math.random(os.time())

        if math.random() <= 0.1 then cmd.mode = "DODGE" end

        cmd.commandtable:CLEAR()

        local result = math.random() > 0.4 and "EXTRACTION SUCCESS" or "NO APPLICABLE ENERGY SOURCE FOUND, DISENGAGING COLLECTED MATERIAL"

        -- if minerals are found, then start another "minigame" to catch the resources, use the ship's battery system too.
        -- might also run into storm, have to get out without getting hit
        cmd.response =  "*ENGAGING LATERAL NET SYSTEM TO CATCH DECOMPOSTABLE DEBRIS*\n"..
                        "*ANALYZING DEBRIS COMPOSITION*\n"..
                        "***"..result.."***\n"

        if result == "EXTRACTION SUCCESS" then
                cmd.power = cmd.power + math.random(8,20)
        end
end

function cmd.commandtable:CLEAR()
        cmd.history = {}
        cmd.command_issued = 0
        initmsg = ""
        cmd.response = ""
end


function cmd.commandtable:HELP()
        cmd.commandtable:CLEAR()
        cmd.response = "HOPE-SS COMMAND CENTER HELP MANUAL:\n"..
                        "----------------------------------------------\n"..
                        "`CLEAR` to clear terminal window view\n"..
                        "`PROSPECT` to seek around ship for potential resources to gather more energy.\n"..
                        "`PROPEL` to engage engines temporarily, propelling ship forward for a speed boost.\n"..
                        "`EXIT` to exit the terminal.\n"..
                        "----------------------------------------------\n"
end

function cmd:draw()
        local lines = initmsg
        for _,pastcommand in pairs(cmd.history) do lines = lines .. cmd.prompt .. pastcommand .. "\n" end
                lines = lines .. cmd.response .. cmd.prompt .. cmd.command
        love.graphics.setColor(0,0.1,0,1)
        love.graphics.setFont(cmd.font)
        love.graphics.printf(lines.."_\n",0,0,cmd.xdim,"left")
        love.graphics.setColor(1,1,1,1)
end

return cmd