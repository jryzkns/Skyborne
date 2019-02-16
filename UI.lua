local UI = {}

UI.backdrop = love.graphics.newImage("background.png")

function UI:update()

end

function UI:draw()
        love.graphics.draw(UI.backdrop,0,0)
end


return UI