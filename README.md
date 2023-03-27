![cuhFramework Banner](assets/readme-banner.png)
**An open-source framework for Stormworks: Build and Rescue's Addon API to make your life easier.**

cuh4#7366  **|**  cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr

*##Information*
cuhFramework, a framework that should greatly improve the ease of addon development within the game Stormworks: Build and Rescue.

The framework comes with many utility functions, like chat functions, table functions, string functions (see below), and many more.
```lua
local converted = cuhFramework.utilities.string.split("the input string", " ") -- {"the" "input" "string"}
local converted2 = cuhFramework.utilities.string.split("the input string") -- {"the" "input" "string"}
```

Along with this, the framework comes with an awesome way of managing game callbacks.
Instead of:
```lua
function onVehicleSpawn(...)
    -- Your code
end
```
You can do:
```lua
local connection = cuhFramework.callbacks.onVehicleSpawn:connect(function()
    -- Your code
end)
```
You can even **disconnect** the function, making it obsolete, by doing:
```lua
connection:disconnect() -- The function will no longer get fired when a vehicle is spawned
```
(Inspired by Roblox)

*##Disclaimers*
It is highly recommended that you code your addon in a different .lua file (script.lua or another file).
It is also highly recommended that you use the popular Lua LSP extension on VSCode, and it is also highly recommended that you use NameousChangey's "Stormworks Lua with LifeboatAPI"
VSCode Extension.

Make sure to code your addon with something like VSCode. Do **not** use the in-game editor because, chances are, your code and the cuhFramework combined will not fit within the in-game addon character limit. The limit can be bypassed if you code outside of in-game (using something like VSCode as said), which is why you shouldn't code your addon in-game.