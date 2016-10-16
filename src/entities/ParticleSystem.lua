GameObject = require "src.entities.GameObject"

local ParticleSystem = GameObject:extend()
local assets =  require "src.assets"

function ParticleSystem:new(x, y)
	ParticleSystem.super.new(self, x or push:getWidth()/2, y or push:getHeight()/2)
	self.name = "ParticleSystem"
	self.isParticleSystem = true

	self.ps = love.graphics.newParticleSystem(assets.white, 100)
	self.ps:setPosition(push:getWidth()/2, push:getHeight()/2)
	self.ps:setParticleLifetime(0.2, 2)
	self.ps:setDirection(1.5*3.14)
	self.ps:setSpread(3.14/3)
	self.ps:setLinearAcceleration(0, 400)
	self.ps:setLinearDamping(50)
	self.ps:setSpin(0, 30)
	self.ps:setColors(82, 127, 57, 255)
	self.ps:setRotation(0, 2*3.14)
	self.ps:setInsertMode('random')
	self.ps:setSizes(0.4, 0)

	return self
end

function ParticleSystem:update(dt)
	self.ps:update(dt)
end

function ParticleSystem:draw()
	love.graphics.draw(self.ps, 0, 0, 0, 1, 1)
end

return ParticleSystem