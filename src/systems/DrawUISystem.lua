--
-- DrawUISystem
-- by Alphonsus
--
-- calls drawHud, useful for UI objects
-- this system is usually added last, on top of other render systems
--
--	Required:
--	function Object:drawHud()
--

local DrawUISystem = tiny.processingSystem(class "DrawUISystem")

function DrawUISystem:init(layerFlag)
self.filter = tiny.requireAll("drawHud", layerFlag)
end

function DrawUISystem:process(e, dt)
	e:drawHud(dt)
end

return DrawUISystem