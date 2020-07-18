-- Docs: https://docs.zenbot.gg/#/class?id=spellslotobj

local Menu = module.load('IntKatarina', 'menu'); 

local e = { 
    slot = player:spellSlot(2),
    last = 0,
    range = 725,

    Dagger = { }
};

e.is_ready = function()
    return e.slot.state == 0
end    

e.GetBestDagger = function()
    local closer = nil;
    for _, objs in pairs(e.Dagger) do
        if objs then
            closer = objs
        end 
    end
    return closer
end 

e.IsUnderEnemyTurret = function(pos)
    if not pos then return end 
    for turret in objManager.iturrets do
        if turret and turret.isEnemy and turret.isTurret and turret.valid then 
            if pos:dist(turret.pos) <= 915 then 
                return true 
            end 
        else 
            turret = nil 
        end  
    end
    return false
end 

e.CastE = function(position)
    if e.is_ready() then 
        if (((player.health / player.maxHealth) * 100) <= Menu.combo['Combo.E.Saver']:get() and not player:spellSlot(0).state ~= 0 and not player:spellSlot(1).state ~= 0) then 
            return
        end 
        if (e.IsUnderEnemyTurret(position) and Menu.combo['Combo.E.Turret']:get() and ((player.health / player.maxHealth) * 100) >= Menu.combo['Combo.R.Turret.MinHP']:get()) then
            player:castSpell("pos", 2, position)
        elseif not (e.IsUnderEnemyTurret(position)) then 
            player:castSpell("pos", 2, position)
        end
    end 
end

e.on_create_obj = function(obj)
    if obj then
        if obj.name:find("W_Indicator_Ally") then
            e.Dagger[obj.ptr] = obj
		end
    end
end

e.on_delete_obj = function(obj)
    if obj then
        e.Dagger[obj.ptr] = nil
    end
end

e.on_draw = function()
    if e.slot.level > 0 and e.is_ready() then
        graphics.draw_circle(player.pos, e.range, 1, graphics.argb(255, 255, 255, 200), 40)
    end
end

return e