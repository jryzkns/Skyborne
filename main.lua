local unrequited = require("unrequited")

function love.load()
        game = {}
        game.xdim, game.ydim = 1200,600
        game.title = "Airborne Rhapsody - jryzkns 2019"
        game.states = {"STARTUP","BADENDSEQ","GOODENDSEQ","CONTROL","RACE","DODGE"}
        game.currentstate = "STARTUP"
        unrequited:windowsetup(game.xdim,game.ydim,game.title)
        love.mouse.setVisible(false)

        unrequited:closer_to_me("intro");unrequited.half_my_world["intro"]:getGameState(game)
        unrequited:closer_to_me("goodend");unrequited.half_my_world["goodend"]:getGameState(game)
        unrequited:closer_to_me("badend");unrequited.half_my_world["badend"]:getGameState(game)
        unrequited:closer_to_me("UI");unrequited.half_my_world["UI"]:getGameState(game)
        unrequited:closer_to_me("cmd");unrequited.half_my_world["cmd"]:getGameState(game)
        unrequited:closer_to_me("S0YB3AN");unrequited.half_my_world["S0YB3AN"]:getGameState(game)
        unrequited:closer_to_me("race");unrequited.half_my_world["race"]:getGameState(game)
        unrequited:closer_to_me("dodge");unrequited.half_my_world["dodge"]:getGameState(game)
end

function love.update(dt)
        if unrequited.half_my_world["intro"].currentstate == "DONE" then
                game.currentstate = "CONTROL"
        end
        if game.currentstate == "CONTROL" then
                unrequited.half_my_world["UI"]:getPower(unrequited.half_my_world["cmd"].power)
                if unrequited.half_my_world["cmd"].failedcmd then
                        unrequited.half_my_world["S0YB3AN"].current_effect = "SEISMIC"
                end

                if unrequited.half_my_world["cmd"].idle > 500 and unrequited.half_my_world["S0YB3AN"].current_effect ~= "ANGER" then
                        unrequited.half_my_world["S0YB3AN"].current_effect = "ANGER"
                end

                if unrequited.half_my_world["cmd"].power <= 0 then
                        game.currentstate = "BADENDSEQ"
                end
                if unrequited.half_my_world["cmd"].distance_covered > 50 then
                        game.currentstate = "GOODENDSEQ"
                end
                if unrequited.half_my_world["cmd"].mode == "RACE" or unrequited.half_my_world["cmd"].mode == "DODGE" then
                        game.currentstate = unrequited.half_my_world["cmd"].mode
                end
                unrequited:update(dt)
        end
        if game.currentstate == "RACE" then
                if unrequited.half_my_world["race"].currentstate == "DONE" then
                        game.currentstate = "CONTROL"
                        unrequited.half_my_world["cmd"].currentstate = "NONE"
                end
        end
        if game.currentstate == "DODGE" then
                if unrequited.half_my_world["dodge"].currentstate == "DONE" then
                        game.currentstate = "CONTROL"
                        unrequited.half_my_world["cmd"].currentstate = "NONE"
                end
        end
end

function love.mousepressed(x,y,button,istouch,presses) unrequited:mousepressed(x,y,button,istouch,presses) end
function love.mousereleased(x,y,button,istouch,presses) unrequited:mousereleased(x,y,button,istouch,presses)end
function love.textinput(char) 
        if game.currentstate == "CONTROL" then
                unrequited.half_my_world["cmd"]:textinput(char) 
        end
end

function love.keypressed(key,scancode,isrepeat) unrequited:keypressed(key,scancode,isrepeat) end

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

        if game.currentstate == "STARTUP" then 
                unrequited.half_my_world["intro"]:draw()
        elseif game.currentstate == "RACE" then
                unrequited.half_my_world["race"]:draw()
        elseif game.currentstate == "DODGE" then
                unrequited.half_my_world["dodge"]:draw()
        elseif game.currentstate == "CONTROL" then
                unrequited.half_my_world["UI"]:draw()
                unrequited.half_my_world["S0YB3AN"]:effects(unrequited.photographs)
                unrequited.half_my_world["cmd"]:draw()
                -- unrequited.half_my_world["S0YB3AN"]:draw()
        elseif game.currentstate == "GOODENDSEQ" then
                unrequited.half_my_world["goodend"]:draw()
        elseif game.currentstate == "BADENDSEQ" then
                unrequited.half_my_world["badend"]:draw()
        end


        mouse()
end