local GameObject = require "src.entities.GameObject"
local ParticleSystem = require "src.entities.ParticleSystem"

local Player = GameObject:extend()
local assets =  require "src.assets"

function Player:new(x, y)
	Player.super.new(self, x or push:getWidth()/2, y or push:getHeight()/2)
	self.name = "Player"
	self.isPlayer = true

	-- sprite component
	self.sprite = assets.player
	self.flippedH = false
	self.offset = { x = reg.T_SIZE/2, y = reg.T_SIZE/2 }
	local g = anim8.newGrid(reg.T_SIZE, reg.T_SIZE, self.sprite:getWidth(), self.sprite:getHeight())
	self.idleAnimation = anim8.newAnimation(g('1-3',1), 0.1)
	self.animation = self.idleAnimation

	-- movable component
	self.movable = {
		velocity = { x = 0, y = 0 },
		acceleration = { x = 0, y = 0 },
		drag = { x = 100, y = 0 },
		maxVelocity = { x = 80, y = 80 },
		speed = { x = 100, y = 0 } -- used to assign to acceleration
	}

	self:setupParticles()
	self:setDrawLayer("player")

	return self
end

function Player:update(dt)
	self:moveControls()

	self.trailPs.ps:setPosition(self.pos.x + math.random(-2,2), self.pos.y + 10)
	self.trailPs.ps:emit(1)
end

function Player:draw()
end

function Player:setupParticles()
	self.trailPs = ParticleSystem()
	self.trailPs:setDrawLayer("playerParticles")
	self.trailPs.ps:setPosition(push:getWidth()/2, push:getHeight()/2)
	self.trailPs.ps:setParticleLifetime(0.2, 2)
	self.trailPs.ps:setDirection(1.5*3.14)
	self.trailPs.ps:setSpread(3.14/3)
	self.trailPs.ps:setLinearAcceleration(0, 400)
	self.trailPs.ps:setLinearDamping(50)
	self.trailPs.ps:setSpin(0, 30)
	self.trailPs.ps:setColors(82, 127, 57, 255)
	self.trailPs.ps:setRotation(0, 2*3.14)
	self.trailPs.ps:setInsertMode('random')
	self.trailPs.ps:setSizes(0.4, 0)
	world:add(self.trailPs)
end

function Player:moveControls()
	local left = love.keyboard.isDown('left')
	local right = love.keyboard.isDown('right')

	if left and not right then
		self.movable.acceleration.x = -self.movable.speed.x
	elseif right and not left then
		self.movable.acceleration.x = self.movable.speed.x
	else
		self.movable.acceleration.x = 0
	end
end

return Player