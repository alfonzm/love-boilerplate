--
-- DestroyOffScreenSystem
-- by Alphonsus
--
-- removes objects off the world if they go beyond the screen
--

local DestroyOffScreenSystem = tiny.processingSystem(class "DestroyOffScreenSystem")

DestroyOffScreenSystem.filter = tiny.requireAll("destroyOffScreen", "pos")

local offset = 12

function DestroyOffScreenSystem:process(e, dt)
	if (e.pos.x < -offset or e.pos.x > (push:getWidth()+offset)) or (e.pos.y < -offset or e.pos.y > (push:getHeight()+offset)) then
		e.isAlive = false
		world:remove(e)
	end
end

return DestroyOffScreenSystem