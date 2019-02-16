local unrequited = require("unrequited")

function love.load()
        game = {}
        game.xdim, game.ydim = 800,700
        game.title = ""
        unrequited:windowsetup(game.xdim,game.ydim,game.title)

end

function love.update(dt)
        if not unrequited.waiting then
                unrequited:update()
        end
end

function love.mousepressed(x,y,button,istouch,presses)
        unrequited:mousepressed(x,y,button,istouch,presses)
end

function love.mousereleased(x,y,button,istouch,presses)
        unrequited:mousereleased(x,y,button,istouch,presses)
end

function love.keypressed(key,scancode,isrepeat)
        if key == "space" then unrequited:wait_for_me()
        elseif key == "p" then unrequited:remember_me()
        end

        unrequited:keypressed(key,scancode,isrepeat)
end

function love.keyreleased(key,scancode)
        if key == "escape" then unrequited:heartbreak() end
        unrequited:keyreleased(key,scancode)
end

function love.draw()
        -- unrequited:draw()
end