local r = {
    range = 500, -- u can change this value!
};
--On_drawing callback!
local function on_drawing()
    if (player and player.isDead and not player.isTargetable and  player.buff[17]) then return end -- check if player is valid!
    if (player.isOnScreen) then --check if camera is on its champion
        --Draw Satanic
        local pos = {}

        for i = 0, 4 do
            local theta = i * 2 * math.pi / 5 + os.clock() -- As long as the value is true the Satanist Triangle will rotate
            pos[i] = vec3(player.x + r.range * math.sin(theta), player.y, player.z + r.range * math.cos(theta))
        end

        for i = 0, 4 do
            graphics.draw_line(pos[i], pos[i > 2 and i - 3 or i + 2], 3, 0xFFFF0000)
        end
            graphics.draw_circle(player.pos, r.range, 3, 0xFFFF0000, 128)
        end
    end 
end 

--load callbacks!!
local Loading = function()
    --Add callbacks!
    cb.add(cb.draw, on_drawing)
end
cb.add(cb.load, Loading)