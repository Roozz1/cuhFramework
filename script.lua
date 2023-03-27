------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
------------------------------------------------------------------------
--[[
	------
	Setup
	------
	This is the cuhFramework.lua file, which contains the cuhFramework (duh).
	It is HIGHLY recommended that you code your addon in a different .lua file (script.lua or another file),
	then when you are ready, run 'build.exe' to combine your code with this framework to use in-game.

	It is highly recommended that you use the popular Lua LSP extension on VSCode,
	and it is also highly recommended that you use NameousChangey's "Stormworks Lua with LifeboatAPI"
	VSCode Extension.

	If you're not already, make sure to code your addon with something like VSCode, and do not use the in-game
	editor because, chances are, your code and this framework will not fit within the in-game addon character limit.
	The limit can be bypassed if you code outside of in-game (using something like VSCode as said), which is why
	you shouldn't code your addon in-game.

	------
	Documentation:
	------
	Before we get deeper into this documentation, a few warnings:
		- This framework DOESN'T contain every single Stormworks function, you may have to use regular Addon Lua functions there and then.
		- Some documentation may be missing, if that is the case, join the Discord at the top and ping me (cuh4) for help.
		- This framework is still in development and may be updated there and then, 

	--------- Creating a command
	This framework allows you to create a command easily.

	To create a command, use the cuhFramework.commands.create() function:

	local my_command = cuhFramework.commands.create("my_command", {"mc", "m_c"}, function()
		cuhFramework.utilities.chat.send_message("myAddon", "someone activated my command")
	end, false)

	Arg 1) "my_command" = command name, this is "?my_command" in chat
	Arg 2) {"mc", "m_c"} = command shorthands, think of these as alternative command names, typing one of these shorthands in chat will activate the command
		It doesn't have to be a table either, it can be a string, like: "mc"
	Arg 3) Argument 3 is the function, this function is fired when the command is activated.
		When the function is fired, it passes over 5+ arguments, these include:
			full_message = "?hello this is my command", basically the message a player typed in chat to use the command
			peer_id = The peer_id of the player who used the command
			is_admin = Whether or not the player has admin
			is_auth = Whether or not the player hs auth
			command = "?my_command" or one of the shorthands, basically the command the player typed in chat
			... = Other arguments passed through, convert this to a table to see what things the player typed after "?my_command"
				Example: Bob typed "?my_command one"

				local args = {...}
				args[1] -- "one"
				args[2] -- nil
	Arg 4) This determines whether the command is caps sensitive or not.
			If it's true, then typing "?my_CoMmAnD" will not activate the command.
			If it's false, then typing "?my_COmMand" will activate the command.

	--------- Editing/Removing a command
	local my_command = cuhFramework.commands.create("my_command", {"mc", "m_c"}, function()
		cuhFramework.utilities.chat.send_message("myAddon", "someone activated my command")
	end, false)

	Using the code above, my_command is actually the command itself, a table containing numerous functions that allows you to modify the command.

	To remove the command:
		my_command:remove()
		This cannot be undone.

	To edit the command:
		my_command:edit(command_name, shorthands, caps_sensitive, callback)
		All of these arguments can be nil, if they are nil, then that part of the command will not be edited.

		Example:
			my_command:edit("new_command_name", nil, nil, nil) -- does the same as below
			my_command:edit("new_command_name") -- does the same as above

			Since shorthands, caps_sensitive, and callback are all nil, the command callback isn't changed, along with whether or not the command is caps sensitive. This also applies to the shorthands.

	That's all for commands.

	--------- Game Callbacks
	If you're an addon developer, you're probably used to typing:

	function onVehicleSpawn(...)
		-- Your code here
	end

	in your addons, but with the cuhFramework, there is no need to do this. You can just do:

	cuhFramework.callbacks.onVehicleSpawn:connect(function(...)
		-- Your code here
	end)

	You have just created a connection between onVehicleSpawn and your function, awesome!

	The Connect() function also returns a table of functions, one of which is Disconnect(), which effectively chops the connection.
	
	Example:
		local onPlayerJoinConnection = cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, is_admin, is_auth)
			cuhFramework.chat.send_message("[Game]", name.." has joined the server!")
		end)

		onPlayerJoinConnection:disconnect()
		onPlayerJoin.Disconnect(onPlayerJoin) -- both do the same

	--------- Players
	This framework comes with a custom player system, here's how to use it.
	
	To get a player, you can either:
		cuhFramework.players.getPlayerByPeerId(0)
		cuhFramework.players.getPlayerBySteamId(0)
		cuhFramework.players.getPlayerByName("cuh4", true) -- final argument (true) determines whether or not the search should be caps sensitive. if false, a player named "CuH4" will get returned if this player is in the server, if true, only the player named "cuh4" will get returned

	All of these functions return a player, from there, you can apply things to this player, like teleporting the player, or kicking the player (and more!).

	Example:
		local player = cuhFramework.players.getPlayerByPeerId(0) -- get the player
		player:teleport(matrix.translation(0, 0, 0)) -- teleport the player to 0, 0, 0

		cuhFramework.utilities.delay.create(2, function() -- after two seconds, call this function
			player:kick() -- kick the player
			player:ban() -- ban the player
		end)

	In that example, we get the player with peer_id 0, and then we teleport the player to 0, 0, 0.
	Two seconds after doing so, we both kick and ban the player (ban kicks the player by the way, so player:kick() is useless in the example, but it's just there to show you that you can kick a player).
]]

