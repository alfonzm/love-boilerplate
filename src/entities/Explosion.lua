--
-- Explosion
--

local Explosion = GameObject:extend()
local assets =  require "src.assets"

function Explosion:new(x, y)
	Explosion.super.new(self, x, y)

	-- entity
	self.name = "Explosion"
	self.isExplosion = true

	-- Explosion
	self.sprite = assets.player
	self.offset = { x = reg.T_SIZE/2, y = reg.T_SIZE/2 }
	self.flippedH = false
	local g = anim8.newGrid(reg.T_SIZE, reg.T_SIZE, self.sprite:getWidth(), self.sprite:getHeight())

	local frameDelay = 0.1
	self.animation = anim8.newAnimation(g('1-3',1), frameDelay, 'pauseAtEnd')

	local numberOfFrames = #self.animation.frames

	-- destroy after (secs per frame * no of frames)
	timer.after((frameDelay * numberOfFrames), function() self.toRemove = true end)

	return self
end

function Explosion:update(dt)
end

return Explosion
