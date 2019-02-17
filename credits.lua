local credits = {}

function credits:init()
        -- bgm; autoplay
        credits.img = love.graphics.newImage("credits.png")
        credits.img2= love.graphics.newImage("namecredits.png")
end

function credits:draw()
        love.graphics.draw(credits.img,0,0)
        love.graphics.draw(credits.img2,200,100)
end

return credits