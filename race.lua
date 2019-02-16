local race = {}

race.xdim,race.ydim = 0,0
function race:getGameState(game) if game.xdim and game.ydim then race.xdim,race.ydim = game.xdim,game.ydim end end

function race:update()

end

function race:draw()

end

return race