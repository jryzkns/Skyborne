local dodge = {}

dodge.xdim,dodge.ydim = 0,0
function dodge:getGameState(game) if game.xdim and game.ydim then dodge.xdim,dodge.ydim = game.xdim,game.ydim end end

function dodge:update()

end

function dodge:draw()

end

return dodge