----------------------------------------
----------------------------------------
--//Framework\\--
----------------------------------------
----------------------------------------
cuhFramework = {
	players = {},
	vehicles = {},
	utilities = {},
	chat = {},
	callbacks = {},
	commands = {},
	saveData = {},

	BACKEND = {
		updates = {
			---Insert update function. Don't use this yourself
			---@param func function Function that should be called every tick
			---@return nil
			insert = function(self, func)
				table.insert(self, func)
			end,

			---Create an exception. The exception will not be called by onTick. Don't use this
			---@param exception function The function to exclude
			---@return nil
			create_exception = function(self, exception)
				table.insert(self.exceptions, exception)
			end,

			exceptions = {}
		},

		data = {}
	}
}

----------------------------------------
----------------------------------------
--//Backend - Save Data\\--
----------------------------------------
----------------------------------------
g_savedata = {}

----------------------------------------
----------------------------------------
--//Backend - Updates [DO NOT USE]\\--
----------------------------------------
----------------------------------------
cuhFramework.BACKEND.updates:create_exception(cuhFramework.BACKEND.updates.create_exception)
cuhFramework.BACKEND.updates:create_exception(cuhFramework.BACKEND.updates.insert)

----------------------------------------
----------------------------------------
--//Backend - Callbacks\\--
----------------------------------------
----------------------------------------
cuhFramework.callbacks.onTick = {
	connections = {},
	---Connect a callback to onTick
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onTick(...)
	-- BACKEND - Update
	for i, v in pairs(cuhFramework.BACKEND.updates) do
		if cuhFramework.utilities.table.valueInTable(cuhFramework.BACKEND.updates.exceptions, v) then
			goto continue
		end

		if type(v) ~= "function" then
			goto continue
		end

		v(...)

		::continue::
	end

	for i, v in pairs(cuhFramework.callbacks.onTick.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCreate = {
	connections = {},
	---Connect a callback to onCreate
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCreate(...)
	for i, v in pairs(cuhFramework.callbacks.onCreate.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onDestroy = {
	connections = {},
	---Connect a callback to onDestroy
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onDestroy(...)
	for i, v in pairs(cuhFramework.callbacks.onDestroy.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCustomCommand = {
	connections = {},
	---Connect a callback to onCustomCommand
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCustomCommand(...)
	for i, v in pairs(cuhFramework.callbacks.onCustomCommand.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onChatMessage = {
	connections = {},
	---Connect a callback to onChatMessage
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onChatMessage(...)
	for i, v in pairs(cuhFramework.callbacks.onChatMessage.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerJoin = {
	connections = {},
	---Connect a callback to onPlayerJoin
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerJoin(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerJoin.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerSit = {
	connections = {},
	---Connect a callback to onPlayerSit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerSit(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerSit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerUnsit = {
	connections = {},
	---Connect a callback to onPlayerUnsit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerUnsit(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerUnsit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterSit = {
	connections = {},
	---Connect a callback to onCharacterSit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterSit(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterSit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterUnsit = {
	connections = {},
	---Connect a callback to onCharacterUnsit
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterUnsit(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterUnsit.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterPickup = {
	connections = {},
	---Connect a callback to onCharacterPickup
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterPickup(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterPickup.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onEquipmentPickup = {
	connections = {},
	---Connect a callback to onEquipmentPickup
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onEquipmentPickup(...)
	for i, v in pairs(cuhFramework.callbacks.onEquipmentPickup.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onEquipmentDrop = {
	connections = {},
	---Connect a callback to onEquipmentDrop
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onEquipmentDrop(...)
	for i, v in pairs(cuhFramework.callbacks.onEquipmentDrop.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onCharacterPickup = {
	connections = {},
	---Connect a callback to onCharacterPickup
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onCharacterPickup(...)
	for i, v in pairs(cuhFramework.callbacks.onCharacterPickup.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerRespawn = {
	connections = {},
	---Connect a callback to onPlayerRespawn
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerRespawn(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerRespawn.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerLeave = {
	connections = {},
	---Connect a callback to onPlayerLeave
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerLeave(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerLeave.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onToggleMap = {
	connections = {},
	---Connect a callback to onToggleMap
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onToggleMap(...)
	for i, v in pairs(cuhFramework.callbacks.onToggleMap.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onPlayerDie = {
	connections = {},
	---Connect a callback to onPlayerDie
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onPlayerDie(...)
	for i, v in pairs(cuhFramework.callbacks.onPlayerDie.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleSpawn = {
	connections = {},
	---Connect a callback to onVehicleSpawn
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleSpawn(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleSpawn.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleDespawn = {
	connections = {},
	---Connect a callback to onVehicleDespawn
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleDespawn(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleDespawn.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleLoad = {
	connections = {},
	---Connect a callback to onVehicleLoad
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleLoad(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleLoad.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleUnload = {
	connections = {},
	---Connect a callback to onVehicleUnload
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleUnload(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleUnload.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleTeleport = {
	connections = {},
	---Connect a callback to onVehicleTeleport
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleTeleport(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleTeleport.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onObjectLoad = {
	connections = {},
	---Connect a callback to onObjectLoad
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onObjectLoad(...)
	for i, v in pairs(cuhFramework.callbacks.onObjectLoad.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onObjectUnload = {
	connections = {},
	---Connect a callback to onObjectUnload
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onObjectUnload(...)
	for i, v in pairs(cuhFramework.callbacks.onObjectUnload.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onButtonPress = {
	connections = {},
	---Connect a callback to onButtonPress
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onButtonPress(...)
	for i, v in pairs(cuhFramework.callbacks.onButtonPress.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onSpawnAddonComponent = {
	connections = {},
	---Connect a callback to onSpawnAddonComponent
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onSpawnAddonComponent(...)
	for i, v in pairs(cuhFramework.callbacks.onSpawnAddonComponent.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVehicleDamaged = {
	connections = {},
	---Connect a callback to onVehicleDamaged
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVehicleDamaged(...)
	for i, v in pairs(cuhFramework.callbacks.onVehicleDamaged.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.httpReply = {
	connections = {},
	---Connect a callback to httpReply
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function httpReply(...)
	for i, v in pairs(cuhFramework.callbacks.httpReply.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onFireExtinguished = {
	connections = {},
	---Connect a callback to onFireExtinguished
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onFireExtinguished(...)
	for i, v in pairs(cuhFramework.callbacks.onFireExtinguished.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onForestFireSpawned = {
	connections = {},
	---Connect a callback to onForestFireSpawned
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onForestFireSpawned(...)
	for i, v in pairs(cuhFramework.callbacks.onForestFireSpawned.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onForestFireExtinguised = {
	connections = {},
	---Connect a callback to onForestFireExtinguised
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onForestFireExtinguised(...)
	for i, v in pairs(cuhFramework.callbacks.onForestFireExtinguised.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onTornado = {
	connections = {},
	---Connect a callback to onTornado
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onTornado(...)
	for i, v in pairs(cuhFramework.callbacks.onTornado.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onMeteor = {
	connections = {},
	---Connect a callback to onMeteor
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onMeteor(...)
	for i, v in pairs(cuhFramework.callbacks.onMeteor.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onTsunami = {
	connections = {},
	---Connect a callback to onTsunami
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onTsunami(...)
	for i, v in pairs(cuhFramework.callbacks.onTsunami.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onWhirlpool = {
	connections = {},
	---Connect a callback to onWhirlpool
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onWhirlpool(...)
	for i, v in pairs(cuhFramework.callbacks.onWhirlpool.connections) do
		v(...)
	end
end

----------------

cuhFramework.callbacks.onVolcano = {
	connections = {},
	---Connect a callback to onVolcano
	---@param callback function
	connect = function(self, callback)
		local id = #self.connections + 1
		self.connections[id] = callback

		return {
			connection_id = id,
			disconnect = function()
				self.connections[id] = nil
			end
		}
	end
}

function onVolcano(...)
	for i, v in pairs(cuhFramework.callbacks.onVolcano.connections) do
		v(...)
	end
end

----------------------------------------
----------------------------------------
--//Framework - Utilities\\--
----------------------------------------
----------------------------------------
------------------------
------String
------------------------
cuhFramework.utilities.string = {}

---Converts a string into a table, same as Python's split() function, from: https://stackoverflow.com/questions/1426954/split-string-in-lua
---@param str string String to split
---@param sep string Pattern to split the string by
---@return table split_string The split string in a table
cuhFramework.utilities.string.split = function(str, sep)
	if sep == nil then
		sep = "%s"
	end

	local split_string = {}

	for strn in string.gmatch(str, "([^"..sep.."]+)") do
		table.insert(split_string, strn)
	end

	return split_string
end

---Converts anything into a string, alias to tostring()
---@param input any|nil String to split
---@return string string The tostring()'d version of input
cuhFramework.utilities.string.tostring = function(input)
	return tostring(input)
end

---Replaces occurences in a string with something else
---@param input string Input string
---@param pattern string The pattern to find
---@param replacement string What to replace all occurences of the specified pattern with
---@return string string The new string
---@return integer occurences The amount of occurences of the pattern in the input string
cuhFramework.utilities.string.replace = function(input, pattern, replacement)
	return input:gsub(pattern, replacement)
end

------------------------
------Table
------------------------
cuhFramework.utilities.table = {}

---Whether or not a value exists in a table
---@param tbl table Table to look in
---@param value any What value to look for in the table
---@return boolean found Whether or not the value was found
cuhFramework.utilities.table.valueInTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			return true
		end
	end

	return false
end

---Whether or not an index exists in a table
---@param tbl table Table to look in
---@param index any What index to look for in the table
---@return boolean found Whether or not the index was found
cuhFramework.utilities.table.indexInTable = function(tbl, index)
	return tbl[index] ~= nil
end

---Insert a value into a table, alias to table.insert
---@param tbl table Table to insert the value in
---@param value any Value to insert
---@return nil
cuhFramework.utilities.table.insert = function(tbl, value)
	table.insert(tbl, value)
end

---Swap the values of a table with the index of the value
---@param tbl table Table to apply the result of this function to
---@return table newTable The new table with all values as the index, and all indexes as the values
cuhFramework.utilities.table.swapValuesAndIndexes = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		new[v] = i
	end

	return new
end

---Convert all table values to a string
---@param tbl table Table of values to convert
---@return table newTable The new table with all values as a string
cuhFramework.utilities.table.tostringValues = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		new[i] = cuhFramework.utilities.string.tostring(v)
	end

	return new
end

---Convert all table string values to a lowercase version
---@param tbl table Table of values to convert
---@return table newTable The new table with all string values as lowercase
cuhFramework.utilities.table.lowercaseStringValues = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		if type(v) == "string" then
			new[i] = v:lower()
		end
	end

	return new
end

---Convert all table string values to a uppercase version
---@param tbl table Table of values to convert
---@return table newTable The new table with all string values as uppercase
cuhFramework.utilities.table.uppercaseStringValues = function(tbl)
	local new = {}

	for i, v in pairs(tbl) do
		if type(v) == "string" then
			new[i] = v:upper()
		end
	end

	return new
end

------------------------
------Number
------------------------
cuhFramework.utilities.number = {}

---Converts any number into an integer
---@param num number The number to convert into an integer
---@return integer integer The new integer
cuhFramework.utilities.number.tointeger = function(num)
	return math.floor(num)
end

---Converts any number into a float
---@param num number The number to convert into a float
---@return float float The new float
cuhFramework.utilities.number.tofloat = function(num)
	return cuhFramework.utilities.number.tonumber(cuhFramework.utilities.string.tostring(num)..".0")
end

---Converts a string/bool into a number
---@param input string|bool|number The number to convert into a float
---@return number number The new number
cuhFramework.utilities.number.tonumber = function(input)
	if type(input) == "bool" then
		if input then
			return 1
		else
			return 0
		end
	end

	return tonumber(input)
end

---Clamps a number between two numbers
---@param number number The number to clamp
---@param minimum number The minimum value the number can be
---@param maximum number The maximum value the number can be
---@return number number The clamped number
cuhFramework.utilities.number.clamp = function(number, minimum, maximum)
	if number < minimum then
		number = minimum
	elseif number > maximum then
		number = maximum
	end

	return number
end

------------------------
------Delays
------------------------
cuhFramework.utilities.delay = {}

cuhFramework.utilities.delay.ongoingDelays = {}

---Update delays, don't use this
cuhFramework.utilities.delay.update = function()
	for i, v in pairs(cuhFramework.utilities.delay.ongoingDelays) do
		local timeNow = server.getTimeMillisec()
		if timeNow >= v.creationTime + (v.time * 1000) and not v.paused then
			v.callback(v.id)
			cuhFramework.utilities.delay.remove(v.id)
		end
	end
end

cuhFramework.BACKEND.updates:insert(cuhFramework.utilities.delay.update) -- reference

---Call a function after x seconds
---@param duration number How long until the callback is called in seconds
---@param callback function The function to call after the delay is manually called or when the delay naturally completes itself
cuhFramework.utilities.delay.create = function(duration, callback)
    local id = #cuhFramework.utilities.delay.ongoingDelays + 1

	cuhFramework.utilities.delay.ongoingDelays[id] = {
		callback = callback,
		time = duration,
		creationTime = server.getTimeMillisec(),
		id = id,
		paused = false,
	}

	return {
		properties = cuhFramework.utilities.delay.ongoingDelays[id],

		---Set the duration of the delay
		---@param newDuration number What to set the delay duration to in seconds 
		setDuration = function(self, newDuration)
			self.properties.time = newDuration
		end,

		---Manually call the callback assigned to the delay
		call = function(self)
			self.properties.callback()
		end,

		---Remove/Cancel the delay
		remove = function(self)
			cuhFramework.utilities.delay.ongoingDelays[id] = nil
		end,

		---Pause/Unpause the delay. The delay timer will still go up if paused, but the function will not be called upon completion
		---@param state boolean True = pause delay, false = unpause delay
		setPaused = function(self, state)
			self.properties.paused = state
		end,
	}
end

---Remove a delay by its ID
---@param id number The ID of the delay
cuhFramework.utilities.delay.remove = function(id)
	cuhFramework.utilities.delay.ongoingDelays[id] = nil
end

------------------------
------Loops
------------------------
cuhFramework.utilities.loop = {}

cuhFramework.utilities.loop.ongoingLoops = {}

---Update loops, don't use this
cuhFramework.utilities.loop.update = function()
	for i, v in pairs(cuhFramework.utilities.loop.ongoingLoops) do
		local timeNow = server.getTimeMillisec()
		if timeNow >= v.creationTime + (v.time * 1000) and not v.paused then
			v.callback(v.id)
			v.creationTime = timeNow
		end
	end
end

cuhFramework.BACKEND.updates:insert(cuhFramework.utilities.loop.update) -- reference

---Call a function every x seconds
---@param duration number How long until the callback is called in seconds
---@param callback function The function to call after the loop is manually called or when a loop iteration has completed
cuhFramework.utilities.loop.create = function(duration, callback)
    local id = #cuhFramework.utilities.loop.ongoingLoops + 1

	cuhFramework.utilities.loop.ongoingLoops[id] = {
		callback = callback,
		time = duration,
		creationTime = server.getTimeMillisec(),
		id = id,
		paused = false,
	}

	return {
		properties = cuhFramework.utilities.loop.ongoingLoops[id],

		---Set the duration of the loop
		---@param newDuration number What to set the loop duration to in seconds 
		setDuration = function(self, newDuration)
			self.properties.time = newDuration
		end,

		---Manually call the callback assigned to the loop
		call = function(self)
			self.properties.callback()
		end,

		---Remove/Cancel the loop
		remove = function(self)
			cuhFramework.utilities.loop.ongoingLoops[id] = nil
		end,

		---Pause/Unpause the loop. The loop timer will still go up if paused, but the function will not be called upon an iteration completion
		---@param state boolean True = pause loop, false = unpause loop
		setPaused = function(self, state)
			self.properties.paused = state
		end,
	}
end

---Remove a loop by its ID
---@param id number The ID of the loop
cuhFramework.utilities.loop.remove = function(id)
	cuhFramework.utilities.loop.ongoingLoops[id] = nil
end

----------------------------------------
----------------------------------------
----------------------------------------
--//Framework - Commands\\--
----------------------------------------
----------------------------------------
cuhFramework.commands.registeredCommands = {}

------------------------
------Create Command
------------------------
---Create a command
---@param command_name string The name of the command, example: "my_command"
---@param shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c"
---@param callback function The function that will be called upon a player typing the command
cuhFramework.commands.create = function(command_name, shorthands, callback, caps_sensitive)
	if type(shorthands) == "string" then
		shorthands = {shorthands}
	end

	local id = #cuhFramework.commands.registeredCommands + 1
	cuhFramework.commands.registeredCommands[id] = {
		id = id,
		command_name = command_name,
		shorthands = shorthands or {},
		callback = callback,
		caps_sensitive = caps_sensitive,
	}

	return {
		properties = cuhFramework.commands.registeredCommands[id],

		---Edit the properties of this command
		---@param new_command_name string|nil The name of the command, example: "my_command". If this is nil, the name of the command will not be changed
		---@param new_shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c". If this is nil, the shorthands of the command will not be changed
		---@param new_caps_sensitive boolean|nil Whether or not the command should be caps sensitive. If this is nil, the command will remain caps sensitive or not caps sensitive depending on what it was set to beforehand
		---@param new_callback function|nil The function that will be called upon a player typing the command. If this is nil, the command callback will not be changed
		---@return table command The command itself
		edit = function(self, new_command_name, new_shorthands, new_caps_sensitive, new_callback)
			self.properties.command_name = new_command_name or self.properties.command_name
			self.properties.shorthands = new_shorthands or self.properties.shorthands
			self.properties.callback = new_callback or self.properties.callback
			self.properties.caps_sensitive = new_caps_sensitive or self.properties.caps_sensitive

			return self
		end,

		---Removes the command permanently
		remove = function(self)
			cuhFramework.commands.registeredCommands[self.properties.id] = nil
		end
	}
end

---Get a command by the name
---@param command_name string The name of the command
---@param caps_sensitive_search boolean|nil Whether or not the search should be caps sensitive, example: if a command is named "Hey" and you look for a command named "hey" with caps_sensitive set to false, it will return the command with the name of "Hey"
---@return table|nil command The command, or nil if not found
cuhFramework.commands.getCommandFromName = function(command_name, caps_sensitive_search)
	for i, v in pairs(cuhFramework.commands.registeredCommands) do
		if caps_sensitive_search then
			if v.command_name == command_name then
				return v
			end
		else
			if v.command_name:lower() == command_name:lower() then
				return v
			end
		end
	end
end

---Remove a command by its ID
---@param command_id integer The ID of the command. To get the ID of a command: cuhFramework.commands.create("my_command", {"m_c", "mc"}, function() end, false).properties.id or use cuhFramework.commands.getCommandFromName()
---@return nil
cuhFramework.commands.remove = function(command_id)
	cuhFramework.commands.registeredCommands = nil
end

---Manage commands [BACKEND]
cuhFramework.callbacks.onCustomCommand:connect(function(msg, peer_id, is_admin, is_auth, command, ...)
	command = command:sub(2, #command) --"?hey" becomes "hey"

	for i, v in pairs(cuhFramework.commands.registeredCommands) do
		-- caps sensitive
		if v.caps_sensitive then
			if v.command_name == command or cuhFramework.utilities.table.valueInTable(v.shorthands, command) then
				v.callback(msg, peer_id, is_admin, is_auth, command, ...)
			end
		else
			-- not caps sensitive
			if v.command_name:lower() == command:lower() or cuhFramework.utilities.table.valueInTable(cuhFramework.utilities.table.lowercaseStringValues(v.shorthands), command:lower()) then
				v.callback(msg, peer_id, is_admin, is_auth, command, ...)
			end
		end
	end
end)

----------------------------------------
----------------------------------------
--//Framework - Chat\\--
----------------------------------------
----------------------------------------
---Sends a message into chat
---@param author string The orange text in chat, if author was "Bob", in chat, it would look like: "Bob			(message here)"
---@param message string|table What to send in chat (can be a string or a table)
---@param peer_id number|nil The peer to send the message to, -1 = all. If this is nil, the peer_id will become -1
---@return nil
cuhFramework.chat.send_message = function(author, message, peer_id)
	local msg = ""

	if type(message) == "table" then
		msg = table.concat(cuhFramework.utilities.table.tostringValues(message), " ")
	elseif type(message) == "string" then
		msg = message
	end

	server.announce(author, msg, peer_id)
end

---Clears the chat by sending 11 blank messages
---@return nil
cuhFramework.chat.clear = function()
	for _ = 1, 11 do
		cuhFramework.chat.send_message("", " ")
	end
end

----------------------------------------
----------------------------------------
--//Framework - Players\\--
----------------------------------------
----------------------------------------
cuhFramework.players.connectedPlayers = {
	[-10] = { -- example player for vscode intellisense
		properties = {
			peer_id = -10,
			admin = false,
			auth = false,
			name = "examplePlayer",
			steam_id = -100000
		},

		---Kicks this player
		---@return nil
		kick = function(self)
		end,

		---Bans this player, cannot be undone due to Stormworks limitations
		---@return nil
		ban = function(self)
		end,

		---Teleports this player to a matrix
		---@param pos SWMatrix Position to teleport the player to
		---@return boolean success Whether or not the teleport was successful
		teleport = function(self, pos)
		end,

		---Sends a fake message that looks like it was sent by this player
		---@param message string The message to send in chat
		---@param target_peer_id int|nil Who the message should get sent to. -1 = all, -1 is default if target_peer_id is nil
		---@return nil
		fake_chat = function(self, message, target_peer_id)
		end,

		---Returns the position of this player
		---@return SWMatrix playerPosition The matrix position of this player
		---@return boolean success Whether or not the position of this player was retrieved successfully
		get_position = function(self, pos)
		end,

		---Gives/Removes admin from this player
		---@param give boolean True = Give admin, false = Remove admin
		---@return nil
		setAdmin = function(self, give)
		end,

		---Gives/Removes auth from this player
		---@param give boolean True = Give auth, false = Remove auth
		---@return nil
		setAuth = function(self, give)
		end,

		---Give this player an item
		---@param slot SWSlotNumberEnum What slot the item should be placed in (1-10)
		---@param item SWEquipmentTypeEnum ID of the item you want to give to this player
		---@param int integer Ammo/Charge/etc
		---@param float float Ammo/Charge/etc
		---@param active boolean Whether or not the item starts as active (eg: Rifle immediately shoots if active is true)
		---@return boolean success Whether or not this was successful
		giveItem = function(self, slot, item, int, float, active)
		end,

		---Remove the item placed in a slot
		---@param slot SWSlotNumberEnum Slot to look for (1-10)
		---@return boolean success Whether or not this was successful
		removeItem = function(self, slot)
		end
	}
}

-- Update connectedPlayers [Backend]
cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, is_admin, is_auth)
	local data = {
		properties = {
			peer_id = peer_id,
			admin = is_admin,
			auth = is_auth,
			name = name,
			steam_id = steam_id,
		},

		kick = function(self)
			server.kickPlayer(self.properties.peer_id)
		end,

		ban = function(self)
			server.banPlayer(self.properties.peer_id)
		end,

		teleport = function(self, pos)
			return server.setPlayerPos(self.properties.peer_id, pos)
		end,

		fake_chat = function(self, message, target_peer_id)
			cuhFramework.chat.send_message(self.properties.name, message, target_peer_id)
		end,

		get_position = function(self)
			local pos, success = server.getPlayerPos(self.properties.peer_id)
			return pos, success
		end,

		setAdmin = function(self, give)
			if give then
				server.addAdmin(self.properties.peer_id)
			else
				server.removeAdmin(self.properties.peer_id)
			end
		end,

		setAuth = function(self, give)
			if give then
				server.addAuth(self.properties.peer_id)
			else
				server.removeAuth(self.properties.peer_id)
			end
		end,

		giveItem = function(self, slot, item, int, float, active)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.setCharacterItem(char_id, slot, item, active, int, float)
		end,

		removeItem = function(self, slot)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.setCharacterItem(char_id, slot, 0, false, 0, 0)
		end
	}

	cuhFramework.players.connectedPlayers[peer_id] = data
end)

cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, is_admin, is_auth)
	cuhFramework.utilities.delay.create(0.05, function() -- wait some time before removing data, that way addon creators can get player data when they leave
		cuhFramework.players.connectedPlayers[peer_id] = nil
	end)
end)

---Get a player by their peer_id
---@param peer_id integer Peer ID of the player you want to get
cuhFramework.players.getPlayerByPeerId = function(peer_id)
	return cuhFramework.players.connectedPlayers[peer_id]
end

---Get a player by their Steam ID
---@param steam_id integer Steam ID of the player you want to get
cuhFramework.players.getPlayerBySteamId = function(steam_id)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if cuhFramework.utilities.string.tostring(v.properties.steam_id) == cuhFramework.utilities.string.tostring(steam_id) then
			return v
		end
	end
end

---Get a player by their Steam ID
---@param name string Name of the player
---@param caps_sensitive boolean Whether or not the search should be caps sensitive
cuhFramework.players.getPlayerByName = function(name, caps_sensitive)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if caps_sensitive then
			if v.properties.name:lower() == name:lower() then
				return v
			end
		else
			if v.properties.name == name then
				return v
			end
		end
	end
end

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Addon Code
------------------------------------------------------------------------
------------------------------------------------------------------------

-- cuh everything ;)
local my_command = cuhFramework.commands.create("my_command", {"mc", "m_c"}, function()
    cuhFramework.utilities.chat.send_message("myAddon", "someone activated my command")
end, false)

my_command:edit("new_command", nil, false, function()
    cuhFramework.utilities.chat.send_message("myaddon", "s")
end)

cuhFramework.utilities.delay.create(10, function()
    cuhFramework.utilities.chat.send_message("guhh", "guhh")
end)

cuhFramework.callbacks.onPlayerSit:connect(function()
    cuhFramework.utilities.chat.send_message("s", "s")
end)

cuhFramework.utilities.loop.create(5, function()
    cuhFramework.utilities.chat.send_message("cuhh", "loop every 5 secs")
end)