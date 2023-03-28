------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example:
-- Get the host
local host = cuhFramework.players.getPlayerByPeerId(0)

-- Spawn a creature at the host's position (Industrial Frontier DLC required)
local creature = cuhFramework.creatures.spawnCreature(host:get_position(), 54, 1) -- 54 = pig, 1 = size multiplier

-- Every 0.6 seconds, make the creature walk to the host
cuhFramework.utilities.loop.create(0.6, function()
	local pos = host:get_position() -- Get position of host
	creature:setMoveTarget(pos) -- Set move target
end)

-- Create a zone, if a player enters it, the player dies
cuhFramework.customZones.create(host:get_position(), 10, function(player, entered)
	if entered then -- A player entered the zone
        cuhFramework.chat.send_message("myAddon", player.properties.name.." entered this zone!")
        player:kill() -- Kill the player
    else -- A player left the zone
        cuhFramework.chat.send_message("myAddon", player.properties.name.." left this zone!")
    end
end)