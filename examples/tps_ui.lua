------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example - TPS and UI:
-- Create a screen UI object
local ui = cuhFramework.ui.screen.create(1, "--TPS--\nLoading...", -0.9, 0)

-- Update it to show the TPS every second
cuhFramework.utilities.loop.create(1, function()
	-- Get TPS data
	local tpsData = cuhFramework.tps.getTPSData()
	local averageTps = cuhFramework.utilities.number.round(tpsData.averageTPS, 1) -- Average TPS
	local actualTps = cuhFramework.utilities.number.round(tpsData.serverTPS, 1) -- Server TPS

	-- Now that we have the average and actual TPS, let's go ahead and edit the popup to show the TPS
	ui:edit("--TPS--\nTPS: "..actualTps.."\nAVG: "..averageTps) -- As easy as that
end)