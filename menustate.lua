menustate = {}

local flux = require "lib.flux"
local UIText = require "src.entities.UIText"
local PlayState = require "playstate"
local assets =  require "src.assets"

local title, pressToPlay
local dir = 1

function menustate:init()
	local titleImage = UIText("GAME TITLE", 0, -20, push:getWidth(), nil, nil, assets.font_lg)

	local pressStart = UIText("Press SPACE to start", 0, push:getHeight() * 0.7, push:getWidth(), nil, nil, assets.font_sm)
	pressStart.blinking = true
	pressStart.blinkDelay = 0.5

	self.world = tiny.world(
		require("src.systems.BlinkingSystem")(),
		require("src.systems.BGColorSystem")(0,0,10),
		require("src.systems.DrawUISystem")("hudForeground"),
		titleImage,
		pressStart
	)

	flux.to(titleImage.pos, 1, {y = 30})
	world = self.world
end

function menustate:update(dt)
	flux.update(dt)
end

function menustate:keypressed(k)
	if k == 'space' or k == 'return' then
		Gamestate.switch(PlayState)
	end
end

return menustate