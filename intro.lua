local intro = {}
intro.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",20)
intro.text = {
        "July 8th, 3032. Aboard the HOPE-55, Junior Pilot Chase sits in his chamber controlling the ship on his way home from his year long mission.",
        "The ship is full of otherworldly treasures and an ancient relic that is rumoured to be able to revert human regrets. There aren't much humans left but that's beside the point.",
        "The long haul is almost over. The ship is now running on its last energy cell, but Chase was certain that he could make it back home with all that's left.",
        "However, ever since the ship passed by that abandoned space station two days ago, things have not been feeling right on this ship.",
        "Chase decided to take a look at the command terminal to see what went awry.",
        "Press any key to continue..."
}

intro.bgm = love.audio.newSource("intro.mp3","static")
intro.bgm:play()

intro.current_text = 1

intro.statuses = {"RUNNING","DONE","OVER"}
intro.currentstate = "RUNNING"

function intro:init()
        intro.splash = love.graphics.newImage("intro.png")
end

intro.xdim,intro.ydim = 0,0
function intro:getGameState(game) if game.xdim and game.ydim then intro.xdim,intro.ydim = game.xdim,game.ydim end end

function intro:keypressed(key,scancode,isrepeat)
        intro.current_text = intro.current_text + 1
        if intro.current_text > #intro.text and intro.currentstate == "RUNNING" then
                intro.currentstate = "DONE"
        end
end

function intro:draw()
        love.graphics.setFont(intro.font)
        love.graphics.draw(intro.splash,(intro.xdim-intro.splash:getWidth())/2,(intro.ydim-intro.splash:getHeight())/3)
        love.graphics.printf( intro.text[intro.current_text], intro.xdim/2-200, intro.ydim*5/6, 400)
end

return intro