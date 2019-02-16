local UI = {}

UI.backdrop = love.graphics.newImage("background.png")
UI.cursor = love.graphics.newImage("cursor.png")

UI.xdim,UI.ydim = 0,0
function UI:getGameState(game) if game.xdim and game.ydim then UI.xdim,UI.ydim = game.xdim,game.ydim end end


UI.power = 0
function UI:getPower(value) UI.power = value end

function UI:draw() 
        
        -- backdrop
        love.graphics.draw(UI.backdrop,0,0)
        
        -- battery
        love.graphics.setLineWidth(5)
        local powercolor = getPowerColor(UI.power)
        love.graphics.setColor(powercolor[1],powercolor[2],powercolor[3],1)-- color this according to power percentage
        love.graphics.rectangle("fill",1050,10,UI.power,20)
        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle("line",1050,10,100,20)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1,1,1,1)
end

function getPowerColor(power) return {(100-power)/100,power/100,0} end

return UI