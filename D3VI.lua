local D3VI = {}

local lines = nil
local anger = "LISTEN TO ME"

D3VI.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",50) 

D3VI.xdim,D3VI.ydim = 0,0
function D3VI:getGameState(game) if game.xdim and game.ydim then D3VI.xdim, D3VI.ydim = game.xdim, game.ydim end end

D3VI.platform = love.graphics.newImage("platform.png")
D3VI.x,D3VI.y = 900,230
D3VI.internal_offset = 0
D3VI.show,D3VI.message = false, ""
D3VI.seen_help = false

function D3VI:draw()
        if D3VI.show then
                love.graphics.setColor(1,1,1,0.4)
                love.graphics.draw(D3VI.platform,D3VI.x,D3VI.y)
                love.graphics.setFont(D3VI.font)
                love.graphics.setColor(1,1,1,1)
                love.graphics.printf(D3VI.message,D3VI.x,D3VI.y,200)
        end
end

function start_msg(msg,frames)
        D3VI.message, D3VI.show = msg, true
        if (frames + D3VI.internal_offset + 1) % 150 == 0 then
                D3VI.internal_offset = D3VI.internal_offset + 1
        end
end

function D3VI:update(dt,frames)
        if not D3VI.show then
                if D3VI.listen == "LS" then start_msg("nothing to see here", frames)
                elseif D3VI.listen == "GREP" then start_msg("What are you trying to find?", frames)
                elseif D3VI.listen == "HELP" and D3VI.seen_help then start_msg("Reading the manpage again? Pathetic", frames)
                elseif D3VI.listen == "SUDO" then start_msg("you think you own me?", frames);D3VI.current_effect = "SEISMIC"
                elseif D3VI.listen == "PROSPECT" then start_msg("I guess you never miss huh", frames)
                elseif D3VI.listen == "PROPEL" then start_msg("Woosh", frames)
                elseif D3VI.current_effect == "SEISMIC" then start_msg("You idiot!",frames)
                elseif D3VI.current_effect == "ANGER" then start_msg("WHY WONT YOU LISTEN TO ME",frames)
                end
        else
                if (frames+D3VI.internal_offset) % 150 == 0 then D3VI.message, D3VI.show = "", false end
        end
end

D3VI.effects = {"SEISMIC","ANGER","NONE"}
D3VI.current_effect = "NONE"
D3VI.seismicfactor = 5
function D3VI:effects(frames) -- effects to screw the screen over
        love.graphics.setFont(D3VI.font)
        if D3VI.current_effect == "SEISMIC" then
                if math.random() >= 0.85 then love.graphics.translate(math.random(D3VI.xdim),math.random(D3VI.ydim/2)) end
                love.graphics.translate(math.random(D3VI.seismicfactor),math.random(D3VI.seismicfactor))
                if frames % 200 == 0 then D3VI.current_effect = "NONE" end
        elseif D3VI.current_effect == "ANGER" then
                if lines == nil then lines = init_anger_lines() end
                lines.counter = lines.counter + 1
                love.graphics.setColor(0.9,0.1,0.1,1)
                for i=1,lines.size do 
                        love.graphics.translate(math.random(D3VI.seismicfactor),math.random(D3VI.seismicfactor))
                        lines[i].counter = lines[i].counter + 1
                        if lines[i].counter % 10 == 0 then
                                lines[i].text = lines[i].text .. string.sub(anger,lines[i].text:len()+1,lines[i].text:len()+2)
                        end
                        love.graphics.print(lines[i].text,lines[i].x,lines[i].y)
                end
                love.graphics.reset()
                love.graphics.setColor(1,1,1,1)

                if lines.counter >= 100 then
                        lines = nil
                        D3VI.current_effect ="NONE"
                end
        end
end

function init_anger_lines()
        local lines = {}
        lines.size = math.random(10,30)
        lines.counter = 0
        for i=1,lines.size do 
                lines[i] = {}
                lines[i].x,lines[i].y = math.random()*D3VI.xdim, math.random()*D3VI.ydim
                lines[i].counter = math.random(5)
                lines[i].text = ""
        end
        return lines
end

D3VI.listen = ""
function D3VI:textinput(char) D3VI.listen = D3VI.listen .. string.upper(char) end

function D3VI:keypressed(key,scancode,isrepeat)
        if key == "backspace" then 
                D3VI.listen = D3VI.listen:sub(1,D3VI.listen:len()-1)
        elseif key == "return" then
                D3VI.listen = ""
        end
end

return D3VI