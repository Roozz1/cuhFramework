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

-- Spawn a character
local character = cuhFramework.characters.spawnCharacter(host:get_position(), 1)

-- Every 0.01 seconds, make the creature walk to the host, and teleport the character to the creature
if creature and character then -- The creature may not spawn if we have entered a value incorrectly, so we are checking if it did before we do anything else
    cuhFramework.utilities.loop.create(0.01, function()
        local pos = host:get_position() -- Get position of host
        creature:setMoveTarget(pos) -- Set move target
        character:teleport(creature:get_position()) -- Teleport character to creature
    end)
end

-- Create a player zone next to the host, if a player enters it, the player dies
local host_position = host:get_position()
local newPos = cuhFramework.utilities.matrix.offsetPosition(host_position, 15, 0, 0) -- 15 meters to the right of the host

cuhFramework.customZones.createPlayerZone(newPos, 10, function(player, entered) -- 10 = size of zone
	if entered then -- A player entered the zone
        cuhFramework.chat.send_message("myAddon", player.properties.name.." entered this zone!")
        player:kill() -- Kill the player
        cuhFramework.chat.send_message("myAddon", player.properties.name.." died... because he trepassed into this zone.")
    else -- A player left the zone
        cuhFramework.chat.send_message("myAddon", player.properties.name.." left this zone!")
    end
end)

-- Create a vehicle zone at the host's position, if a vehicle enters it, it explodes
cuhFramework.customZones.createVehicleZone(host_position, 10, function(vehicle, entered) -- 10 = size of zone
    if entered then
        -- Vehicle has entered the zone, so we shall explode it
        vehicle:explode()
    end
end)