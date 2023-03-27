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