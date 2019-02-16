local race = {}

race.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",30)
race.xdim,race.ydim = 0,0
function race:getGameState(game) if game.xdim and game.ydim then race.xdim,race.ydim = game.xdim, game.ydim end end

race.statuses = {"RUNNING","DONE","FAILED"}
race.currentstate = "RUNNING"
race.has_init = false
function race:game_init()
        race.player = {}
        race.player.x,race.player.y = race.xdim/2, race.ydim/2
        race.currentstate = "RUNNING"
        race.has_init = true
        storm = make_meteors()

        race.internal_counter = 0
end

function make_meteors()
        local storm = {}
        for i=1,10+math.random(10) do
                storm[i] = {}
                storm[i].x,storm[i].y = 100 + math.random()*(race.xdim-200),100 + math.random()*(race.ydim-200)
                storm[i].size = 0.1 + math.random()*10
        end

        return storm
end

function race:update()
        if love.keyboard.isDown("right") and race.player.x <= race.xdim-100 then
                race.player.x = race.player.x + 3
        end
        if love.keyboard.isDown("left") and race.player.x >= 100 then
                race.player.x = race.player.x - 3
        end
        if love.keyboard.isDown("up") and race.player.y >= 100 then
                race.player.y = race.player.y - 3
        end
        if love.keyboard.isDown("down") and race.player.y <= race.ydim -100 then
                race.player.y = race.player.y + 3
        end

        for i=1,#storm do
                storm[i].size = storm[i].size * 1.08
                if storm[i].size >= 120 then
                        storm = make_meteors()
                        break
                end
                if dist(race.player.x,race.player.y,storm[i].x,storm[i].y) < storm[i].size then
                        race.currentstate = "FAILED"
                end
        end

        race.internal_counter = race.internal_counter + 1
        if race.internal_counter >= 200 then
                race.currentstate = "DONE"
        end
end

function dist(x1,y1,x2,y2) return math.sqrt((x1-x2)^2 + (y1-y2)^2) end

function race:draw()
        love.graphics.setFont(race.font)
        love.graphics.printf("Avoid the incoming meteors",race.xdim/2-150,0,300)

        love.graphics.setColor(0,1,0,1)
        love.graphics.setLineWidth(5)
        love.graphics.line( race.player.x, race.player.y, race.player.x+10, race.player.y)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1,1,1,1)

        for i=1,#storm do
                love.graphics.circle("line",storm[i].x,storm[i].y,storm[i].size)
        end
end

return race