-- 
-- MoveTowardsTargetSystem
-- by Alphonsus
--
-- moves object towards targetPos (x,y)
-- can also rotate to target if e.rotateTowardsTarget is true
--
-- use e.isInTargetPos boolean to check if entity is already in the target pos
--
-- Required:
-- 
--	self.moveTowardsTarget = true
-- 	self.targetPos = {x = 100, y = 100}
--	self.movable (see MovableSystem)
--
-- Optional:
--	self.rotateTowardsTarget = true
--	self.moveTargetSpeed = self.movable.speed.x
--

local MoveTowardsTargetSystem = tiny.processingSystem(class "MoveTowardsTargetSystem")
local lume = require "lib.lume"

MoveTowardsTargetSystem.filter = tiny.requireAll("moveTowardsTarget", "targetPos")

function MoveTowardsTargetSystem:process(e, dt)
	if math.floor(lume.distance(e.pos.x, e.pos.y, e.targetPos.x, e.targetPos.y)) <= 0 then
		e.pos.x = e.targetPos.x
		e.pos.y = e.targetPos.y
		e.isInTargetPos = true

		e.movable.velocity.x = 0
		e.movable.velocity.y = 0
	else
		e.isInTargetPos = false

		local targetAngle = self:getAngleFromTargetPos(e)

		if e.rotateTowardsTarget then
			e.angle = targetAngle
		end

		local speed = e.moveTargetSpeed or 10

		e.movable.velocity.x = math.cos(targetAngle - math.rad(90)) * speed
		e.movable.velocity.y = math.sin(targetAngle - math.rad(90)) * speed
	end
end

function MoveTowardsTargetSystem:getAngleFromTargetPos(e)
	return math.atan2((e.targetPos.y - e.pos.y), (e.targetPos.x - e.pos.x)) + math.rad(90)
end

return MoveTowardsTargetSystem