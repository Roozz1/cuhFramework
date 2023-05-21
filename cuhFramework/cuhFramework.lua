------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--[[
	------
	Information
	------
	This is the cuhFramework.lua file, which contains the entirety of cuhFramework.
	It is HIGHLY recommended that you code your addon in a different .lua file (script.lua or another file),
	then when you are ready, run 'cuhFramework - Build Project.exe' to combine your code with this framework,
	ready to use in-game.

	It is highly recommended that you use the popular Lua LSP extension on VSCode,
	and it is also highly recommended that you use NameousChangey's Stormworks Lua with LifeboatAPI
	VSCode Extension.

	If you're not already, make sure to code your addon with something like VSCode, and do not use the in-game
	editor because, chances are, your code and this framework will not fit within the in-game addon character limit.
	The limit can be bypassed if you code outside of in-game (using something like VSCode as said), which is why
	you shouldn't code your addon in-game.

	------
	Documentation:
	------
	To see the documentation, head over to the wiki page at https://github.com/Roozz1/cuhFramework.
]]

----------------------------------------
----------------------------------------
--//Framework\\--
----------------------------------------
----------------------------------------
cuhFramework = {
	players = {},
	vehicles = {},
	objects = {},
	creatures = {},
	characters = {},
	savedata = {},
	tps = {},
	customZones = {},
	ui = {},
	disasters = {},
	animation = {},
	http = {},

	utilities = {},
	callbacks = {},
	customCallbacks = {},
	references = {},

	chat = {},
	commands = {},

	backend = {
		updates = {
			---Insert update function. Don't use this
			---@param func function Function that should be called every tick
			insert = function(self, func)
				table.insert(self, func)
			end,

			---Create an exception. The exception will not be called by onTick. Don't use this
			---@param exception function The function to exclude
			create_exception = function(self, exception)
				table.insert(self.exceptions, exception)
			end,

			exceptions = {}
		}
	}
}

----------------------------------------
----------------------------------------
--//Backend - Updates [DO NOT USE]\\--
----------------------------------------
----------------------------------------
cuhFramework.backend.updates:create_exception(cuhFramework.backend.updates.create_exception)
cuhFramework.backend.updates:create_exception(cuhFramework.backend.updates.insert)

