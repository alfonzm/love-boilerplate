--
-- SpriteSystem
-- by Alphonsus
--
-- draw the animation. if entity has no animation, draws the sprite image
-- use e:setDrawLayer(string) to set the z-index/draw layer
--
-- then order the SpriteSystem-s accordingly, i.e.
--      world:add(require("src.systems.SpriteSystem")("player"))
--      world:add(require("src.systems.SpriteSystem")("enemyBullets"))
--
--  Required:
--  self.sprite = assets.sprite
--
--  Optional self.animation. Example:
--  local g = anim8.newGrid(reg.T_SIZE, reg.T_SIZE, self.sprite:getWidth(), self.sprite:getHeight())
--  self.animation = anim8.newAnimation(g('1-3',1), 0.1)
--

local assets =  require "src.assets"
local SpriteSystem = tiny.processingSystem(class "SpriteSystem")

function SpriteSystem:init(zIndex)
    self.z = "zIndex" .. (zIndex or 1)
    self.filter = tiny.requireAll("sprite", "pos", self.z)
end

function SpriteSystem:postProcess(dt)
    love.graphics.setColor(255, 255, 255, 255)
end

function SpriteSystem:process(e, dt)
    if reg.DEBUG_RENDERS then print("SpriteSystem " .. self.z .. ": " .. e.name) end
    if e.visible == false then
        return
    end

    local an = e.animation

    local alpha = e.alpha or 1
    local pos, sprite, scale, rot, offset = e.pos, e.sprite, e.scale, e.angle, e.offset
    local sx, sy, r, ox, oy = scale and scale.x or 1, scale and scale.y or 1, rot or 0, offset and offset.x or 0, offset and offset.y or 0
    love.graphics.setColor(255, 255, 255, math.max(0, math.min(1, alpha)) * 255)

    if e.spark then
        -- love.graphics.setShader(assets.spark_shader)
        timer.after(0.02, function() e.spark = false end)
    end

    if an then
        love.graphics.setColor(254,254,254,254)
        an.flippedH = e.flippedH or false
        an:update(dt)
        an:draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)

    elseif sprite then
        love.graphics.draw(sprite, pos.x, pos.y, r, sx, sy, ox, oy)
    end

    -- if e.draw then
    --     e:draw(dt)
    -- end

    -- PaletteSwitcher:set()
end

return SpriteSystem
