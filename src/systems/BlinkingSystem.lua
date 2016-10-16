--
-- BlinkingSystem
-- by Alphonsus
--
-- alternately sets visible to true or false every [blinkDelay] seconds
-- e.visible is then used by SpriteSystem
--
-- Required:
--	self.blinking = true
--	self.blinkDelay = 0.2
--

local BlinkingSystem = tiny.processingSystem(class "BlinkingSystem")

BlinkingSystem.filter = tiny.requireAll("blinking", "blinkDelay")

function BlinkingSystem:onAdd(e)
	timer.script(function(wait)
	    wait(e.blinkDelay)
	    while true do
	        self.blink(e)
	        wait(e.blinkDelay)
	    end
	end)	
end

function BlinkingSystem.blink(e)
	if e.visible then
		e.visible = false
	else
		e.visible = true
	end
end

return BlinkingSystem