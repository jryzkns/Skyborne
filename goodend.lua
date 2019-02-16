local goodend = {}

goodend.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",20)


-- rewrite this piece
goodend.text = {
        "Despite the long journey, the HOPE-SS went through a series of unfortunate events that made the ship too damaged and exhausted to go on.",
        "This ship was meant for bringing treasure back to civilation, but now it is no more than vessel for the treasure to remain lost.",
        "The long haul is over.",
        "Chase gazes out of the window, and the distant ancient nebula gazes back at him ever so peacefully..."
}

goodend.current_text = 1

goodend.statuses = {"IDLE","RUNNING","DONE"}
goodend.currentstate = "IDLE"

function goodend:init()
        goodend.splash = love.graphics.newImage("base_vignette.png")
end

goodend.xdim,goodend.ydim = 0,0
function goodend:getGameState(game) if game.xdim and game.ydim then goodend.xdim,goodend.ydim = game.xdim,game.ydim end end

function goodend:keypressed(key,scancode,isrepeat)
        if goodend.currentstate == "RUNNING" then
                goodend.current_text = goodend.current_text + 1
                if goodend.current_text == 4 then
                        goodend.currentstate = "DONE"
                end
        end
end

function goodend:draw()
        love.graphics.setFont(goodend.font)
        love.graphics.draw(goodend.splash,(goodend.xdim-goodend.splash:getWidth())/2,(goodend.ydim-goodend.splash:getHeight())/3)
        if goodend.currentstate ~= "DONE" then
                love.graphics.printf( goodend.text[goodend.current_text], goodend.xdim/2-200, goodend.ydim*5/6, 400)
        end
end

return goodend