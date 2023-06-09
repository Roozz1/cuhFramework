------------------------------------------------------------------------
    -- cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example - Vehicles:
-- Connect a function to the custom onVehicleSpawn callback
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleSpawn:connect(function(vehicle)
    -- Send a message in chat that contains some of the vehicle data
    cuhFramework.chat.send_message("MyAddon", {
        "A vehicle was spawned!",
        "\nOwner: ", vehicle.properties.owner.properties.name,
        "\nVehicle ID: ", vehicle.properties.vehicle_id,
        "\nLoaded: ", tostring(vehicle.properties.loaded)
    })

    -- Set the tooltip of the vehicle
    vehicle:set_tooltip("My cool vehicle!")

    -- Set this vehicle to be invulnerable to damage
    vehicle:set_invulnerability(true)
end)

-- Connect a function to the custom onVehicleLoad callback
---@param vehicle vehicle
cuhFramework.customCallbacks.onVehicleLoad:connect(function(vehicle)
    -- Send a message in chat that contains some new vehicle data
    if vehicle.properties.loaded then -- Check if the vehicle is loaded (just in-case)
        cuhFramework.chat.send_message("MyAddon", {
            "A vehicle was loaded!",
            "\nOwner: ", vehicle.properties.owner.properties.name,
            "\nVoxel Count: ", vehicle.properties.loaded_vehicle_data.voxels,
            "\nLoaded: ", tostring(vehicle.properties.loaded)
        })
    end

    -- Explode the vehicle after 3 seconds
    cuhFramework.utilities.delay.create(3, function()
        vehicle:explode()
    end)
end)