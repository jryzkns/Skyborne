local UI = {}

UI.backdrop = love.graphics.newImage("background.png")
UI.cursor = love.graphics.newImage("cursor.png")

UI.power = ""
function UI:getPower(value) UI.power = tostring(value) end

function UI:draw() 
        love.graphics.draw(UI.backdrop,0,0)

        love.graphics.print(UI.power,100,100)
end

-- IMPLEMENT PAUSE

return UI