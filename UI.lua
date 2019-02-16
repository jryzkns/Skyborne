local UI = {}

UI.backdrop = love.graphics.newImage("background.png")
UI.cursor = love.graphics.newImage("cursor.png")

UI.power = ""
function UI:getPower(value) UI.power = tostring(value) end

function UI:draw() 
        love.graphics.draw(UI.backdrop,0,0)

        -- some sort of battery display
        love.graphics.print(UI.power,500,500)

        love.graphics.setLineWidth(5)
        local powercolor = getPowerColor(UI.power)
        love.graphics.setColor(powercolor[1],powercolor[2],powercolor[3],1)-- color this according to power percentage
        love.graphics.rectangle("fill",1050,10,UI.power,20)
        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle("line",1050,10,100,20)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1,1,1,1)
end

function getPowerColor(power)

        return {(100-power)/100,power/100,0}
end

-- IMPLEMENT PAUSE

return UI