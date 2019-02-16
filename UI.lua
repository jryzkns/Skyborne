local UI = {}

UI.backdrop = love.graphics.newImage("background.png")
UI.cursor = love.graphics.newImage("cursor.png")

function UI:draw() love.graphics.draw(UI.backdrop,0,0) end

return UI