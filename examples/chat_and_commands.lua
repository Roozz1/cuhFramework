------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example:
local my_command
my_command = cuhFramework.commands.create("purge", {"p"}, false, "myaddon", function(msg, peer_id, admin, auth, command, ...)
    -- Pack all command args into a table (unused in this, but this is how you get command arguments)
    local args = {...}

    -- Since we have a prefix, args[1] would be the actual command, while command would be the prefix, so let's shift things around
    command = args[1]
    args[1] = nil

    -- Clear chat for everyone when this command is activated
    cuhFramework.chat.clear()
    -- to clear it for a specifiy person, specify the peer_id of the person you want to hide chat for, eg:
    -- cuhFramework.chat.clear(0) -- clears chat for the player with peer_id 0

    -- Thennn, remove this command, so it cannot be used again
    my_command:remove()
end)