local unrequited = require("unrequited")

-- be kind
-- flight
-- dangers in space
-- energy

-- STEP ONE implement a commandline
-- STEP TWO script soybean into the game, decide on a interaction medium

function love.load()
        game = {}
        game.xdim, game.ydim = 1200,600
        game.title = "Airborne Rhapsody - jryzkns 2019"
        game.states = {"STARTUP","BADENDSEQ","GOODENDSEQ","CONTROL"}
        game.currentstate = "CONTROL"
        unrequited:windowsetup(game.xdim,game.ydim,game.title)
        love.mouse.setVisible(false)
        love.graphics.setNewFont("BebasNeue-Regular.ttf",50)

        unrequited:closer_to_me("UI")
        unrequited:closer_to_me("cmd")
        unrequited.half_my_world["cmd"]:getGameState(game)
        unrequited:closer_to_me("S0YB3AN")
end

function love.update(dt)
        if not unrequited.waiting then
                unrequited.half_my_world["UI"]:getPower(unrequited.half_my_world["cmd"].power)
                if unrequited.half_my_world["cmd"].power <= 0 then
                        -- IMPLEMENT BADEND SEQUENCE
                        game.currentstate = "BADENDSEQ"
                        love.event.quit()
                end
                if unrequited.half_my_world["cmd"].complete then
                        -- IMPLEMENT GOODEND SEQUENCE
                        game.currentstate = "GOODENDSEQ"
                end
                unrequited:update(dt)
        end
end

function love.mousepressed(x,y,button,istouch,presses) unrequited:mousepressed(x,y,button,istouch,presses) end
function love.mousereleased(x,y,button,istouch,presses) unrequited:mousereleased(x,y,button,istouch,presses)end
function love.textinput(char) unrequited.half_my_world["cmd"]:textinput(char) end

function love.keypressed(key,scancode,isrepeat)
        -- play a sound
        if key == "space" then unrequited:wait_for_me()
        elseif key == "p" then unrequited:remember_me()
        end

        unrequited:keypressed(key,scancode,isrepeat)
end

function love.keyreleased(key,scancode)
        if key == "escape" then unrequited:heartbreak() end
        unrequited:keyreleased(key,scancode)
end


function mouse()
        love.graphics.reset()
        local mx,my = love.mouse.getPosition()
        love.graphics.draw(unrequited.half_my_world["UI"].cursor,mx-4,my)
end

function love.draw()
        if game.currentstate == "CONTROL" then
                unrequited.half_my_world["UI"]:draw()
                unrequited.half_my_world["S0YB3AN"]:effects()
                unrequited.half_my_world["cmd"]:draw()
                unrequited.half_my_world["S0YB3AN"]:draw()
        end

        mouse()
end