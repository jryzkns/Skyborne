local unrequited = require("unrequited")

function love.load()
        game = {}
        game.xdim, game.ydim = 1200,600
        game.title = "Skyborne Rhapsody - jryzkns 2019"
        game.states = {"STARTUP","BADEND","GOODEND","CONTROL","RACE","DODGE","CREDITS"}
        game.currentstate = "STARTUP"
        unrequited:windowsetup(game.xdim,game.ydim,game.title)
        love.mouse.setVisible(false)

        unrequited:closer_to_me("intro");unrequited.half_my_world["intro"]:getGameState(game)
        unrequited:closer_to_me("goodend");unrequited.half_my_world["goodend"]:getGameState(game)
        unrequited:closer_to_me("badend");unrequited.half_my_world["badend"]:getGameState(game)
        unrequited:closer_to_me("UI");unrequited.half_my_world["UI"]:getGameState(game)
        unrequited:closer_to_me("cmd");unrequited.half_my_world["cmd"]:getGameState(game)
        unrequited:closer_to_me("D3VI");unrequited.half_my_world["D3VI"]:getGameState(game)
        unrequited:closer_to_me("race");unrequited.half_my_world["race"]:getGameState(game)
        unrequited:closer_to_me("dodge");unrequited.half_my_world["dodge"]:getGameState(game)
end

function roll_credits()
        unrequited:closer_to_me("credits")
        game.currentstate = "CREDITS" 
end

function love.update(dt)
        unrequited.photographs = unrequited.photographs + 1
        -- if the current game state is in one of the two endings:
        if game.currentstate == "GOODEND" or game.currentstate == "BADEND" then
                -- if the ending sequence is done, roll the credits
                if unrequited.half_my_world[string.lower(game.currentstate)].currentstate == "DONE" then roll_credits() end 
        -- if the intro sequence is done, then go to control stage
        elseif unrequited.half_my_world["intro"].currentstate == "DONE" then 
                unrequited.half_my_world["intro"].currentstate = "OVER"
                game.currentstate = "CONTROL" 
        -- if the current game state is in control mode
        elseif game.currentstate == "CONTROL" then

                if unrequited.half_my_world["cmd"].mode == "END" then roll_credits() end 
                
                unrequited.half_my_world["D3VI"].seen_help = unrequited.half_my_world["cmd"].seen_help

                unrequited.half_my_world["cmd"]:update(dt,unrequited.photographs)
                unrequited.half_my_world["D3VI"]:update(dt,unrequited.photographs)
                -- fix power and update power to UI
                if unrequited.half_my_world["cmd"].power > 100 then unrequited.half_my_world["cmd"].power = 100 end
                unrequited.half_my_world["UI"]:getPower(unrequited.half_my_world["cmd"].power)
                
                -- if you mess up a command, subin gets mad at you
                if unrequited.half_my_world["cmd"].failedcmd then unrequited.half_my_world["D3VI"].current_effect = "SEISMIC" end
                if unrequited.half_my_world["cmd"].idle > 300 then unrequited.half_my_world["D3VI"].current_effect = "ANGER" end
                -- if you run out of power, invoke bad ending. if you travelled your amount, invoke good ending
                if not (unrequited.half_my_world["cmd"].power > 0) then 
                        unrequited.half_my_world["badend"].current_text = 1
                        unrequited.half_my_world["badend"].currentstate = "RUNNING"
                        game.currentstate = "BADEND"
                        unrequited.half_my_world["badend"].bgm:play() 
                elseif unrequited.half_my_world["cmd"].distance_covered > 50 then 
                        unrequited.half_my_world["goodend"].current_text = 1
                        unrequited.half_my_world["goodend"].currentstate = "RUNNING"
                        game.currentstate = "GOODEND" 
                        unrequited.half_my_world["goodend"].bgm:play()
                end

                -- if the control window swaps over to a minigame, start the minigame
                if unrequited.half_my_world["cmd"].mode == "RACE" or unrequited.half_my_world["cmd"].mode == "DODGE" then
                        if not unrequited.half_my_world[string.lower(unrequited.half_my_world["cmd"].mode)].has_init then
                                unrequited.half_my_world[string.lower(unrequited.half_my_world["cmd"].mode)]:game_init()
                                unrequited.half_my_world[string.lower(unrequited.half_my_world["cmd"].mode)].has_init = false
                        end
                        game.currentstate = unrequited.half_my_world["cmd"].mode
                        unrequited.half_my_world[string.lower(unrequited.half_my_world["cmd"].mode)].bgm:play()
                        unrequited.half_my_world["cmd"].mode = "NONE"
                end
        elseif game.currentstate == "RACE" or game.currentstate == "DODGE" then
                if game.currentstate ~= "CONTROL" then
                        unrequited.half_my_world[string.lower(game.currentstate)]:update()
                end
                if unrequited.half_my_world[string.lower(game.currentstate)].currentstate == "DONE" then
                        game.currentstate = "CONTROL"
                        unrequited.half_my_world["cmd"].currentstate = "NONE"
                        unrequited.half_my_world["cmd"].power = unrequited.half_my_world["cmd"].power + 10
                        unrequited.half_my_world["cmd"].distance_covered = unrequited.half_my_world["cmd"].distance_covered + 15
                elseif unrequited.half_my_world[string.lower(game.currentstate)].currentstate == "FAILED" then
                        unrequited.half_my_world["badend"].currentstate = "RUNNING"
                        game.currentstate = "BADEND"
                        unrequited.half_my_world["badend"].bgm:play()
                end
        end
end

function love.textinput(char) 
        if game.currentstate == "CONTROL" then 
                unrequited.half_my_world["cmd"]:textinput(char) 
                unrequited.half_my_world["D3VI"]:textinput(char) 
        end 
end

function love.keypressed(key,scancode,isrepeat) unrequited:keypressed(key,scancode,isrepeat) end

function mouse()
        love.graphics.reset()
        local mx,my = love.mouse.getPosition()
        love.graphics.draw(unrequited.half_my_world["UI"].cursor,mx-4,my)
end

function love.draw()
        if game.currentstate == "STARTUP" then 
                unrequited.half_my_world["intro"]:draw()
        elseif game.currentstate == "CONTROL" then
                unrequited.half_my_world["UI"]:draw()
                unrequited.half_my_world["D3VI"]:draw()
                unrequited.half_my_world["D3VI"]:effects(unrequited.photographs)
                unrequited.half_my_world["cmd"]:draw()
        elseif game.currentstate == "RACE" then
                unrequited.half_my_world["race"]:draw()
        elseif game.currentstate == "DODGE" then
                unrequited.half_my_world["dodge"]:draw()
        elseif game.currentstate == "BADEND" then
                unrequited.half_my_world["badend"]:draw()
        elseif game.currentstate == "GOODEND" then
                unrequited.half_my_world["goodend"]:draw()
        elseif game.currentstate == "CREDITS" then
                unrequited.half_my_world["credits"]:draw()
        end
        mouse()
end