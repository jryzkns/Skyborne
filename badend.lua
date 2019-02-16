local badend = {}

badend.statuses = {"RUNNING","DONE"}
badend.currentstate = "RUNNING"

badend.xdim,badend.ydim = 0,0
function badend:getGameState(game) if game.xdim and game.ydim then badend.xdim,badend.ydim = game.xdim,game.ydim end end

function badend:draw() end

return badend