----------------------------------------
----------------------------------------
--//Framework - Callbacks\\--
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
	-- Backend - Update
	for i, v in pairs(cuhFramework.backend.updates) do
		if cuhFramework.utilities.table.isValueInTable(cuhFramework.backend.updates.exceptions, v) then -- yeah this isn't so good for performance but oh well
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
--//Framework - Custom Callbacks\\--
----------------------------------------
----------------------------------------
cuhFramework.customCallbacks.onCommandActivated = {
	connections = {},
	---Connect a function to onCommandActivated (custom)
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

----------------

cuhFramework.customCallbacks.onVehicleSpawn = {
	connections = {},
	---Connect a function to onVehicleSpawn (custom)
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

----------------

cuhFramework.customCallbacks.onVehicleLoad = {
	connections = {},
	---Connect a function to onVehicleLoad (custom)
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

----------------

cuhFramework.customCallbacks.onVehicleDespawn = {
	connections = {},
	---Connect a function to onVehicleDespawn (custom)
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
---@param sep string|nil Pattern to split the string by
---@return table split_string The split string in a table
cuhFramework.utilities.string.split = function(str, sep)
	if sep == nil then
		sep = "%s"
	end

	local split_string = {}

	for strn in string.gmatch(str, "([^"..sep.."]+)") do
		cuhFramework.utilities.table.insert(split_string, strn)
	end

	return split_string
end

---Converts anything into a string, alias to tostring()
---@param input any|nil The input to convert to a string
---@return string string The tostring()'d version of input
cuhFramework.utilities.string.tostring = function(input)
	return tostring(input)
end

---Converts a string to a bool. "true"/"True"/"TrUe" becomes true. "false"/"False"/"FalSe" becomes false. Anything else becomes nil
---@param str string The string to convert to a bool
---@return boolean|nil bool True or false depending on the string. Nil if the string doesn't match true or false
cuhFramework.utilities.string.tobool = function(str)
	if input:lower() == "true" then
		return true
	elseif input:lower() == "false" then
		return false
	end
end

---Replaces occurences in a string with something else, alias to string.gsub()
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
cuhFramework.utilities.table.isValueInTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			return true
		end
	end

	return false
end

---Get the amount of values in a table
---@param tbl table Table to check
---@return integer value_count The amount of values in this table
cuhFramework.utilities.table.getValueCountOfTable = function(tbl)
	local count = 0

	for _ in pairs(tbl) do
		count = count + 1
	end

	return count
end

---Remove a value from a table
---@param tbl table Table to look in
---@param value any What value to remove from the table
---@return boolean removed Whether or not the value was found and removed
cuhFramework.utilities.table.removeValueFromTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			table.remove(tbl, i)
			return true
		end
	end

	return false
end

---Get a value from a table
---@param tbl table Table to look in
---@param value any What value to look for in the table
---@return any|nil value The value, or nil if not found
cuhFramework.utilities.table.getValueInTable = function(tbl, value)
	for i, v in pairs(tbl) do
		if v == value then
			return v
		end
	end
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
cuhFramework.utilities.table.insert = function(tbl, value)
	table.insert(tbl, value)
end

---Get a random value in a table
---@param tbl table Table to get a random value from
---@return any randomTableValue The random table value, or nil if there are no values in the table
cuhFramework.utilities.table.getRandomValue = function(tbl)
	local count = #tbl

	if count < 1 then
		return
	end

	return tbl[math.random(1, count)]
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

---Get the sum of all number values in a table
---@param tbl table Table of values to sum up
---@return number result The added values
cuhFramework.utilities.table.sumOfTable = function(tbl)
	local current = 0

	for i, v in pairs(tbl) do
		if type(v) == "number" then
			current = current + v
		end
	end

	return current
end

---Get the value count in a table (recommended to do #tbl instead of using this)
---@param tbl table Table to check
---@return integer valueCount The amount of values in this table
cuhFramework.utilities.table.valueCount = function(tbl)
	local count = 0

	for i, v in pairs(tbl) do
		count = count + 1
	end

	return count
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

---Converts a string/bool into a number
---@param input string|bool|number The number to convert into a float
---@return number number The new number, or 0 if failure
cuhFramework.utilities.number.tonumber = function(input)
	if type(input) == "bool" then
		if input then
			return 1
		else
			return 0
		end
	end

	return tonumber(input) or 0
end

---Round a number 
---@param input number The number to round 
---@param numDecimalPlaces integer Amount of decimal places to round to 
---@return number roundedNumber The rounded number, or 0 if rounding error 
 cuhFramework.utilities.number.round = function(input, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(input * mult + 0.5) / mult
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
------Matrix
------------------------
cuhFramework.utilities.matrix = {}

---Offset position
---@param position SWMatrix The position to offset
---@param x number|nil X offset
---@param y number|nil Y offset
---@param z number|nil Z offset
---@return SWMatrix newPosition The offset position
cuhFramework.utilities.matrix.offsetPosition = function(position, x, y, z)
	return cuhFramework.references.matrix.translation(position[13] + (x or 0), position[14] +(y or 0), position[15] + (z or 0))
end

---Scatter position, think utilities.matrix.offsetPosition but by a random amount
---@param position SWMatrix The position to scatter
---@param amount integer The amount to scatter the position by (if amount is 2, it becomes math.random(-2, 2) in this function)
---@param shouldApplyToY boolean|nil Whether or not to scatter the Y position too (default is false)
---@return SWMatrix newPosition The new position
cuhFramework.utilities.matrix.scatterPosition = function(position, amount, shouldApplyToY)
	if not shouldApplyToY then
		return cuhFramework.utilities.matrix.offsetPosition(position, math.random(-amount, amount), 0, math.random(-amount, amount))
	else
		return cuhFramework.utilities.matrix.offsetPosition(position, math.random(-amount, amount), math.random(-amount, amount), math.random(-amount, amount))
	end
end

------------------------
------Miscellaneous
------------------------
cuhFramework.utilities.miscellaneous = {}

---Switch between two values depending on the state of something
---@param off any The return value if switch is false/nil
---@param on any The return value if switch is anything apart from false and nil
---@param switch boolean|any Switch between the off and on value
---@return any
cuhFramework.utilities.miscellaneous.switchbox = function(off, on, switch)
	if switch then
		return on
	else
		return off
	end
end

---Get the closest player to a position
---@param position SWMatrix The position to check
---@param exceptions table<any, player>|nil A table containing players to ignore
---@return player|nil
cuhFramework.utilities.miscellaneous.getClosestPlayerToPosition = function(position, exceptions)
	local recentPlayer = nil
	local recentDistance = -1

	local list = {}

	if exceptions then
		for i, v in pairs(exceptions) do
			list[v.properties.peer_id] = true
		end
	end

	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if list[v.properties.peer_id] then
			goto continue
		end

		local player_position = v:get_position()
		local distance = cuhFramework.references.matrix.distance(player_position, position)

		if distance < recentDistance or recentDistance == -1 then
			recentDistance = distance
			recentPlayer = v
		end

	    ::continue::
	end

	return recentPlayer
end

------------------------
------Delays
------------------------
local delay_id = 0
cuhFramework.utilities.delay = {}
cuhFramework.utilities.delay.ongoingDelays = {}

---Update delays, don't use this
cuhFramework.utilities.delay.update = function()
	for i, v in pairs(cuhFramework.utilities.delay.ongoingDelays) do
		local timeNow = server.getTimeMillisec()
		if timeNow >= v.creationTime + (v.time * 1000) and not v.paused then
			v.callback(v.id, table.unpack(v.args))
			cuhFramework.utilities.delay.remove(v.id)
		end
	end
end

cuhFramework.backend.updates:insert(cuhFramework.utilities.delay.update) -- reference

---Call a function after x seconds
---@param duration number How long until the callback is called in seconds
---@param callback function The function to call after the delay is manually called or when the delay naturally completes itself
---@param ... any Arguments to pass through to the delay callback
cuhFramework.utilities.delay.create = function(duration, callback, ...)
    local id = delay_id
	delay_id = delay_id + 1

	cuhFramework.utilities.delay.ongoingDelays[id] = {
		callback = callback,
		args = {...},
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
local loop_id = 0
cuhFramework.utilities.loop = {}
cuhFramework.utilities.loop.ongoingLoops = {}

---Update loops, don't use this
cuhFramework.utilities.loop.update = function()
	for i, v in pairs(cuhFramework.utilities.loop.ongoingLoops) do
		local timeNow = server.getTimeMillisec()
		if timeNow >= v.creationTime + (v.time * 1000) and not v.paused then
			v.callback(v.id, table.unpack(v.args))
			v.creationTime = timeNow
		end
	end
end

cuhFramework.backend.updates:insert(cuhFramework.utilities.loop.update) -- reference

---Call a function every x seconds
---@param duration number How long until the callback is called in seconds
---@param callback function The function to call after the loop is manually called or when a loop iteration has completed
---@param ... any Arguments to pass through to the loop callback
cuhFramework.utilities.loop.create = function(duration, callback, ...)
    local id = loop_id
	loop_id = loop_id + 1

	cuhFramework.utilities.loop.ongoingLoops[id] = {
		callback = callback,
		args = {...},
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

------------------------
------Animation
------------------------

------------------------
------Intellisense
------------------------
---@class animation
---@field properties animation_properties
---@field remove function<animation> Remove this animation
---@field setPaused function<animation, boolean> Pause/Unpause this animation
---@field setLooped function<animation, boolean> Make this animation loop/not loop
---@field isFinished function<animation> Returns whether or not the animation is finished. Same as doing animation.properties.finished
---@field edit function<animation, SWMatrix|nil, SWMatrix|nil, SWMatrix|nil, number|nil> Edit this animation. Order: new_start_position, new_destination_position, new_current_position, new_increment. If any is nil, it will not be changed

---@class animation_properties
---@field start_pos SWMatrix The start position of the animation
---@field current_pos SWMatrix The position the animation is currently at
---@field destination_pos SWMatrix The end position of the animation
---@field paused boolean Whether or not the animation is paused
---@field looping boolean Whether or not the animation repeats after
---@field increment number I can't think of the right words to use to explain this, you probably know what this is though, mainly because you're a smart, lovable human being, and you are truly awesome. You make other people's days good, even when you're having a bad day, and that is why you are truly awesome and lovable. You are the person everyone looks up to when they desire to be a perfect human being. Keep being you. Because you are amazing.
---@field callback function The function that is called every animation tick. One argument is passed through, the animation data
---@field id integer The ID of this animation
---@field finished boolean Whether or not the animation has been completed.
---@field type string Type of animation

------------------------
------Animation
------------------------
---@type table<integer, animation>
cuhFramework.animation.ongoingAnimations = {}

---Create a linear animation. Does not support rotation, only XYZ position
---@param start_position SWMatrix The position for the animation to start at
---@param desired_position SWMatrix The position for the animation to end at
---@param increment number I can't think of the right words to use to explain this, you probably know what this is though, mainly because you're a smart, lovable human being, and you are truly awesome. You make other people's days good, even when you're having a bad day, and that is why you are truly awesome and lovable. You are the person everyone looks up to when they desire to be a perfect human being. Keep being you. Because you are amazing.
---@param should_loop boolean Whether or not the animation should repeat upon reaching the desired position
---@param callback function<animation> The function that is called every animation tick. One argument is passed through, the animation itself
cuhFramework.animation.createLinearAnimation = function(start_position, desired_position, increment, should_loop, callback)
	local id = #cuhFramework.animation.ongoingAnimations + 1
	cuhFramework.animation.ongoingAnimations[id] = {
		properties = {
			start_pos = start_position,
			current_pos = matrix.translation(start_position[13], start_position[14], start_position[15]),
			destination_pos = desired_position,
			paused = false,
			looping = should_loop,
			increment = increment,
			callback = callback,
			id = id,
			finished = false,
			type = "linear"
		},

		remove = function(self)
			return cuhFramework.animation.removeAnimation(self.properties.id)
		end,

		setPaused = function(self, state)
			self.properties.paused = state
		end,

		setLooped = function(self, state)
			self.properties.looping = state
		end,

		isFinished = function(self)
			return self.properties.finished
		end,

		edit = function(self, new_start_position, new_destination_position, new_current_position, new_increment)
			self.properties.start_pos = new_start_position or self.properties.start_pos
			self.properties.destination_pos = new_destination_position or self.properties.destination_pos
			self.properties.current_pos = new_current_position or self.properties.current_pos
			self.properties.increment = new_increment or self.properties.increment
		end
	}

	return cuhFramework.animation.ongoingAnimations[id]
end

---Remove an animation by its ID
---@param id integer The ID of the animation. You can get the ID of an animation on creation. For example: cuhFramework.animation.createAnimation(...).properties.id
---@return nil
cuhFramework.animation.removeAnimation = function(id)
	cuhFramework.animation.ongoingAnimations[id] = nil
end

---Manage animations
cuhFramework.backend.updates:insert(function()
	for i, v in pairs(cuhFramework.animation.ongoingAnimations) do
		-- quick check
		if v.properties.paused then
			goto continue
		end

		if v.properties.looping and v.properties.finished then
			v.properties.finished = false
		end

		-- it gets messy kinda, but yeah main animation handling stuff here
		local got_to_destination_count = 0
		if v.properties.type == "linear" then
			for i2 = 1, 3 do
				-- check if reached destination, fuck precision all the homies hate precision btw
				if v.properties.current_pos[12 + i2] > v.properties.destination_pos[12 + i2] - v.properties.increment and v.properties.current_pos[12 + i2] < v.properties.destination_pos[12 + i2] + v.properties.increment then
					got_to_destination_count = got_to_destination_count + 1
					goto continue
				end

				-- some checks and moving and some stuff too and other stuff
				if v.properties.current_pos[12 + i2] < v.properties.destination_pos[12 + i2] then
					v.properties.current_pos[12 + i2] = v.properties.current_pos[12 + i2] + v.properties.increment
				elseif v.properties.current_pos[12 + i2] > v.properties.destination_pos[12 + i2] then
					v.properties.current_pos[12 + i2] = v.properties.current_pos[12 + i2] - v.properties.increment
				end

				-- jggjh
				::continue::
			end
		end

		-- check if animation is done
		if got_to_destination_count == 3 then -- 3 because x y z
			-- set finished
			v.properties.finished = true

			-- repeat anim
			if v.properties.looping then
				local old = v.properties.start_pos
				v.properties.start_pos = v.properties.destination_pos
				v.properties.destination_pos = old
			end
		end

		-- call callback, also since we are using ":", v is passed into the function!! wooooooooo!!!!!
		v.properties.callback(v)

		-- good old goto statement
		::continue::
	end
end)

----------------------------------------
----------------------------------------
----------------------------------------
--//Framework - Savedata\\--
----------------------------------------
----------------------------------------
g_savedata = {}

------------------------
------Savedata
------------------------
cuhFramework.savedata.saved_data = g_savedata

---Save a value to save data. Functions cannot be saved
---@param value any The value to save. Cannot be a function
---@param index any|nil The index of the value. If nil, none will be used. Example (if nil): {value1, value}. Example (if not nil): {index_here = value1, index_here = value}. Cannot be a function. The index is also converted to a string
---@param key any|nil The key to give the value, can be nil if the value doesn't have a key. This is useless if index is nil. Gets converted to a string within this function
---@return nil
cuhFramework.savedata.add = function(value, index, key)
	if key then
		key = tostring(key)
	end

	if index then
		index = tostring(index)
	end

	if key and index then
		index = key.."_"..index
	end

	if index then
		g_savedata[index] = value
	else
		cuhFramework.utilities.table.insert(g_savedata, value)
	end
end

---Remove a value from save data
---@param value any The value to remove. Cannot be a function
---@param index any|nil The index to use when searching for the value to remove (instead of looping through the values, it removes parent[index]). If nil, this function will just loop through the values to find and remove the passed value
---@param key any|nil The key of the value, can be nil if the value doesn't have a key. This is useless if index is nil. Gets converted to a string within this function
---@return nil
cuhFramework.savedata.remove = function(value, index, key)
	if key then
		key = tostring(key)
	end

	if index then
		index = tostring(index)
	end

	if key and index then
		index = key.."_"..index
	end

	if index then
		g_savedata[index] = nil
	else
		cuhFramework.utilities.table.removeValueFromTable(g_savedata, value)
	end
end

---Get a value from save data
---@param value any The value to find
---@param index any|nil The index to use when searching (instead of looping through the values, it returns parent[index]). If nil, this function will just loop through the values to find the desired value
---@param key any|nil The key of the value, can be nil if the value doesn't have a key. This is useless if index is nil. Gets converted to a string within this function
---@return any|nil value The retrieved value, or nil if not found
cuhFramework.savedata.get = function(value, index, key)
	if key then
		key = tostring(key)
	end

	if index then
		index = tostring(index)
	end

	if key and index then
		index = key.."_"..index
	end

	if index then
		return g_savedata[index]
	else
		return cuhFramework.utilities.table.getValueInTable(g_savedata, value)
	end
end

------------------------
------Misc
------------------------
---Save the game, only works in dedicated servers. Pretty much an alias to server.save()
---@param save_name string|nil The name of the save. If nil, autosave will be used (I think)
---@return nil
cuhFramework.savedata.save = function(save_name)
	return server.save(save_name)
end

----------------------------------------
----------------------------------------
----------------------------------------
--//Framework - Commands\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class command
---@field id integer The ID of this command
---@field command_name string The name of this command
---@field shorthands table The shorthands of this command
---@field caps_sensitive boolean|nil Whether or not this command is caps sensitive
---@field callback function The callback that is called upon the command being executed
---@field description string The description of the command, unused in cuhFramework, but may be useful if you want to create a '?help' command.

------------------------
------Commands
------------------------
---@type table<integer, command>
cuhFramework.commands.registeredCommands = {}

---Create a command
---@param command_name string The name of the command, example: "my_command"
---@param shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c"
---@param caps_sensitive boolean|nil Whether or not the command is caps sensitive
---@param callback function The function that will be called upon a player typing the command
---@param description string|nil The description of this command
cuhFramework.commands.create = function(command_name, shorthands, caps_sensitive, callback, description)
	if type(shorthands) == "string" then
		shorthands = {shorthands}
	end

	local id = #cuhFramework.commands.registeredCommands + 1
	cuhFramework.commands.registeredCommands[id] = {
		id = id,
		command_name = command_name,
		shorthands = shorthands or {},
		caps_sensitive = caps_sensitive,
		callback = callback,
		description = description or ""
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
			self.properties.caps_sensitive = new_caps_sensitive or self.properties.caps_sensitive
			self.properties.callback = new_callback or self.properties.callback

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
cuhFramework.commands.remove = function(command_id)
	cuhFramework.commands.registeredCommands = nil
end

---Manage commands [Backend]
cuhFramework.callbacks.onCustomCommand:connect(function(msg, peer_id, is_admin, is_auth, command, ...)
	-- get variables
	local player = cuhFramework.players.getPlayerByPeerId(peer_id)
	local edited_command = command:sub(2, -1) --"?hey" becomes "hey"

	for i, v in pairs(cuhFramework.commands.registeredCommands) do
		if v.caps_sensitive then
			-- caps sensitive
			if v.command_name == edited_command or cuhFramework.utilities.table.isValueInTable(v.shorthands, edited_command) then
				for _, con in pairs(cuhFramework.customCallbacks.onCommandActivated.connections) do
					con(v, player, ...)
				end

				v.callback(msg, peer_id, is_admin, is_auth, command, ...)
			end
		else
			-- not caps sensitive
			if v.command_name:lower() == edited_command:lower() or cuhFramework.utilities.table.isValueInTable(cuhFramework.utilities.table.lowercaseStringValues(v.shorthands), edited_command:lower()) then
				for _, con in pairs(cuhFramework.customCallbacks.onCommandActivated.connections) do
					con(v, player, ...)
				end

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
---@param player player|nil The player to send the message to. If this is nil, the message will be sent to everyone
cuhFramework.chat.send_message = function(author, message, player)
	local msg = tostring(message)

	if type(message) == "table" then
		msg = table.concat(cuhFramework.utilities.table.tostringValues(message), " ")
	end

	if player then
		server.announce(author, msg, player.properties.peer_id)
	else
		server.announce(author, msg)
	end
end

---Clears the chat by sending 11 blank messages
---@param player player|nil The player to clear chat for. If this is nil, chat will be cleared for everyone
cuhFramework.chat.clear = function(player)
	for _ = 1, 11 do
		cuhFramework.chat.send_message("", " ", player)
	end
end

----------------------------------------
----------------------------------------
--//Framework - Players\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class playerProperties
---@field peer_id integer The peer_id of this player
---@field admin boolean Whether or not this player is an admin
---@field auth boolean Whether or not this player is authed
---@field name string The name of this player
---@field steam_id integer The steam_id of this player
---@field disconnecting boolean Whether or not the player is leaving the server

---@class player
---@field properties playerProperties The properties of this player
---@field kick function<player> Kick this player
---@field ban function<player> Ban this player
---@field kill function<player> Kills this player
---@field teleport function<player, SWMatrix> Teleport this player to a position
---@field fake_chat function<player, string, player|nil> Send a fake message that seems like this player sent it
---@field get_position function<player> Returns the position of this player as a matrix
---@field set_admin function<player, boolean> Gives this player admin/Removes it
---@field set_auth function<player, boolean> Gives this player auth/Removes it
---@field give_item function<player, SWSlotNumberEnum, SWEquipmentTypeEnum, integer, float, boolean|nil> Gives this player an item
---@field remove_item function<player, SWSlotNumberEnum> Removes an item in the specified slot from this player
---@field get_item function<player, SWSlotNumberEnum> Return the item in the specified slot
---@field damage function<player, number> Apply damage to a player, pass a negative number to heal
---@field get_character function<player> Returns the object ID of this player's character
---@field seat function<player, vehicle, seat_name> Places this player in a seat

------------------------
------Players
------------------------
---@type table<integer, player>
cuhFramework.players.connectedPlayers = {}

-- Update connectedPlayers [Backend]
cuhFramework.backend.givePlayerData = function(steam_id, name, peer_id, is_admin, is_auth)
	local data = {
		properties = {
			peer_id = peer_id,
			admin = is_admin,
			auth = is_auth,
			name = name,
			steam_id = steam_id,
			disconnecting = false
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

		fake_chat = function(self, message, target_player)
			cuhFramework.chat.send_message(self.properties.name, message, target_player)
		end,

		get_position = function(self)
			local pos = server.getPlayerPos(self.properties.peer_id)
			return pos
		end,

		set_admin = function(self, give)
			if give then
				server.addAdmin(self.properties.peer_id)
			else
				server.removeAdmin(self.properties.peer_id)
			end
		end,

		set_auth = function(self, give)
			if give then
				server.addAuth(self.properties.peer_id)
			else
				server.removeAuth(self.properties.peer_id)
			end
		end,

		give_item = function(self, slot, item, int, float, active)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.setCharacterItem(char_id, slot, item, active, int, float)
		end,

		remove_item = function(self, slot)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.setCharacterItem(char_id, slot, 0, false, 0, 0)
		end,

		get_item = function(self, slot)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			return server.getCharacterItem(char_id, slot)
		end,

		kill = function(self)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			-- server.killCharacter(char_id) -- tends to call onPlayerDie twice
			server.setCharacterData(char_id, 0, false, false)
		end,

		damage = function(self, amount)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			local data = server.getCharacterData(char_id)

			if not data then
				return
			end

			server.setCharacterData(char_id, data.hp - amount, data.interactible, data.ai)
		end,

		get_character = function(self)
			return server.getPlayerCharacterID(self.properties.peer_id)
		end,

		seat = function(self, vehicle, seat_name)
			local char_id, success = self:get_character()

			if not success then
				return
			end

			return server.setCharacterSeated(char_id, vehicle.properties.vehicle_id, seat_name)
		end
	}

	cuhFramework.players.connectedPlayers[peer_id] = data
end

cuhFramework.backend.giveDataToCurrentPlayers = function(shouldFireEvents)
	for i, v in pairs(server.getPlayers()) do
		cuhFramework.backend.givePlayerData(v.steam_id, v.name, v.id, v.admin, v.auth)

		if not shouldFireEvents then
			goto continue
		end

		cuhFramework.utilities.delay.create(0.02, function()
			for _, connection in pairs(cuhFramework.callbacks.onPlayerJoin.connections) do
				connection(v.steam_id, v.name, v.id, v.admin, v.auth)
			end

			local char_id = server.getPlayerCharacterID(v.id)

			for _, connection in pairs(cuhFramework.callbacks.onObjectLoad.connections) do
				connection(char_id)
			end
		end)
	end

    ::continue::
end

cuhFramework.callbacks.onPlayerJoin:connect(function(steam_id, name, peer_id, is_admin, is_auth)
	cuhFramework.backend.givePlayerData(steam_id, name, peer_id, is_admin, is_auth)

	-- and show running ui (extremely useful)
	cuhFramework.utilities.delay.create(0.01, function()
		for i, v in pairs(cuhFramework.ui.screen.activeUI) do
			if not v.properties.player then
				server.setPopupScreen(peer_id, v.properties.id, "", v.properties.visible, v.properties.text, v.properties.x, v.properties.y)
			end
		end
	end)
end)

cuhFramework.backend.giveDataToCurrentPlayers(true)

cuhFramework.utilities.loop.create(0.1, function() -- update player properties (auth, etc)
	cuhFramework.backend.giveDataToCurrentPlayers(false)
end)

cuhFramework.callbacks.onPlayerLeave:connect(function(steam_id, name, peer_id, is_admin, is_auth)
	for i, v in pairs(cuhFramework.ui.screen.activeUI) do
		if v.properties.player then
			if v.properties.player == cuhFramework.players.getPlayerByPeerId(peer_id) then
				cuhFramework.ui.screen.remove(v.properties.id)
			end
		end
	end

	cuhFramework.players.connectedPlayers[peer_id].properties.disconnecting = true

	cuhFramework.utilities.delay.create(0.1, function()
		cuhFramework.players.connectedPlayers[peer_id] = nil
	end)
end)

---Get a player by their peer_id
---@param peer_id integer Peer ID of the player you want to get
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByPeerId = function(peer_id)
	return cuhFramework.players.connectedPlayers[peer_id] or nil
end

---Get a player by their Steam ID
---@param steam_id integer Steam ID of the player you want to get
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerBySteamId = function(steam_id)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if cuhFramework.utilities.string.tostring(v.properties.steam_id) == cuhFramework.utilities.string.tostring(steam_id) then
			return v
		end
	end
end

---Get a player by an object ID
---@param object_id integer The object ID of the player
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByObjectId = function(object_id)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if (server.getPlayerCharacterID(v.properties.peer_id)) == object_id then
			return v
		end
	end
end

---Get a player by their name
---@param name string Name of the player
---@param caps_sensitive boolean Whether or not the search should be caps sensitive
---@return player player The retrieved player, or nil if no player found
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

---Get a player by their name, but a partial name is allowed (award for best function name goes to me)
---@param name string Name/Partial name of the player
---@param caps_sensitive boolean Whether or not the search should be caps sensitive
---@return player player The retrieved player, or nil if no player found
cuhFramework.players.getPlayerByNameWithAllowedPartialName = function(name, caps_sensitive)
	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		if not caps_sensitive then
			if v.properties.name:lower():gsub(" ", ""):find(name:lower():gsub(" ", "")) then
				return v
			end
		else
			if v.properties.name:gsub(" ", ""):find(name:gsub(" ", "")) then
				return v
			end
		end
	end
end

---Get player count
---@param isDedicatedServer boolean|nil Whether or not this addon is running in a dedicated server, set to true if this addon is running in a dedicated server
---@return integer playerCount Number of players in the server
cuhFramework.players.getPlayerCount = function(isDedicatedServer)
	local count = cuhFramework.utilities.table.getValueCountOfTable(cuhFramework.players.connectedPlayers)

	if isDedicatedServer then
		return count - 1
	else
		return count
	end
end

----------------------------------------
----------------------------------------
--//Framework - HTTP\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class http_get_request
---@field port integer The port of the request
---@field url string The URL of the request (eg: "/my_thingy". you can only send a rqeuest ot localhost)
---@field callback function|nil The function that will be called when this request receives a reply
---@field id integer The ID of the request data

---@class url_arg
---@field name string The name of the argument to be passed through (becomes: "?name=value")
---@field value string The value itself (becomes: "?name=value")

------------------------
------HTTP
------------------------
---@type table<integer, http_get_request>
cuhFramework.http.requests = {}

---Send a get request
---@param url string The URL to send the request to (example: "/my_thingy"). You cannot send a request to anywhere but localhost because Stormworks is silly like that
---@param port integer The port of the request
---@param reply_callback function|nil The function that will be called when a reply is received. An argument is passed through to this function, the response of the request
cuhFramework.http.get = function(url, port, reply_callback)
	local id = #cuhFramework.http.requests + 1
	cuhFramework.http.requests[id] = {
		port = port,
		url = url,
		callback = reply_callback,
		id = id
	}

	cuhFramework.references.httpGet(port, url)

	return {
		properties = cuhFramework.http.requests[id],

		---Cancel this request
		---@return nil
		cancel = function(self)
			cuhFramework.http.cancel(self.properties.id)
		end
	}
end

---Cancel a request by its ID
---@param id integer The ID of the request
---@return nil
cuhFramework.http.cancel = function(id)
	cuhFramework.http.requests[id] = nil
end

---Determines whether or not a request was successful, recommended to use in the reply callback when sending a get request
---@param response boolean The response of the request
---@return boolean ok Whether or not the request was successful
cuhFramework.http.ok = function(response)
	return response ~= "Connection closed unexpectedly" and response ~= "connect(): Connection refused" and response ~=  "recv(): Connection reset by peer" and response ~= "timeout"
end

---Adds arguments to a url. Example: "/get?my_argument=1", 
---@param url string The URL itself
---@param ... url_arg The arguments to plop into the URL (eg: {name = "yo", value="hey"}, {name="hey", value="yo"}). Do not use custom indexes
---@return string url The URL with the arguments added
cuhFramework.http.url_args = function(url, ...)
	-- convert args to stuffs tghfgdfd
	local args = {}
	local packed = {...}

	for i, v in pairs(packed) do
		if i == 1 then
			table.insert(args, "?"..cuhFramework.http.url_encode(v.name).."="..cuhFramework.http.url_encode(v.value))
		else
			table.insert(args, "&"..cuhFramework.http.url_encode(v.name).."="..cuhFramework.http.url_encode(v.value))
		end
	end

	-- anddd return
	return url..table.concat(args)
end

---Converts a string to a bool
---@param input string The string to convert to a bool
---@return boolean state True/false
cuhFramework.http.stringToBool = function(input)
	return input:lower() == "true"
end

---URL encode a string
---@param input string The string to encode
---@return string encoded_string The URL encoded string
cuhFramework.http.url_encode = function(input)
	input = tostring(input)
	input = string.gsub(input, "\n", "\r\n")
	input = string.gsub(input, "([^%w ])",
		function (c)
			return string.format("%%%02X", string.byte(c))
		end
	)

	input = string.gsub(input, " ", "+")

	return input
end

---URL decode a string
---@param input string The string to decode
---@return string decoded_string The decoded string
cuhFramework.http.url_decode = function(input)
    if type(input) == "string" then
        input = string.gsub(input, "+", " ")
        input = string.gsub(input, "%%(%x%x)",
            function (hex)
				return string.char(tonumber(hex, 16))
			end
		)

        input = string.gsub(input, "\r\n", "\n")
    end

    return input
end

---Manage requests
cuhFramework.callbacks.httpReply:connect(function(port, url, response)
	for i, v in pairs(cuhFramework.http.requests) do
		if v.port == port and v.url == url and v.callback then
			v.callback(response)
			cuhFramework.http.requests[i] = nil
		end
	end
end)

----------------------------------------
----------------------------------------
--//Framework - TPS\\--
----------------------------------------
----------------------------------------
---@type table<string, any>
cuhFramework.tps.tpsData = {
	averageTPS = 62.0,
	serverTPS = 62.0,

	ticks = 0,
	ticks_time = 0,
	backend_avgTpsTable = {}
}

-- Update TPS [Backend]
cuhFramework.backend.updates:insert(function()
	cuhFramework.tps.tpsData.ticks  = cuhFramework.tps.tpsData.ticks  + 1

    if server.getTimeMillisec() - cuhFramework.tps.tpsData.ticks_time >= 500 then
        cuhFramework.tps.tpsData.serverTPS = cuhFramework.tps.tpsData.ticks  * 2
        cuhFramework.tps.tpsData.ticks = 0
        cuhFramework.tps.tpsData.ticks_time = server.getTimeMillisec()
    end

	if #cuhFramework.tps.tpsData.backend_avgTpsTable <= 120 then
		cuhFramework.utilities.table.insert(cuhFramework.tps.tpsData.backend_avgTpsTable, cuhFramework.tps.tpsData.serverTPS)
	else
		cuhFramework.tps.tpsData.averageTPS = cuhFramework.utilities.table.sumOfTable(cuhFramework.tps.tpsData.backend_avgTpsTable) / #cuhFramework.tps.tpsData.backend_avgTpsTable
		cuhFramework.tps.tpsData.backend_avgTpsTable = {}
	end
end)

---Get TPS Data
cuhFramework.tps.getTPSData = function()
	return cuhFramework.tps.tpsData
end

----------------------------------------
----------------------------------------
--//Framework - Objects\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class object_properties
---@field object_id integer The object ID of this object
---@field position SWMatrix The position this object was spawned at
---@field object_type SWObjectTypeEnum The type of object

---@class object
---@field properties object_properties The properties of this creature
---@field despawn function<object> Despawn this object
---@field teleport function<object, SWMatrix> Teleport this object
---@field get_position function<object> Get the position of this object
---@field get_data function<object> Returns the raw data of this object provided by Stormworks
---@field explode function<object, number|nil> Explodes this object, while also despawning this object
---@field set_tooltip function<object, string> Sets the tooltip of this object

------------------------
------Objects
------------------------
---@type table<integer, object>
cuhFramework.objects.spawnedObjects = {}

---Spawn a object
---@param position SWMatrix The position to spawn this object at
---@param object_type SWObjectTypeEnum The type of object to spawn
---@return object object The object, or nil if failed to spawn
cuhFramework.objects.spawnObject = function(position, object_type)
	local object_id, success = server.spawnObject(position, object_type)

	if not success then
		return
	end

	cuhFramework.objects.spawnedObjects[object_id] = {
		properties = {
			object_id = object_id,
			spawn_position = position,
			object_type = object_type
		},

		despawn = function(self)
			return cuhFramework.objects.despawnObject(self.properties.object_id)
		end,

		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		get_position = function(self)
			local pos = server.getObjectPos(self.properties.object_id)
			return pos
		end,

		get_data = function(self)
			return server.getObjectData(self.properties.object_id)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		set_tooltip = function(self, tooltip)
			return server.setCharacterTooltip(self.properties.object_id, tooltip)
		end
	}

	return cuhFramework.objects.spawnedObjects[object_id]
end

---Get object by object ID
---@param object_id integer The object ID of the object
---@return object object The object, or nil if no object found
cuhFramework.objects.getObjectByObjectId = function(object_id)
	return cuhFramework.objects.spawnedObjects[object_id]
end

---Despawn an object
---@param object_id integer The object ID of the object you want to despawn
---@return boolean success Whether or not despawning this object was successful
cuhFramework.objects.despawnObject = function(object_id)
	cuhFramework.objects.spawnedObjects[object_id] = nil
	return server.despawnObject(object_id, true)
end

---Despawn all addon-recognised objects
cuhFramework.objects.despawnAllObjects = function()
	for i, v in pairs(cuhFramework.objects.spawnedObjects) do
		cuhFramework.objects.despawnObject(v.properties.object_id)
	end
end

----------------------------------------
----------------------------------------
--//Framework - Creatures\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class creature_properties
---@field object_id integer The object ID of this creature
---@field position SWMatrix The position this creature was spawned at
---@field creature_type SWCreatureTypeEnum The creature type of this creature
---@field size_multiplier number The size multiplier of this creature

---@class creature
---@field properties creature_properties The properties of this creature
---@field despawn function<creature> Despawn this creature
---@field teleport function<creature, SWMatrix> Teleport this creature
---@field kill function<creature> Kill this creature
---@field get_position function<creature> Get the position of this creature
---@field damage function<creature, number> Damage this creature, negative number = heal
---@field set_move_target function<creature, SWMatrix> Make the creature walk to this position
---@field get_data function<creature> Returns the raw data of this creature provided by Stormworks
---@field explode function<creature, number|nil> Explodes this creature, while also despawning this creature
---@field set_tooltip function<creature, string> Sets the tooltip of this creature
---@field set_character_data function<creature, number, boolean, boolean> Sets the data of this creature

------------------------
------Creatures
------------------------
---@type table<integer, creature>
cuhFramework.creatures.spawnedCreatures = {}

---Spawn a creature
---@param position SWMatrix The position to spawn this creature at
---@param creature_type SWCreatureTypeEnum The type of creature
---@param size_multiplier number The size multiplier of this creature
---@return creature creature The creature, or nil if failed to spawn
cuhFramework.creatures.spawnCreature = function(position, creature_type, size_multiplier)
	local object_id, success = server.spawnCreature(position, creature_type, size_multiplier)

	if not success then
		return
	end

	cuhFramework.creatures.spawnedCreatures[object_id] = {
		properties = {
			object_id = object_id,
			spawn_position = position,
			creature_type = creature_type,
			size_multiplier = size_multiplier
		},

		despawn = function(self)
			return cuhFramework.creatures.despawnCreature(self.properties.object_id)
		end,

		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		kill = function(self)
			server.killCharacter(self.properties.object_id)
		end,

		get_position = function(self)
			local pos = server.getObjectPos(self.properties.object_id)
			return pos
		end,

		damage = function(self, amount)
			local data = self:get_data()

			if not data then
				return false
			end

			server.setCharacterData(self.properties.object_id, data.hp - amount, data.interactible, data.ai)
			return true
		end,

		set_move_target = function(self, position)
			return server.setCreatureMoveTarget(self.properties.object_id, position)
		end,

		get_data = function(self)
			return server.getObjectData(self.properties.object_id)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		set_tooltip = function(self, tooltip)
			return server.setCreatureTooltip(self.properties.object_id, tooltip)
		end,

		set_creature_data = function(self, hp, interactable, ai)
			return server.setCharacterData(self.properties.object_id, hp, interactable, ai)
		end
	}

	return cuhFramework.creatures.spawnedCreatures[object_id]
end

---Get creature by object ID
---@param object_id integer The object ID of the creature
---@return creature creature The creature, or nil if no creature found
cuhFramework.creatures.getCreatureByObjectId = function(object_id)
	return cuhFramework.creatures.spawnedCreatures[object_id]
end

---Despawn a creature
---@param object_id integer The object ID of the creature you want to despawn
---@return boolean success Whether or not despawning this creature was successful
cuhFramework.creatures.despawnCreature = function(object_id)
	cuhFramework.creatures.spawnedCreatures[object_id] = nil
	return server.despawnObject(object_id, true)
end

----------------------------------------
----------------------------------------
--//Framework - Characters\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class character_properties
---@field object_id integer The object ID of this character
---@field position SWMatrix The position this character was spawned at
---@field outfit_id SWOutfitTypeEnum The character type of this character

---@class character
---@field properties character_properties The properties of this character
---@field despawn function<character> Despawn this character
---@field teleport function<character, SWMatrix> Teleport this character
---@field kill function<character> Kill this character
---@field get_position function<character> Get the position of this character
---@field damage function<character, number> Damage this character, negative number = heal
---@field get_data function<character> Returns the raw data of this character provided by Stormworks
---@field explode function<character, number|nil> Explodes this character, while also despawning this character
---@field set_tooltip function<character, string> Sets the tooltip of this character
---@field set_character_data function<character, number, boolean, boolean> Sets the data of this character

------------------------
------Characters
------------------------
---@type table<integer, character>
cuhFramework.characters.spawnedCharacters = {}

---Spawn a character
---@param position SWMatrix The position to spawn this character at
---@param outfit_id SWOutfitTypeEnum The character outfit the character should spawn with
---@return character character The character, or nil if failed to spawn
cuhFramework.characters.spawnCharacter = function(position, outfit_id)
	local object_id, success = server.spawnCharacter(position, outfit_id)

	if not success then
		return
	end

	cuhFramework.characters.spawnedCharacters[object_id] = {
		properties = {
			object_id = object_id,
			spawn_position = position,
			outfit_id = outfit_id
		},

		despawn = function(self)
			return cuhFramework.characters.despawnCharacter(self.properties.object_id)
		end,

		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		kill = function(self)
			server.killCharacter(self.properties.object_id)
		end,

		get_position = function(self)
			local pos = server.getObjectPos(self.properties.object_id)
			return pos
		end,

		damage = function(self, amount)
			local data = self:get_data()

			if not data then
				return false
			end

			server.setCharacterData(self.properties.object_id, data.hp - amount, data.interactible, data.ai)
			return true
		end,

		get_data = function(self)
			return server.getObjectData(self.properties.object_id)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		set_tooltip = function(self, tooltip)
			return server.setCharacterTooltip(self.properties.object_id, tooltip)
		end,

		set_character_data = function(self, hp, interactable, ai)
			return server.setCharacterData(self.properties.object_id, hp, interactable, ai)
		end
	}

	return cuhFramework.characters.spawnedCharacters[object_id]
end

---Get character by object ID
---@param object_id integer The object ID of the character
---@return character character The character, or nil if no character found
cuhFramework.characters.getCharacterByObjectId = function(object_id)
	return cuhFramework.characters.spawnedCharacters[object_id]
end

---Despawn a character
---@param object_id integer The object ID of the character you want to despawn
---@return boolean success Whether or not despawning this character was successful
cuhFramework.characters.despawnCharacter = function(object_id)
	cuhFramework.characters.spawnedCharacters[object_id] = nil
	return server.despawnObject(object_id, true)
end

----------------------------------------
----------------------------------------
--//Framework - UI\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class screenUiProperties
---@field x integer horizontal_offset, -1 = left, 1 = right
---@field y integer vertical_offset, -1 = bottom, 1 = top
---@field text string The text this UI object is showing
---@field player player|nil The player that this UI object is being shown to. Nil if everyone
---@field id integer The ID of this UI object
---@field visible boolean Whether or not this UI object is visible

---@class screenUiObject
---@field properties screenUiProperties The properties of this screen UI object
---@field remove function<screenUiObject> Remove this UI
---@field edit function<screenUiObject, string, number, number, player> Edit this UI (new_text, new_x, new_y, and player can be nil). If any of these parameters are nil, then the corresponding property will not be changed
---@field setVisibility function<screenUiObject, boolean> Whether or not this UI is visible
---@field refresh function<screenUiObject> Refresh this UI object

------------------------
------Screen UI
------------------------
cuhFramework.ui.screen = {}

---@type table<integer, screenUiObject>
cuhFramework.ui.screen.activeUI = {}

---Create a screen UI object for a player
---@param id integer The ID of the UI object
---@param text string The text that should be in the UI (can be updated)
---@param x number -1 = left, 1 = right
---@param y number -1 = bottom, 1 = top
---@param player player|nil The player to show this UI object to
---@return screenUiObject
cuhFramework.ui.screen.create = function(id, text, x, y, player)
	cuhFramework.ui.screen.activeUI[id] = {
		properties = {
			x = x,
			y = y,
			text = text,
			player = player,
			id = id,
			visible = true
		},

		remove = function(self)
			return cuhFramework.ui.screen.remove(self.properties.id)
		end,

		edit = function(self, new_text, new_x, new_y, new_player)
			self.properties.x = new_x or self.properties.x
			self.properties.y = new_y or self.properties.y
			self.properties.text = new_text or self.properties.text

			self.properties.player = new_player or self.properties.player

			if new_player and new_player == -1 then
				self.properties.player = nil
			end

			self:refresh()
		end,

		setVisibility = function(self, shouldShow)
			if self.properties.visible == shouldShow then
				return
			end

			self.properties.visible = shouldShow
			self:refresh()
		end,

		refresh = function(self)
			local v_peer_id = -1

			if self.properties.player then
				v_peer_id = self.properties.player.properties.peer_id
			end

			cuhFramework.references.createScreenPopup(v_peer_id, self.properties.id, "", self.properties.visible, self.properties.text, self.properties.x, self.properties.y)
		end
	}

	cuhFramework.ui.screen.activeUI[id]:refresh()
	return cuhFramework.ui.screen.activeUI[id]
end

---Remove a screen UI object
---@param id integer The ID of the UI object
cuhFramework.ui.screen.remove = function(id)
	cuhFramework.references.removePopup(-1, id)
	cuhFramework.ui.screen.activeUI[id] = nil
end

---Get a screen UI object
---@param id integer The ID of the UI object
---@return screenUiObject uiObject The retrieved UI object, or nil if none found
cuhFramework.ui.screen.get = function(id)
	local uiObject = cuhFramework.ui.screen.activeUI[id]
	return uiObject
end

------------------------
------Notifications UI
------------------------
cuhFramework.ui.notifications = {}

---Show a success notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
cuhFramework.ui.notifications.success = function(text, player)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, "Success", text, 4)
end

---Show a warning notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
cuhFramework.ui.notifications.warning = function(text, player)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, "Warning", text, 1)
end

---Show a failure notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
cuhFramework.ui.notifications.failure = function(text, player)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, "Failure", text, 3)
end

---Show a custom notification
---@param title string The title of the notification
---@param text string The text to display in the notification
---@param player player|nil The player to show the notification to. If this is nil, everyone sees it
---@param notification_type SWNotifiationTypeEnum|nil The notification type, aka the icon in the notification. If nil, it will become 4 (complete_mission, green success icon)
cuhFramework.ui.notifications.custom = function(title, text, player, notification_type)
	local target = -1

	if player then
		target = player.properties.peer_id
	end

	server.notify(target, title, text, notification_type or 4)
end

----------------------------------------
----------------------------------------
--//Framework - Custom Zones\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class player_customZone
---@field position SWMatrix The position of this zone
---@field size number The size of this zone
---@field callback function The callback that will be activated when a player enters/leaves the zone
---@field id integer The ID of this zone
---@field playersInZone table<integer, player> The players in this zone

---@class vehicle_customZone
---@field position SWMatrix The position of this zone
---@field size number The size of this zone
---@field callback function The callback that will be activated when a vehicle enters/leaves the zone
---@field id integer The ID of this zone
---@field vehiclesInZone table<integer, vehicle> The vehicles in this zone

------------------------
------Custom Zones (Player)
------------------------
---@type table<integer, player_customZone>
cuhFramework.customZones.activePlayerZones = {}

---Create a zone for players
---@param position SWMatrix The position the zone should be at
---@param size number The size of the zone in meters
---@param callback function The function that should be called when a player enters the zone. A player will be sent through the callback if a player enters/leaves the zone, along with a boolean. true = Player entered, false = Player left
cuhFramework.customZones.createPlayerZone = function(position, size, callback)
	if not callback then
		return false
	end

	local id = #cuhFramework.customZones.activePlayerZones + 1
	cuhFramework.customZones.activePlayerZones[id] = {
		position = position,
		size = size,
		callback = callback,
		id = id,
		playersInZone = {},

		backend_loop = cuhFramework.utilities.loop.create(0.02, function()
			local zone = cuhFramework.customZones.activePlayerZones[id]
			for i, player in pairs(cuhFramework.players.connectedPlayers) do
				local distance = cuhFramework.references.matrix.distance(player:get_position(), zone.position)

				if distance <= zone.size then
					if not zone.playersInZone[player.properties.peer_id] then
						zone.playersInZone[player.properties.peer_id] = player
						zone.callback(player, true)
					end
				else
					if zone.playersInZone[player.properties.peer_id] then
						zone.playersInZone[player.properties.peer_id] = nil
						zone.callback(player, false)
					end
				end
			end
		end),

		backend_checkIfPlayerLeft = cuhFramework.callbacks.onPlayerLeave:connect(function(_, _, peer_id)
			local data = cuhFramework.customZones.activePlayerZones[id]
			local player = cuhFramework.players.getPlayerByPeerId(peer_id)

			if data.playersInZone[peer_id] then
				data.playersInZone[peer_id] = nil
				data.callback(player, false)
			end
		end)
	}

	return {
		---@type player_customZone
		properties = cuhFramework.customZones.activePlayerZones[id],

		---Remove this zone
		remove = function(self)
			cuhFramework.customZones.removePlayerZone(self.properties.id)
		end,

		---Edit this zone
		---@param new_position SWMatrix|nil What the new position should be, set to nil if you don't want to change
		---@param new_size number|nil What the new size should be, set to nil if you don't want to change
		---@param new_callback function|nil What the new callback should be, set to nil if you don't want to change
		edit = function(self, new_position, new_size, new_callback)
			self.properties.position = new_position or self.properties.position
			self.properties.size = new_size or self.properties.size
			self.properties.callback = new_callback or self.properties.callback
		end
	}
end

---Whether or not a position is within a player zone
---@param position SWMatrix The position to check
---@return player_customZone|nil zone The player zone the position is in, or nil if no player zone was found
cuhFramework.customZones.isPositionInPlayerZone = function(position)
	for i, v in pairs(cuhFramework.customZones.activePlayerZones) do
		if cuhFramework.references.matrix.distance(position, v.position) <= v.size then
			return v
		end
	end
end

---Remove a player zone
---@param id integer The ID of the player zone
cuhFramework.customZones.removePlayerZone = function(id)
	local zone = cuhFramework.customZones.activePlayerZones[id]

	if zone then
		zone.backend_loop:remove()
		zone.backend_checkIfPlayerLeft:disconnect()
	end

	cuhFramework.customZones.activePlayerZones[id] = nil
end

------------------------
------Custom Zones (Vehicle)
------------------------
---@type table<integer, vehicle_customZone>
cuhFramework.customZones.activeVehicleZones = {}

---Create a zone for vehicles
---@param position SWMatrix The position the zone should be at
---@param size number The size of the zone in meters
---@param callback function The function that should be called when a vehicle enters the zone. A vehicle will be sent through the callback if a vehicle enters/leaves the zone, along with a boolean. true = Vehicle entered, false = Vehicle left
cuhFramework.customZones.createVehicleZone = function(position, size, callback)
	if not callback then
		return false
	end

	local id = #cuhFramework.customZones.activeVehicleZones + 1
	cuhFramework.customZones.activeVehicleZones[id] = {
		position = position,
		size = size,
		callback = callback,
		id = id,
		vehiclesInZone = {},

		backend_blacklist = {},

		backend_loop = cuhFramework.utilities.loop.create(0.02, function()
			local zone = cuhFramework.customZones.activeVehicleZones[id]
			for i, vehicle in pairs(cuhFramework.vehicles.spawnedVehicles) do
				local distance = cuhFramework.references.matrix.distance(vehicle:get_position(), zone.position)

				if not zone.backend_blacklist[vehicle.properties.vehicle_id] then
					if distance <= zone.size then
						if not zone.vehiclesInZone[vehicle.properties.vehicle_id] then
							zone.vehiclesInZone[vehicle.properties.vehicle_id] = vehicle
							zone.callback(vehicle, true)
						end
					else
						if zone.vehiclesInZone[vehicle.properties.vehicle_id] then
							zone.vehiclesInZone[vehicle.properties.vehicle_id] = nil
							zone.callback(vehicle, false)
						end
					end
				end
			end
		end),

		backend_checkIfVehicleDespawned = cuhFramework.callbacks.onVehicleDespawn:connect(function(vehicle_id)
			local data = cuhFramework.customZones.activeVehicleZones[id]
			local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

			if data.vehiclesInZone[vehicle_id] then
				data.vehiclesInZone[vehicle_id] = nil
				data.callback(vehicle, false)
				data.backend_blacklist[vehicle_id] = true
			end
		end)
	}

	return {
		---@type vehicle_customZone
		properties = cuhFramework.customZones.activeVehicleZones[id],

		---Remove this zone
		remove = function(self)
			cuhFramework.customZones.removeVehicleZone(self.properties.id)
		end,

		---Edit this zone
		---@param new_position SWMatrix|nil What the new position should be, set to nil if you don't want to change
		---@param new_size number|nil What the new size should be, set to nil if you don't want to change
		---@param new_callback function|nil What the new callback should be, set to nil if you don't want to change
		edit = function(self, new_position, new_size, new_callback)
			self.properties.position = new_position or self.properties.position
			self.properties.size = new_size or self.properties.size
			self.properties.callback = new_callback or self.properties.callback
		end
	}
end

---Whether or not a position is within a vehicle zone
---@param position SWMatrix The position to check
---@return vehicle_customZone|nil zone The vehicle zone the position is in, or nil if no vehicle zone was found
cuhFramework.customZones.isPositionInVehicleZone = function(position)
	for i, v in pairs(cuhFramework.customZones.activeVehicleZones) do
		if cuhFramework.references.matrix.distance(position, v.position) <= v.size then
			return v
		end
	end
end

---Remove a vehicle zone
---@param id integer The ID of the vehicle zone
cuhFramework.customZones.removeVehicleZone = function(id)
	local zone = cuhFramework.customZones.activeVehicleZones[id]

	if zone then
		zone.backend_loop:remove()
		zone.backend_checkIfVehicleDespawned:disconnect()
	end

	cuhFramework.customZones.activeVehicleZones[id] = nil
end

----------------------------------------
----------------------------------------
--//Framework - Disasters\\--
----------------------------------------
----------------------------------------

---Spawn a tsunami
---@param position SWMatrix The matrix position the tsunami should spawn at
---@param magnitude number The magnitude of the tsunami (0 - 1)
cuhFramework.disasters.spawnTsunami = function(position, magnitude)
	server.spawnTsunami(position, magnitude)
	return {
		---Cancel this tsunami
		cancel = function(self)
			server.cancelGerstner()
		end
	}
end

---Spawn a whirlpool
---@param position SWMatrix The matrix position the whirlpool should spawn at
---@param magnitude number The magnitude of the whirlpool (0 - 1)
cuhFramework.disasters.spawnWhirlpool = function(position, magnitude)
	server.spawnWhirlpool(position, magnitude)
	return {
		---Cancel this whirlpool
		cancel = function(self)
			server.cancelGerstner()
		end
	}
end

---Spawn a volcano
---@param position SWMatrix The matrix position the volcano should spawn at
---@param magnitude number The magnitude of the volcano (0 - 1)
---@return boolean success Whether or not the volcano spawned successfully
cuhFramework.disasters.spawnVolcano = function(position, magnitude)
	return server.spawnVolcano(position, magnitude)
end

---Get volcano data
---@return table<number, SWVolcano> volcano_data Table containing all volcanoes
cuhFramework.disasters.getVolcanoes = function(position, magnitude)
	return server.getVolcanos()
end

---Spawn a meteor
---@param position SWMatrix The matrix position the meteor should spawn at
---@param magnitude number The magnitude of the meteor (0 - 1)
---@return boolean success Whether or not the meteor spawned successfully
cuhFramework.disasters.spawnMeteor = function(position, magnitude)
	return server.spawnMeteor(position, magnitude, false)
end

---Spawn a meteor shower
---@param position SWMatrix The matrix position the meteor shower should spawn at
---@param magnitude number The magnitude of the meteor shower (0 - 1)
---@return boolean success Whether or not the meteor shower spawned successfully
cuhFramework.disasters.spawnMeteorShower = function(position, magnitude)
	return server.spawnMeteorShower(position, magnitude, false)
end

---Spawn a tornado
---@param position SWMatrix The matrix position the tornado should spawn at
---@param magnitude number The magnitude of the tornado (0 - 1)
---@return boolean success Whether or not the tornado spawned successfully
cuhFramework.disasters.spawnTornado = function(position, magnitude)
	return server.spawnTornado(position, magnitude)
end

----------------------------------------
----------------------------------------
--//Framework - Vehicles\\--
----------------------------------------
----------------------------------------

------------------------
------Intellisense
------------------------
---@class vehicleProperties
---@field vehicle_id integer The ID of this vehicle
---@field owner player The owner of this vehicle
---@field spawnPos SWMatrix The position this vehicle was spawned at
---@field cost number The cost of this vehicle
---@field addon_spawned boolean Whether or not an addon spawned this vehicle
---@field name string The name of this vehicle
---@field loaded boolean Whether or not this vehicle is loaded
---@field loaded_vehicle_data SWVehicleData The data of this vehicle that can only be retrieved when the vehicle is loaded. The table is empty if the vehicle hasn't loaded yet

---@class vehicle
---@field properties vehicleProperties The properties of this vehicle
---@field despawn function<vehicle> Despawn this vehicle
---@field teleport function<vehicle, SWMatrix> Teleport this vehicle
---@field explode function<vehicle, number> Explodes this vehicle and despawns it
---@field get_position function<vehicle, number?, number?, number?> Get the position of this vehicle. The voxel parameters are optional
---@field set_tooltip function<vehicle, string> Sets the tooltip of this vehicle
---@field set_invulnerability function<vehicle, boolean> Sets the invulnerability of this vehicle to whatever you specify (true = this vehicle can receive no damage, false = this vehicle can receive damage)
---@field repair function<vehicle> Repairs the vehicle. Clears all damage and refills inventories by completely respawning the vehicle at its current position
---@field set_keypad function<vehicle, string, number> Sets the value of a keypad on this vehicle to the specified value
---@field get_dial function<vehicle, string> Returns dial data of the specified dial on this vehicle
---@field press_button function<vehicle, string> Presses the specified button on this vehicle
---@field get_button function<vehicle, string> Returns button data of the specified button on this vehicle
---@field set_editable function<vehicle, boolean> Sets whether this vehicle is editable or not

------------------------
------Vehicles
------------------------
---@type table<integer, vehicle>
cuhFramework.vehicles.spawnedVehicles = {}

-- Update spawnedVehicles [Backend]
cuhFramework.backend.vehicle_spawn_giveVehicleData = function(vehicle_id, peer_id, x, y, z, cost)
	if cuhFramework.vehicles.spawnedVehicles[vehicle_id] then
		return
	end

	local data = {
		properties = {
			vehicle_id = vehicle_id,
			owner = cuhFramework.players.getPlayerByPeerId(peer_id),
			spawnPos = matrix.translation(x, y, z),
			cost = cost,
			addon_spawned = peer_id == -1,
			name = (server.getVehicleName(vehicle_id)),

			loaded = false,
			loaded_vehicle_data = {}
		},

		despawn = function(self)
			server.despawnVehicle(self.properties.vehicle_id, true)
			cuhFramework.utilities.delay.create(0.1, function()
				cuhFramework.vehicles.despawnVehicle(self.properties.vehicle_id)
			end)
		end,

		teleport = function(self, pos)
			return server.setVehiclePos(self.properties.vehicle_id, pos)
		end,

		explode = function(self, magnitude)
			cuhFramework.references.explode(self:get_position(), magnitude or 0.1)
			return self:despawn()
		end,

		get_position = function(self, voxel_x, voxel_y, voxel_z)
			local pos = server.getVehiclePos(self.properties.vehicle_id, voxel_x, voxel_y, voxel_z)
			return pos
		end,

		set_tooltip = function(self, text)
			return server.setVehicleTooltip(self.properties.vehicle_id, text)
		end,

		set_invulnerability = function(self, state)
			return server.setVehicleInvulnerable(self.properties.vehicle_id, state)
		end,

		repair = function(self)
			return server.resetVehicleState(self.properties.vehicle_id)
		end,

		set_keypad = function(self, keypad_name, value)
			return server.setVehicleKeypad(self.properties.vehicle_id, keypad_name, value)
		end,

		get_dial = function(self, dial_name)
			return server.getVehicleDial(self.properties.vehicle_id, dial_name)
		end,

		press_button = function(self, button_name)
			return server.pressVehicleButton(self.properties.vehicle_id, button_name)
		end,

		get_button = function(self, button_name)
			return server.getVehicleButton(self.properties.vehicle_id, button_name)
		end,

		set_editable = function(self, state)
			return server.setVehicleEditable(self.properties.vehicle_id, state)
		end
	}

	cuhFramework.vehicles.spawnedVehicles[vehicle_id] = data
end

cuhFramework.backend.vehicle_load_setVehicleData = function(vehicle_id)
	local vehicle_data = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

	if not vehicle_data then
		return
	end

	if vehicle_data.properties.loaded then
		return
	end

	vehicle_data.properties.loaded = true

	local data, success = server.getVehicleData(vehicle_id)

	if not success then
		return
	end

	vehicle_data.properties.loaded_vehicle_data = data
end

cuhFramework.callbacks.onVehicleSpawn:connect(function(vehicle_id, peer_id, x, y, z, cost)
	if cuhFramework.vehicles.spawnedVehicles[vehicle_id] then -- already has data
		return
	end

	cuhFramework.backend.vehicle_spawn_giveVehicleData(vehicle_id, peer_id, x, y, z, cost)

	local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

	for i, v in pairs(cuhFramework.customCallbacks.onVehicleSpawn.connections) do
		v(vehicle)
	end
end)

cuhFramework.callbacks.onVehicleLoad:connect(function(vehicle_id)
	cuhFramework.utilities.delay.create(1, function()
		local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

		if not vehicle then
			return
		end

		cuhFramework.backend.vehicle_load_setVehicleData(vehicle_id)

		for i, v in pairs(cuhFramework.customCallbacks.onVehicleLoad.connections) do
			v(vehicle)
		end
	end)
end)

cuhFramework.callbacks.onVehicleDespawn:connect(function(vehicle_id, peer_id)
	local vehicle = cuhFramework.vehicles.getVehicleByVehicleId(vehicle_id)

	if not vehicle then
		goto remove
	end

	for i, v in pairs(cuhFramework.customCallbacks.onVehicleDespawn.connections) do
		v(vehicle)
	end

	::remove::
	cuhFramework.vehicles.spawnedVehicles[vehicle_id] = nil
end)

---Spawn an addon vehicle
---@param playlist_id integer The ID of the addon vehicle, this can be found in the playlist.xml file or in the in-game editor
---@param position SWMatrix The position to spawn this vehicle at
---@return vehicle vehicle The vehicle, or nil if failed to spawn
cuhFramework.vehicles.spawnAddonVehicle = function(playlist_id, position)
	local vehicle_id, success = server.spawnAddonVehicle(position, (server.getAddonIndex()), playlist_id)

	if success then
		cuhFramework.backend.vehicle_spawn_giveVehicleData(vehicle_id, -1, position[13], position[14], position[15])
	end

	return cuhFramework.vehicles.spawnedVehicles[vehicle_id] or nil
end

---Get a vehicle by its vehicle ID
---@param vehicle_id integer Vehicle ID of the vehicle you want to retrieve
---@return vehicle vehicle The retrieved vehicle
cuhFramework.vehicles.getVehicleByVehicleId = function(vehicle_id)
	return cuhFramework.vehicles.spawnedVehicles[vehicle_id] or nil
end

---Get a list of vehicles owned by a player
---@param player player The player to check, use cuhFramework.players.getPlayerByPeerId() to get the player from a peer ID, see documentation
---@return table<integer, vehicle> vehicles Table of all vehicles owned by this player, or nil if no vehicles
cuhFramework.vehicles.getAllVehiclesOwnedByPlayer = function(player)
	local list = {}

	for i, v in pairs(cuhFramework.vehicles.spawnedVehicles) do
		if v.properties.owner == player then
			cuhFramework.utilities.table.insert(list, v)
		end
	end

	return list
end

---Get vehicle count
---@return integer vehicleCount Number of vehicles that are spawned and recognised by this addon
cuhFramework.vehicles.getVehicleCount = function()
	local count = 0

	for _ in pairs(cuhFramework.vehicles.spawnedVehicles) do -- i dont trust #tableName when the index is a number anymore
		count = count + 1
	end

	return count
end

---Despawn vehicle
---@param vehicle_id integer The vehicle ID of the vehicle you want to despawn
cuhFramework.vehicles.despawnVehicle = function(vehicle_id)
	server.despawnVehicle(vehicle_id, true)
end

----------------------------------------
----------------------------------------
--//Framework - References\\--
----------------------------------------
----------------------------------------

------------------------
------Vehicles
------------------------
cuhFramework.references.spawnAddonVehicle = server.spawnAddonVehicle
cuhFramework.references.despawnVehicle = server.despawnVehicle

------------------------
------UI
------------------------
cuhFramework.references.addMapLabel = server.addMapLabel
cuhFramework.references.removeMapLabel = server.removeMapLabel

cuhFramework.references.createPhysicalPopup = server.setPopup
cuhFramework.references.createScreenPopup = server.setPopupScreen
cuhFramework.references.removePopup = server.removePopup

cuhFramework.references.addMapLine = server.addMapLine
cuhFramework.references.removeMapLine = server.removeMapLine

cuhFramework.references.addMapObject = server.addMapObject
cuhFramework.references.addMapLabel = server.addMapLabel
cuhFramework.references.removeMapObject = server.removeMapObject
cuhFramework.references.removeMapLabel = server.removeMapLabel

cuhFramework.references.createUniqueUIID = server.getMapID
cuhFramework.references.removeAllUIWithId = server.removeMapID

------------------------
------Matrix
------------------------
cuhFramework.references.matrix = matrix

------------------------
------Miscellaneous
------------------------
cuhFramework.references.explode = server.spawnExplosion
cuhFramework.references.httpGet = server.httpGet

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Addon Code
------------------------------------------------------------------------
------------------------------------------------------------------------