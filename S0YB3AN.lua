local S0YB3AN = {}

local lines = nil
local anger = "LISTEN TO ME"

S0YB3AN.font = love.graphics.setNewFont("AllerDisplay.ttf",80) 
-- could give soybean a characteristic font

function S0YB3AN:draw()
        -- love.graphics.circle("fill",400,400,100)
end

S0YB3AN.xdim,S0YB3AN.ydim = 0,0
function S0YB3AN:getGameState(game) if game.xdim and game.ydim then S0YB3AN.xdim, S0YB3AN.ydim = game.xdim, game.ydim end end

-- soybean says things character by character, dialogue will be by absolute dialogue

function S0YB3AN:update(dt,frames)

end

S0YB3AN.effects = {"SEISMIC","ANGER","NONE"}
S0YB3AN.current_effect = "NONE"
S0YB3AN.seismicfactor = 5
function S0YB3AN:effects(frames) -- effects to screw the screen over
        love.graphics.setFont(S0YB3AN.font)
        if S0YB3AN.current_effect == "SEISMIC" then
                if math.random() >= 0.85 then
                        love.graphics.translate(math.random(S0YB3AN.xdim),math.random(S0YB3AN.ydim/2))
                end
                love.graphics.translate(math.random(S0YB3AN.seismicfactor),math.random(S0YB3AN.seismicfactor))
                if frames % 200 == 0 then
                        S0YB3AN.current_effect = "NONE"
                end
        elseif S0YB3AN.current_effect == "ANGER" then
                if lines == nil then lines = init_anger_lines() end
                lines.counter = lines.counter + 1
                love.graphics.setColor(0.9,0.1,0.1,1)
                for i=1,lines.size do 
                        love.graphics.translate(math.random(S0YB3AN.seismicfactor),math.random(S0YB3AN.seismicfactor))                
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
                        S0YB3AN.current_effect ="NONE"
                end
        end
end

function init_anger_lines()
        local lines = {}
        lines.size = math.random(10,30)
        lines.counter = 0
        for i=1,lines.size do 
                lines[i] = {}
                lines[i].x,lines[i].y = math.random()*S0YB3AN.xdim, math.random()*S0YB3AN.ydim
                lines[i].counter = math.random(5)
                lines[i].text = ""
        end
        return lines
end

return S0YB3AN