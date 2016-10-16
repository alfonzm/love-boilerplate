io.stdout:setvbuf("no")

-- Global libraries
PaletteSwitcher = require('lib/PaletteSwitcher');
class = require "lib.30log"
tiny = require "lib.tiny"
editgrid = require "lib.editgrid"
Gamestate = require "lib.hump.gamestate"
Object = require "lib.classic"
timer = require "lib.hump.timer"
anim8 = require "lib.anim8"
gamera = require "lib.gamera"
highscore = require "lib.sick"

-- Ulydev camera options
screen = require "lib.shack"
push = require "lib.push"

-- utils
log = require "lib.log"
tlog = require "lib.alfonzm.tlog"
escquit = require "lib.alfonzm.escquit"

-- States
PlayState = require "playstate"
MenuState = require "menustate"

local assets =  require "src.assets"
reg = require "src.reg"

-- Declare tiny-ecs world
world = {}
camera = nil

-- Game settings
local scale = 4 -- should be the same as in conf

function love.load()
	-- Setup stuff
	setupPushScreen()
	-- setupPaletteSwitcher()
	-- setupBgMusic()

	-- Init gamestates
	Gamestate.registerEvents()
	Gamestate.switch(MenuState)
end

function love.update(dt)
	screen:update(dt)
	timer.update(dt)
end

function love.draw()
	push:apply("start")
	screen:apply()
	
	if world and world.update then
		world:update(love.timer.getDelta())
	end

	push:apply("end")
end

function setupPushScreen()
	-- setup push screen
	local windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
	local gameWidth, gameHeight = windowWidth / scale, windowHeight / scale
	push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})
	screen:setDimensions(push:getDimensions())
end

function setupPaletteSwitcher()
	PaletteSwitcher.init('lib/palettes.png', 'lib/palette.fs');
end

function setupBgMusic()
	assets.music:setVolume(0.8)
	assets.music:setLooping(true)
	assets.music:play()
end