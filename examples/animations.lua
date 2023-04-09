------------------------------------------------------------------------
    --cuhFramework || An addon creation framework to make SW addon development easier. 
	-- 		Created by cuh4#7366
	--		cuhHub - Stormworks Server Hub: https://discord.gg/zTQxaZjwDr
	--		This framework is open-source: https://github.com/Roozz1/cuhFramework
------------------------------------------------------------------------
--------- Example - Animations:
-- Let's get the host, and the host's position
local host = cuhFramework.players.getPlayerByPeerId(0)

-- Real quick, let's check if the host actually exists, which should always be the case
if host then
    -- Get the host's position
    local pos = host:get_position()

    -- Now, let's spawn a character
    local char = cuhFramework.characters.spawnCharacter(pos, 1)

    -- Now that we've spawned a character, let's make sure it was successful
    if char then
        -- Now, let's create a little animation, starting at the host's position offset by 10 on the Z axis, and ending at 0, 0, 0. The animation also loops since we have set it to loop ("true"), and the increment is 0.1.
        ---@param animation_data animation_data
        anim = cuhFramework.animation.createAnimation(cuhFramework.utilities.matrix.offsetPosition(pos, 0, 0, 10), matrix.translation(0, 0, 0), 0.1, true, function(animation_data)
            -- This callback gets called every tick, with the animation data being passed through
            -- Let's get the host's position, offset by 2 on the Z axis
            local new_pos = cuhFramework.utilities.matrix.offsetPosition((host:get_position()), 0, 0, 2)

            -- Now we edit the destination position of this animation to the position above
            anim:edit(nil, new_pos)
            -- anim:edit(new_start_pos, new_dest_pos, new_current_pos, new_increment) -- nil = don't change

            -- Finally, we teleport the character to the current position in the animation
            char:teleport(animation_data.current_pos)
        end)
    end
end