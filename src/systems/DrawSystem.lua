--
-- DrawSystem
-- by Alphonsus
--
-- calls the entity's draw() function
-- use e:setDrawLayer(string) to set the z-index/draw layer
--
-- then order the DrawSystems accordingly, i.e.
-- 		world:add(require("src.systems.DrawSystem")("player"))
--		world:add(require("src.systems.DrawSystem")("playerParticles"))
--
--	Required:
--	function Object:draw()
--

local DrawSystem = tiny.processingSystem(class "DrawSystem")

function DrawSystem:init(zIndex)
    self.z = "zIndex" .. (zIndex or 1)
    self.filter = tiny.requireAll("draw", self.z)
end

function DrawSystem:onAdd(e)
end

function DrawSystem:process(e, dt)
	if reg.DEBUG_RENDERS then print("DrawSystem " .. self.z .. ": " .. e.name) end
	e:draw(dt)
end

return DrawSystem