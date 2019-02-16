local goodend = {}

goodend.xdim,goodend.ydim = 0,0
function goodend:getGameState(game) if game.xdim and game.ydim then goodend.xdim,goodend.ydim = game.xdim,game.ydim end end


function goodend:draw() end

return goodend