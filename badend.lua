local badend = {}

badend.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",20)
badend.text = {
        "Despite the long journey, the HOPE-SS went through a series of unfortunate events that made the ship too damaged and exhausted to go on.",
        "This ship was meant for bringing treasure back to civilation, but now it is no more than vessel for the treasure to remain lost.",
        "The long haul is over.",
        "Chase gazes out of the window, and the distant ancient nebula gazes back at him ever so peacefully..."
}

badend.current_text = 1

badend.statuses = {"IDLE","RUNNING","DONE"}
badend.currentstate = "IDLE"

function badend:init()
        badend.splash = love.graphics.newImage("base_vignette.png")
end

badend.xdim,badend.ydim = 0,0
function badend:getGameState(game) if game.xdim and game.ydim then badend.xdim,badend.ydim = game.xdim,game.ydim end end

function badend:keypressed(key,scancode,isrepeat)
        if badend.currentstate == "RUNNING" then
                badend.current_text = badend.current_text + 1
                if badend.current_text == 4 then
                        badend.currentstate = "DONE"
                end
        end
end

function badend:draw()
        love.graphics.setFont(badend.font)
        love.graphics.draw(badend.splash,(badend.xdim-badend.splash:getWidth())/2,(badend.ydim-badend.splash:getHeight())/3)
        if badend.currentstate ~= "DONE" then
                love.graphics.printf( badend.text[badend.current_text], badend.xdim/2-200, badend.ydim*5/6, 400)
        end
end

return badend