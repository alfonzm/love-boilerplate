--
-- ShakySystem
-- by Alphonsus
--
-- shaking effect, randomizes pos.x and pos.y
--
--	Required:
--	self.shakyX = 0.1
--	self.shakyY = 0.1
--

local Shaky = tiny.processingSystem(class "Shaky")
local lume = require "lib.lume"

function Shaky:init()
	self.filter = tiny.requireAll(tiny.requireAny("shakyX", "shakyY"), "pos")
end

function Shaky:onAdd(e)
	e.dir = 1
	e.origPosX = e.pos.x
	e.origPosY = e.pos.y
end

function Shaky:process(e, dt)
	if e.shakyX then
		e.pos.x = e.origPosX + lume.random(-e.shakyX, e.shakyX)
		print(e.pos.x)
	end

	if e.shakyY then
		e.pos.y = e.origPosY + lume.random(-e.shakyY, e.shakyY)
	end
end

return Shaky