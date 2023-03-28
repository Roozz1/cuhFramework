------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example:
-- Note: host = player with peer_id 0, aka the player that created the server, or the server itself in dedicated servers
cuhFramework.utilities.loop.create(6, function()
    -- Get host
    local target_player = cuhFramework.players.getPlayerByPeerId(0) -- get host's player data

    -- Clear chat
    cuhFramework.chat.clear(target_player) -- Only for the host

    -- Send messages
    cuhFramework.chat.send_message("Bob", "Hey "..target_player.properties.name.."! Take my object!", target_player) -- Send a message to the host, saying "Hey (name of host player)! Take my object!"
    target_player:fake_chat("Thanks for the object, Bob!") -- Send a fake message that seems like it was sent by the host

    -- Spawn an object at the host's position
    local target_player_position = target_player:get_position() -- get the position of the host
    local object = cuhFramework.objects.spawnObject(target_player_position, 1) -- Spawn an object at the host's position

    -- If the object failed to spawn (usually when we enter a value incorrectly), we end the function here
    if not object then
        return
    end

    -- Announce something in chat after 1 second has passed
    cuhFramework.utilities.delay.create(1, function()
        cuhFramework.chat.send_message("Bob", "Guys! I just sent a message to the host of this server AND gave him an object!") -- Since a player wasn't specified, this message will be sent to all players
    end)

    -- Despawn the object after some time
    cuhFramework.utilities.delay.create(4, function()
        object:despawn() -- Despawn the object after 4 seconds
    end)
end)