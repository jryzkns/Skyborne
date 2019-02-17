local goodend = {}

goodend.bgm = love.audio.newSource("goodend.mp3","static")
goodend.bgm:setLooping(true)

goodend.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",20)

goodend.text = {
        "Luckily, the HOPE-55 found an entire bundle of fuel cells while scouring the space for decompostable material",
        "The ship is now full of treasures and supplies. Chase cranked open the furnace, turned on autopilot, and leaned back on his chair to enjoy himself",
        "The long haul is over.",
        ""
}

goodend.current_text = 1

goodend.statuses = {"IDLE","RUNNING","DONE"}
goodend.currentstate = "IDLE"

function goodend:init()
        goodend.splash = love.graphics.newImage("goodend.png")
end

goodend.xdim,goodend.ydim = 0,0
function goodend:getGameState(game) if game.xdim and game.ydim then goodend.xdim,goodend.ydim = game.xdim,game.ydim end end

function goodend:keypressed(key,scancode,isrepeat)
        if goodend.currentstate == "RUNNING" then
                goodend.current_text = goodend.current_text + 1
                if goodend.current_text > 4 then
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