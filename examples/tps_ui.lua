------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example:
-- Create a loop that runs every one second
local ui = cuhFramework.ui.screen.create(1, "--TPS--\nLoading...", -0.9, 0)

cuhFramework.utilities.loop.create(1, function()
	-- Get TPS data
	local tpsData = cuhFramework.tps.getTPSData()
	local averageTps = cuhFramework.utilities.number.round(tpsData.averageTPS, 1) -- Average TPS
	local actualTps = cuhFramework.utilities.number.round(tpsData.serverTPS, 1) -- Server TPS

	-- Now that we have the average and actual TPS, let's go ahead and make a popup that shows the TPS
	ui:edit("--TPS--\nTPS: "..actualTps.."\nAVG: "..averageTps, nil, nil, nil) -- As easy as that
end)