local cmd = {}

cmd.prompt = ">"

cmd.command = ""
cmd.history = {}
cmd.commands_issued = 0
cmd.command_issued = false
cmd.response = ""

function cmd:keypressed(key,scancode,isrepeat)
        if key == "backspace" then cmd.command = cmd.command:sub(1,cmd.command:len()-1) end
        if key == "return" then 
                if cmd.command ~= "" then
                        cmd.commands_issued = cmd.commands_issued + 1
                        cmd.history[cmd.commands_issued] = cmd.command

                        cmd.command = string.upper(cmd.command)
                        -- deal with command table here
                        if cmd.commandtable[cmd.command] then cmd.commandtable[cmd.command]() end
                        
                end
                cmd.command = ""
        end
end

function cmd:textinput(char) cmd.command = cmd.command .. char end

cmd.xdim,cmd.ydim = 0,0
function cmd:getGameState(game) if game.xdim and game.ydim then cmd.xdim, cmd.ydim = game.xdim, game.ydim end end

function cmd:draw()
        local lines = ""
        for _,pastcommand in pairs(cmd.history) do
                lines = lines .. cmd.prompt .. pastcommand .. "\n"
        end
        lines = lines .. cmd.prompt .. cmd.command
        love.graphics.printf(lines,0,0,cmd.xdim,"left")
end

cmd.commandtable = {}
function cmd.commandtable:CLEAR()
        cmd.history = {}
        cmd.command_issued = 0
end

return cmd