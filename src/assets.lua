local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")

-- Images
assets.player = love.graphics.newImage("assets/img/anim.png")
assets.white = love.graphics.newImage("assets/img/white.png")

-- Fonts
assets.font_lg = love.graphics.newFont("assets/fonts/04b03.ttf", 24)
assets.font_md = love.graphics.newFont("assets/fonts/04b03.ttf", 16)
assets.font_sm = love.graphics.newFont("assets/fonts/04b03.ttf", 8)

-- Sfx
-- assets.music = love.audio.newSource(love.sound.newDecoder("assets/sfx/music.mp3"))

return assets
