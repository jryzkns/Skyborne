local unrequited = require("unrequited")

-- be kind
-- flight
-- dangers in space
-- energy

-- STEP ONE implement a commandline
-- STEP TWO script soybean into the game, decide on a interaction medium

function love.load()
        game = {}
        game.xdim, game.ydim =1200,600
        game.title = "Airborne Rhapsody - jryzkns 2019"
        unrequited:windowsetup(game.xdim,game.ydim,game.title)
        love.mouse.setVisible(false)
        love.graphics.setNewFont("BebasNeue-Regular.ttf",35)

        unrequited:closer_to_me("UI")
        unrequited:closer_to_me("cmd")
        unrequited.half_my_world["cmd"]:getGameState(game)
        unrequited:closer_to_me("S0YB3AN")
end

function love.update(dt)
        if not unrequited.waiting then
                unrequited:update(dt)
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

function love.textinput(char)
        unrequited.half_my_world["cmd"]:textinput(char)
end

function mouse()
        local mx,my = love.mouse.getPosition()
        love.graphics.draw(unrequited.half_my_world["UI"].cursor,mx-4,my)
end

function love.draw()
        -- unrequited:draw()
        unrequited.half_my_world["UI"]:draw()
        unrequited.half_my_world["S0YB3AN"]:effects()
        unrequited.half_my_world["cmd"]:draw()
        unrequited.half_my_world["S0YB3AN"]:draw()

        mouse()
end