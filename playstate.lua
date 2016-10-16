-- play state

playstate = {}

-- libs
local HClib = require "lib.hc"
local Camera = require "lib.hump.camera"

-- entities
local Player = require "src.entities.Player"
local Explosion = require "src.entities.Explosion"
local Enemy = require "src.entities.Enemy"

local player
local uiScore
local score = 0

HC = nil

function playstate:init()
	HC = HClib.new(150)

	self.world = tiny.world()
	world = self.world

	player = Player()

	camera = Camera(0, 0, 1)

	enemy = Enemy(10,10)
	enemy.moveTowardsTarget = true
	enemy.targetPos = {x = push:getWidth()/2, y = push:getHeight()/2}
	enemy.moveTargetSpeed = 20

	self.world:add(
		require("src.systems.BGColorSystem")(20,0,0),
		require("src.systems.UpdateSystem")(),
		require("src.systems.DrawSystem")(),
		require("src.systems.MoveTowardsTargetSystem")(),
		require("src.systems.DrawSystem")("playerParticles"),
		require("src.systems.MovableSystem")(),
		require("src.systems.SpriteSystem")(),
		require("src.systems.SpriteSystem")("player"),
		require("src.systems.DrawUISystem")("hudForeground"),
		player2,
		enemy,
		player
		-- Explosion(10,10)
	)
end

function playstate:keypressed(k)
end

function playstate:update(dt)
	if reg.DEBUG_RENDERS then print('---') end
end

function playstate:draw()
	love.graphics.print("Playstate.lua\nFPS: " .. love.timer.getFPS() .. "\nEntities: " .. world:getEntityCount(), 20, 20)

	push:apply("start")
	push:apply("end")
end

return playstate