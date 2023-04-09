------------------------------------------------------------------------
    -- cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example - Disasters:
-- Create a command that spawns a meteor at the player's location
cuhFramework.commands.create("meteor", {"m"}, false, nil, function(_, peer_id)
    local player = cuhFramework.players.getPlayerByPeerId(peer_id) -- Get the player that ran this command
    cuhFramework.disasters.spawnMeteor(player:get_position(), 1) -- Spawn a meteor at the player's location with a magnitude of 1 (max)

    cuhFramework.chat.send_message("MyAddon", "GG.", player) -- Send a message to the player who ran this command
end)

-- Create a command that spawns a tsunami at the player's location
cuhFramework.commands.create("tsunami", {"t", "tsu"}, false, nil, function(_, peer_id)
    local player = cuhFramework.players.getPlayerByPeerId(peer_id) -- Get the player that ran this command
    local tsunami = cuhFramework.disasters.spawnTsunami(player:get_position(), 1) -- Spawn a tsunami at the player's location with a magnitude of 1 (max)

    cuhFramework.chat.send_message("MyAddon", "GG.", player) -- Send a message to the player who ran this command

    cuhFramework.utilities.delay.create(30, function() -- Call this function after 30 seconds
        tsunami:cancel() -- Cancel the tsunami
    end)
end)