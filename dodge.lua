local dodge = {}

dodge.font = love.graphics.setNewFont("BebasNeue-Regular.ttf",30)
dodge.xdim,dodge.ydim = 0,0
function dodge:getGameState(game) if game.xdim and game.ydim then dodge.xdim,dodge.ydim = game.xdim,game.ydim end end

dodge.statuses = {"RUNNING","DONE","FAILED"}
dodge.currentstate = "RUNNING"
dodge.has_init = false
function dodge:game_init()
        dodge.player = {}
        dodge.player.x,dodge.player.y = dodge.xdim/10, dodge.ydim/2
        dodge.currentstate = "RUNNING"
        dodge.has_init = true
        rain = make_it_rain()
end

function dodge:update()
        if love.keyboard.isDown("right") and dodge.player.x <= dodge.xdim-100 then dodge.player.x = dodge.player.x + 3 end
        if love.keyboard.isDown("left") and dodge.player.x >= 100 then dodge.player.x = dodge.player.x - 3 end
        if love.keyboard.isDown("up") and dodge.player.y >= dodge.ydim/2 - 50 then dodge.player.y = dodge.player.y - 3 end
        if love.keyboard.isDown("down") and dodge.player.y <= dodge.ydim/2 + 50 then dodge.player.y = dodge.player.y + 3 end
        
        if dodge.player.x > dodge.xdim-150 then dodge.currentstate = "DONE" end
        
        -- let the rain fall
        local dt = 1/60
        for i,drop in ipairs(rain) do
                local dy = drop[3]*dt
                drop[2] = drop[2] - dy
                drop[3] = drop[3] - 100*dt
                if dist(dodge.player.x,dodge.player.y,drop[1],drop[2]) <= 5 then dodge.currentstate = "FAILED" end
                if drop[2] > dodge.ydim then
                        drop[3] = 3*math.random()
                        drop[2] = -math.random()*dodge.ydim
                        drop[1] = math.random()*dodge.xdim
                end

        end
      
end

function dist(x1,y1,x2,y2) return math.sqrt((x1-x2)^2 + (y1-y2)^2) end

function make_it_rain()
        local rain = {}
        for i=1,200 do 
                -- x,y,speed
                rain[i] = {math.random()*dodge.xdim,-math.random()*dodge.ydim*3,5*math.random()}
        end
        return rain
end

function dodge:draw()
        love.graphics.setFont(dodge.font)
        love.graphics.printf("Avoid the spark rain and send the ore down to the reactor!",dodge.xdim/2-150,0,300)
        love.graphics.setColor(0,1,0,1)
        love.graphics.circle("fill",dodge.player.x,dodge.player.y,5)
        love.graphics.setColor(1,0,0,0.7)
        love.graphics.rectangle("fill",dodge.xdim-150,dodge.ydim/2-50,100,100)
        love.graphics.setColor(0.5,0.5,0.5,1)
        love.graphics.setLineWidth(5)
        love.graphics.line(0,dodge.ydim/2-55,dodge.xdim,dodge.ydim/2-55)
        love.graphics.line(0,dodge.ydim/2+55,dodge.xdim,dodge.ydim/2+55)
        
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1,0.2,0.2,1)
        for i,coords in ipairs(rain) do
                love.graphics.line(coords[1],coords[2],coords[1],coords[2]+5)
        end
end

return dodge