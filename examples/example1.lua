------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example:
cuhFramework.utilities.loop.create(2, function()
    cuhFramework.chat.clear() -- clear chat

    local target_player = cuhFramework.players.getPlayerByPeerId(0) -- get host's player data
    cuhFramework.chat.send_message("Bob", "Hey "..target_player.properties.name.."! Take my item!", 0) -- send a message to the host, saying "Hey (name of host player)! Take my item!"

    local target_player_position = target_player:get_position() -- get the position of the host
    server.spawnEquipment(target_player_position, 2, 30, 30) -- spawn an item at the host's position

    cuhFramework.utilities.delay.create(1, function()
        cuhFramework.chat.send_message("Bob", "Guys! I just sent a message to the host of this server AND gave him an item!", -1)
        -- cuhFramework.chat.send_message("Bob", "Guys! I just sent a message to the host of this server!") -- not specifying a peer_id will just set the peer_id to -1, so this does the same as the line above
    end)
end)