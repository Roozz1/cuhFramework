------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example:
-- Note: host = player with peer_id 0, aka the player that created the server, or the server itself in dedicated servers
cuhFramework.utilities.loop.create(6, function()
    cuhFramework.chat.clear(0) -- clear chat for the host

    -- Get host, and send messages
    local target_player = cuhFramework.players.getPlayerByPeerId(0) -- get host's player data
    cuhFramework.chat.send_message("Bob", "Hey "..target_player.properties.name.."! Take my object!", 0) -- send a message to the host, saying "Hey (name of host player)! Take my object!"
    target_player:fake_chat("Thanks for the object, Bob!") -- send a fake message that seems like it was sent by the host

    -- Spawn an object at the host's position
    local target_player_position = target_player:get_position() -- get the position of the host
    local object = cuhFramework.objects.spawnObject(target_player_position, 1) -- spawn an object at the host's position

    -- Announce something in chat after 1 second has passed
    cuhFramework.utilities.delay.create(1, function()
        cuhFramework.chat.send_message("Bob", "Guys! I just sent a message to the host of this server AND gave him an object!", -1)
        -- cuhFramework.chat.send_message("Bob", "Guys! I just sent a message to the host of this server AND gave him an object!", -1) -- not specifying a peer_id will just set the peer_id to -1, so this does the same as the line above
    end)

    -- Despawn the object after some time
    cuhFramework.utilities.delay.create(4, function()
        object:despawn() -- despawn the object after 4 seconds
    end)
end)