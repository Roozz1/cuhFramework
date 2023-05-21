![cuhFramework Banner](assets/readme-banner.png)
**An open-source framework for Stormworks: Build and Rescue's Addon API to make your life easier.**

cuh4#7366  **|**  cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr

## *Information*

cuhFramework, a clean organised framework that should greatly improve the ease of addon development within the game Stormworks: Build and Rescue.

Compatible with intellisense.


The framework comes with many utility functions for table management, string management, game chat, and more.
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
local connection = cuhFramework.callbacks.onVehicleSpawn:connect(function(...)
    -- Your code
end)
```
You can even **disconnect** the function from the callback, making it obsolete, by doing:
```lua
connection:disconnect() -- The function will no longer get called whenever a vehicle is spawned
```

## *Download*
To download this framework, head over to the [releases](https://github.com/Roozz1/cuhFramework/releases).
Keep in mind, this framework is still a **work-in-progress**, while there are a lot of features so far, there are a lot more to come.

To add cuhFramework into your code, simply add **cuhFramework.lua** and **cuhFramework - Build Project.exe** into the **same** folder as your addon. Then when you would like to combine your addon with the framework code, run the .exe.

> ⚠ **Your addon code is backed up during the building process, your raw addon code will not be lost unless you do something horribly wrong.**

## *Documentation*
[Click here](https://github.com/Roozz1/cuhFramework/wiki) for the documentation.

## *Examples*

Want to see some examples that show you how to use this? If so, [click here](https://github.com/Roozz1/cuhFramework/tree/main/examples).

## *Disclaimers*

It is **highly recommended** that you code your addon in a **different** .lua file to **cuhFramework.lua** (preferably a file that **isnt script.lua nor cuhFramework.lua**).


It is also **highly recommended** that you use the popular Lua LSP extension by sumneko on VSCode, and it is also **recommended** that you use NameousChangey's Stormworks Lua with LifeboatAPI
VSCode Extension.


**Make sure** to code your addon with something like VSCode. Do **not** use the in-game editor because, chances are, your code and the cuhFramework combined will not fit within the in-game addon character limit. The limit can be bypassed if you code outside of in-game (using something like VSCode as said), which is why you shouldn't code your addon in-game.

## *Features*
1. Neat player system
2. Loop system (call a function every x seconds)
3. Delay system (call a function after x seconds)
4. Custom commands system (add a command easily, remove a command, edit a command)
5. Utility features (loop, delay, string functions, table functions, number functions, etc)
6. Lua-LSP VSCode extension by sumneko compatible
7. Build feature, combines your addon code with cuhFramework, allowing you to code your addon without a lot of lines being taken by cuhFramework
8. Works with intellisense (use Lua-LSP VSCode extension by sumneko for this)
9. Completely organised
10. Easy to integrate into your code