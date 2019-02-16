local UI = {}

UI.backdrop = love.graphics.newImage("background.png")
UI.cursor = love.graphics.newImage("cursor.png")

UI.power = ""
function UI:getPower(value) UI.power = tostring(value) end

function UI:draw() 
        love.graphics.draw(UI.backdrop,0,0)

        -- some sort of battery display
        love.graphics.print(UI.power,500,500)
end

-- IMPLEMENT PAUSE

return UI