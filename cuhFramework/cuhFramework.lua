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
	saveData = {},
	tps = {},
	customZones = {},
	ui = {},

	utilities = {},
	callbacks = {},
	references = {},

	chat = {},
	commands = {},

	backend = {
		updates = {
			---Insert update function. Don't use this
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
		}
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
		if cuhFramework.utilities.table.valueInTable(cuhFramework.backend.updates.exceptions, v) then
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
	return tonumber(string.format("%."..numDecimalPlaces.. "f", input)) or 0
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
	return matrix.translation(position[13] + (x or 0), position[14] +(y or 0), position[15] + (z or 0))
end

------------------------
------Miscellaneous
------------------------
cuhFramework.utilities.miscellaneous = {}

---Get the closest player to a position
---@param position SWMatrix The position to check
---@return player|nil
cuhFramework.utilities.miscellaneous.getClosestPlayerToPosition = function(position)
	local recentPlayer = nil
	local recentDistance = -1

	for i, v in pairs(cuhFramework.players.connectedPlayers) do
		local player_position = v:get_position()
		local distance = cuhFramework.references.matrix.distance(player_position, position)

		if distance < recentDistance or recentDistance == -1 then
			recentDistance = distance
			recentPlayer = v
		end
	end

	return recentPlayer
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

cuhFramework.backend.updates:insert(cuhFramework.utilities.delay.update) -- reference

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

cuhFramework.backend.updates:insert(cuhFramework.utilities.loop.update) -- reference

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

------------------------
------Intellisense
------------------------
---@class command
---@field id integer The ID of this command
---@field command_name string The name of this command
---@field shorthands string|table|nil The shorthands of this command
---@field caps_sensitive boolean|nil Whether or not this command is caps sensitive
---@field prefix string|nil The prefix of this command
---@field callback function The callback that is called upon the command being executed

------------------------
------Commands
------------------------
---@type table<integer, command>
cuhFramework.commands.registeredCommands = {}

---Create a command
---@param command_name string The name of the command, example: "my_command"
---@param shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c"
---@param caps_sensitive boolean|nil Whether or not the command is caps sensitive
---@param prefix string|nil The prefix of the command. For example: If the prefix is "addon", players will need to type "?addon (command_name)" in chat to activate the command. If nil, prefixes won't be used for this command
---@param callback function The function that will be called upon a player typing the command
cuhFramework.commands.create = function(command_name, shorthands, caps_sensitive, prefix, callback)
	if type(shorthands) == "string" then
		shorthands = {shorthands}
	end

	local id = #cuhFramework.commands.registeredCommands + 1
	cuhFramework.commands.registeredCommands[id] = {
		id = id,
		command_name = command_name,
		shorthands = shorthands or {},
		caps_sensitive = caps_sensitive,
		prefix = prefix,
		callback = callback
	}

	return {
		properties = cuhFramework.commands.registeredCommands[id],

		---Edit the properties of this command
		---@param new_command_name string|nil The name of the command, example: "my_command". If this is nil, the name of the command will not be changed
		---@param new_shorthands table|string|nil The shorthands of the command, basically additional command_names for the command, example: "m_c". If this is nil, the shorthands of the command will not be changed
		---@param new_caps_sensitive boolean|nil Whether or not the command should be caps sensitive. If this is nil, the command will remain caps sensitive or not caps sensitive depending on what it was set to beforehand
		---@param new_prefix string|nil The new prefix of the command. For example: If the prefix is "addon", players will need to type "?addon (command_name)" in chat to activate the command. If nil, prefixes won't be used for this command
		---@param new_callback function|nil The function that will be called upon a player typing the command. If this is nil, the command callback will not be changed
		---@return table command The command itself
		edit = function(self, new_command_name, new_shorthands, new_caps_sensitive, new_prefix, new_callback)
			self.properties.command_name = new_command_name or self.properties.command_name
			self.properties.shorthands = new_shorthands or self.properties.shorthands
			self.properties.caps_sensitive = new_caps_sensitive or self.properties.caps_sensitive
			self.properties.prefix = new_prefix or self.properties.prefix
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
---@return nil
cuhFramework.commands.remove = function(command_id)
	cuhFramework.commands.registeredCommands = nil
end

---Manage commands [Backend]
cuhFramework.callbacks.onCustomCommand:connect(function(msg, peer_id, is_admin, is_auth, command, ...)
	local args = {...}
	command = command:sub(2, #command) --"?hey" becomes "hey"

	for i, v in pairs(cuhFramework.commands.registeredCommands) do
		local lookFor = command

		-- check prefix (bit messy)
		if v.prefix then
			if v.caps_sensitive then
				if lookFor ~= v.prefix then
					goto continue
				else
					lookFor = args[1]
				end
			else
				if lookFor:lower() ~= v.prefix:lower() then
					goto continue
				else
					lookFor = args[1]
				end
			end
		end

		-- safety
		if not lookFor then -- args[1] doesn't exist
			return
		end

		-- caps sensitive
		if v.caps_sensitive then
			if v.command_name == lookFor or cuhFramework.utilities.table.valueInTable(v.shorthands, lookFor) then
				v.callback(msg, peer_id, is_admin, is_auth, lookFor, ...)
			end
		else
			-- not caps sensitive
			if v.command_name:lower() == lookFor:lower() or cuhFramework.utilities.table.valueInTable(cuhFramework.utilities.table.lowercaseStringValues(v.shorthands), lookFor:lower()) then
				v.callback(msg, peer_id, is_admin, is_auth, lookFor, ...)
			end
		end

	    ::continue::
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
---@return nil
cuhFramework.chat.send_message = function(author, message, player)
	local msg = ""

	if type(message) == "table" then
		msg = table.concat(cuhFramework.utilities.table.tostringValues(message), " ")
	elseif type(message) == "string" then
		msg = message
	end

	if player then
		server.announce(author, msg, player.properties.peer_id)
	else
		server.announce(author, msg)
	end
end

---Clears the chat by sending 11 blank messages
---@param player player|nil The player to clear chat for. If this is nil, chat will be cleared for everyone
---@return nil
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

---@class player
---@field properties playerProperties The properties of this player
---@field kick function<player, nil> Kick this player
---@field ban function<player, nil> Ban this player
---@field kill function<player, nil> Kills this player
---@field teleport function<player, SWMatrix> Teleport this player to a position
---@field fake_chat function<player, string, integer|nil> Send a fake message that seems like this player sent it
---@field get_position function<player, nil> Returns the position of this player as a matrix
---@field setAdmin function<player, boolean> Gives this player admin/Removes it
---@field setAuth function<player, boolean> Gives this player auth/Removes it
---@field giveItem function<player, SWSlotNumberEnum, SWEquipmentTypeEnum, integer, integer, float, boolean|nil> Gives this player an item
---@field removeItem function<player, SWSlotNumberEnum> Removes an item in the specified slot from this player

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
		end,

		kill = function(self)
			local char_id = server.getPlayerCharacterID(self.properties.peer_id)
			-- server.killCharacter(char_id) -- tends to call onPlayerDie twice
			server.setCharacterData(char_id, 0, false, false)
		end
	}

	cuhFramework.players.connectedPlayers[peer_id] = data
end

cuhFramework.callbacks.onPlayerJoin:connect(function(...)
	cuhFramework.backend.givePlayerData(...)
end)

for i, v in pairs(server.getPlayers()) do
	cuhFramework.backend.givePlayerData(v.steam_id, v.name, v.id, v.admin, v.auth)
end

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

---Get player count
---@return integer playerCount Number of players in the server
cuhFramework.players.getPlayerCount = function()
	local count = 0

	for _ in pairs(cuhFramework.players.connectedPlayers) do
		count = count + 1
	end

	return count
end

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
---@type table<integer, SWMatrix>
cuhFramework.objects.spawnedObjects = {}

---Spawn an object
---@param matrix SWMatrix The position to spawn the object at
---@param object_type SWObjectTypeEnum The object to spawn
cuhFramework.objects.spawnObject = function(matrix, object_type)
	local obj_id, success = server.spawnObject(matrix, object_type)

	if not success then
		return
	end

	cuhFramework.objects.spawnedObjects[obj_id] = matrix

	return {
		properties = {
			object_id = obj_id,
			success = success
		},

		---Despawn this object
		---@return boolean success Whether or not despawning this object was successful
		despawn = function(self)
			return cuhFramework.objects.despawnObject(self.properties.object_id)
		end,

		---Teleport this object
		---@param target_position SWMatrix The position to teleport this object to
		---@return boolean success Whether or not the teleportation was successful
		teleport = function(self, target_position)
			return server.setObjectPos(self.properties.object_id, target_position)
		end,

		---Get the position of this object
		---@return SWMatrix objectPosition The position of this object
		---@return boolean success Whether or not getting the position of this object was successful
		get_position = function(self)
			return server.getObjectPos(self.properties.object_id)
		end,
	}
end

---Despawn an object
---@param object_id integer The object ID of the object
---@return boolean success Whether or not despawning this object was successful
cuhFramework.objects.despawnObject = function(object_id)
	cuhFramework.objects.spawnedObjects[object_id] = nil
	return server.despawnObject(object_id, true)
end

---Despawn all addon-recognised objects
---@return nil
cuhFramework.objects.despawnAllObjects = function()
	for i, v in pairs(cuhFramework.objects.spawnedObjects) do
		cuhFramework.objects.despawnObject(i)
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
---@class creature_data
---@field object_id integer The object ID of this creature
---@field spawn_position SWMatrix The position this creature was spawned at
---@field size_multiplier number The size multiplier of this creature
---@field creature_type SWCreatureTypeEnum The creature type of this creature

------------------------
------Creatures
------------------------
---@type table<integer, creature_data>
cuhFramework.creatures.spawnedCreatures = {}

---Spawn a creature (requires Industrial Frontier DLC)
---@param position SWMatrix The position to spawn this creature at
---@param creature_type SWCreatureTypeEnum The creature to spawn
---@param size_multiplier number 1 = default size, lower = smaller, higher = larger
cuhFramework.creatures.spawnCreature = function(position, creature_type, size_multiplier)
	local object_id, success = server.spawnCreature(position, creature_type, size_multiplier)

	if not success then
		return false
	end

	local id = #cuhFramework.creatures.spawnedCreatures + 1
	cuhFramework.creatures.spawnedCreatures[id] = {
		object_id = object_id,
		spawn_position = position,
		size_multiplier = size_multiplier,
		creature_type = creature_type
	}

	return {
		properties = cuhFramework.creatures.spawnedCreatures[id],

		---Despawn this creature
		---@return boolean success Whether or not despawning this creature was successful
		despawn = function(self)
			return cuhFramework.creatures.despawnCreature(self.properties.object_id)
		end,

		---Teleport this creature
		---@param position SWMatrix The position to teleport this creature to
		---@return boolean success Whether or not despawning this creature was successful
		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		---Kill this creature
		---@return nil
		kill = function(self)
			server.killCharacter(self.properties.object_id)
		end,

		---Get the position of this creature
		---@return SWMatrix position The position of this creature
		---@return boolean success Whether or not retrieving the position of this creature was successful
		get_position = function(self)
			return server.getObjectPos(self.properties.object_id)
		end,

		---Set the move target of this creature
		---@param position SWMatrix The position for this creature to move to
		---@return boolean success Whether or not setting the move target of this creature was successful
		setMoveTarget = function(self, position)
			return server.setCreatureMoveTarget(self.properties.object_id, position)
		end,

		---Apply damage to this creature
		---@param amount number The about of damage to apply to this creature. A negative number will heal this creature.
		---@return boolean success Whether or not applying damage to this creature was successful
		damage = function(self, amount)
			local data = server.getCharacterData(self.properties.object_id)

			if not data then
				return false
			end

			server.setCharacterData(self.properties.object_id, data.hp - amount, data.interactible, data.ai)
			return true
		end
	}
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
---@class character_data
---@field object_id integer The object ID of this character
---@field position SWMatrix The position this character was spawned at
---@field outfit_id SWOutfitTypeEnum The character type of this character

------------------------
------Characters
------------------------
---@type table<integer, character_data>
cuhFramework.characters.spawnedCharacters = {}

---Spawn a character
---@param position SWMatrix The position to spawn this character at
---@param outfit_id SWOutfitTypeEnum The character outfit the character should spawn with
cuhFramework.characters.spawnCharacter = function(position, outfit_id)
	local object_id, success = server.spawnCharacter(position, outfit_id)

	if not success then
		return false
	end

	local id = #cuhFramework.characters.spawnedCharacters + 1
	cuhFramework.characters.spawnedCharacters[id] = {
		object_id = object_id,
		spawn_position = position,
		outfit_id = outfit_id
	}

	return {
		properties = cuhFramework.characters.spawnedCharacters[id],

		---Despawn this character
		---@return boolean success Whether or not despawning this character was successful
		despawn = function(self)
			return cuhFramework.characters.despawnCharacter(self.properties.object_id)
		end,

		---Teleport this character
		---@param position SWMatrix The position to teleport this character to
		---@return boolean success Whether or not despawning this character was successful
		teleport = function(self, position)
			return server.setObjectPos(self.properties.object_id, position)
		end,

		---Kill this character
		---@return nil
		kill = function(self)
			server.killCharacter(self.properties.object_id)
		end,

		---Get the position of this character
		---@return SWMatrix position The position of this character
		---@return boolean success Whether or not retrieving the position of this character was successful
		get_position = function(self)
			return server.getObjectPos(self.properties.object_id)
		end,

		---Set the move target of this character
		---@param position SWMatrix The position for this character to move to
		---@return boolean success Whether or not setting the move target of this character was successful
		setMoveTarget = function(self, position)
			return server.setCreatureMoveTarget(self.properties.object_id, position)
		end,

		---Apply damage to this character
		---@param amount number The about of damage to apply to this character. A negative number will heal this character.
		---@return boolean success Whether or not applying damage to this character was successful
		damage = function(self, amount)
			local data = server.getCharacterData(self.properties.object_id)

			if not data then
				return false
			end

			server.setCharacterData(self.properties.object_id, data.hp - amount, data.interactible, data.ai)
			return true
		end
	}
end

---Despawn a character
---@param object_id integer The object ID of the character you want to despawn
---@return boolean success Whether or not despawning this character was successful
cuhFramework.characters.despawnCreature = function(object_id)
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
---@class ui_data
---@field x integer horizontal_offset, -1 = left, 1 = right
---@field y integer vertical_offset, -1 = bottom, 1 = top
---@field text string The text this UI is showing
---@field player player|nil The player that the UI is being shown to. Nil if everyone
---@field id integer The ID of this UI

------------------------
------Screen UI
------------------------
cuhFramework.ui.screen = {}

---@type table<integer, ui_data>
cuhFramework.ui.screen.activeUI = {}

---Create a screen UI object for a player
---@param id integer The ID of the UI object
---@param text string The text that should be in the UI (can be updated)
---@param x number -1 = left, 1 = right
---@param y number -1 = bottom, 1 = top
---@param player player|nil The player to show this UI object to
cuhFramework.ui.screen.create = function(id, text, x, y, player)
	cuhFramework.ui.screen.activeUI[id] = {
		x = x,
		y = y,
		text = text,
		player = player,
		id = id,
	}

	local peer_id = -1

	if player then
		peer_id = player.properties.peer_id
	end

	cuhFramework.references.createScreenPopup(peer_id, id, "", true, text, x, y)

	return {
		---@type ui_data
		properties = cuhFramework.ui.screen.activeUI[id],

		---Remove this UI
		---@return nil
		remove = function(self)
			return cuhFramework.ui.screen.remove(self.properties.index)
		end,

		---Edit this UI
		---@param new_text SWMatrix|nil What the new text should be, set to nil if you don't want to change
		---@param new_x number|nil What the new X should be, set to nil if you don't want to change
		---@param new_y number|nil What the new Y should be, set to nil if you don't want to change
		---@param new_player player|nil The player to show this UI to. Set to nil if you don't want to change, or set to -1 if you want to show this UI object to all
		---@return nil
		edit = function(self, new_text, new_x, new_y, new_player)
			self.properties.x = new_x or self.properties.x
			self.properties.y = new_y or self.properties.y
			self.properties.text = new_text or self.properties.text

			self.properties.player = new_player or self.properties.player

			if new_player and new_player == -1 then
				self.properties.player = nil
			end
		end,

		---Set the visibility of this UI
		---@param shouldShow boolean If true, the UI will be shown. Opposite if false.
		---@return nil
		setVisibility = function(self, shouldShow)
			local v_peer_id = -1

			if self.properties.player then
				v_peer_id = self.properties.player.properties.peer_id
			end

			cuhFramework.references.createScreenPopup(v_peer_id, self.properties.id, "", shouldShow, self.properties.text, self.properties.x, self.properties.y)
		end
	}
end

---Remove a screen UI object
---@param id integer The ID of the UI object
---@return nil
cuhFramework.ui.screen.remove = function(id)
	local uiObject = cuhFramework.ui.screen.activeUI[id]

	if not uiObject then
		return
	end

	if uiObject.player then
		cuhFramework.references.removePopup(uiObject.player.properties.peer_id, id)
	else
		cuhFramework.references.removePopup(-1, id)
	end

	cuhFramework.ui.screen.activeUI[id] = nil
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
---@field vehiclesInZone table<integer, player> The vehicles in this zone

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
				local distance = matrix.distance(player:get_position(), zone.position)
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
		end)
	}

	return {
		---@type player_customZone
		properties = cuhFramework.customZones.activePlayerZones[id],

		---Remove this zone
		---@return nil
		remove = function(self)
			cuhFramework.customZones.removePlayerZone(self.properties.id)
		end,

		---Edit this zone
		---@param new_position SWMatrix|nil What the new position should be, set to nil if you don't want to change
		---@param new_size number|nil What the new size should be, set to nil if you don't want to change
		---@param new_callback function|nil What the new callback should be, set to nil if you don't want to change
		---@return nil
		edit = function(self, new_position, new_size, new_callback)
			self.properties.position = new_position or self.properties.position
			self.properties.size = new_size or self.properties.size
			self.properties.callback = new_callback or self.properties.callback
		end
	}
end

---Remove a zone
---@param id integer The ID of the zone
---@return nil
cuhFramework.customZones.removePlayerZone = function(id)
	local zone = cuhFramework.customZones.activePlayerZones[id]
	zone.backend_loop:remove()
	cuhFramework.customZones.activePlayerZones[id] = nil
end

----------------------------------------
----------------------------------------
--//Framework - References\\--
----------------------------------------
----------------------------------------

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

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Addon Code
------------------------------------------------------------------------
------------------------------------------------------------------------