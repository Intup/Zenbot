--Docs:https://docs.zenbot.gg/#/lib
--Docs:https://docs.zenbot.gg/#/globals
--Docs:https://docs.zenbot.gg/#/mod
--Docs: https://docs.zenbot.gg/#/lib?id=objmanager

local Menu = module.load('IntKatarina', 'menu'); 
local q = module.load('IntKatarina', 'spells/q');
local w = module.load('IntKatarina', 'spells/w');
local e = module.load('IntKatarina', 'spells/e');
local r = module.load('IntKatarina', 'spells/r');
--Internal
local ts = module.internal('TS');
local orb = module.internal("orb");
local damage = module.internal("damage");

local core = { }

--KillSteal
core.AutoKill = function()
    for hero in objManager.iheroes do
        if hero and hero.valid and hero.isEnemy and not hero.isDead then 
            if q.is_ready() and hero.pos:dist(player) <= 625 then 
                if damage.spell(player, hero, SpellSlot.Q) >= hero.health then
                    if Menu.misc['Misc.KillSteal.UseQ']:get() then
                        q.is_execute(hero);
                        return
                    end
                end 
            end
            if e.is_ready() and hero.pos:dist(player) <= 725 then 
                if damage.spell(player, hero, SpellSlot.E) >= hero.health then
                    if Menu.misc['Misc.KillSteal.UseE']:get() then
                        e.is_execute(hero);
                        return
                    end
                end 
            end
            if (e.is_ready() and q.is_ready()) and hero.pos:dist(player) <= 725 then 
                if (damage.spell(player, hero, SpellSlot.Q + damage.spell(player, hero, SpellSlot.E))) >= hero.health then
                    if Menu.misc['Misc.KillSteal.UseE']:get() and Menu.misc['Misc.KillSteal.UseQ']:get() then
                        e.is_execute(hero);
                        q.is_execute(hero);
                    end
                end 
            end
        end
    end 
end
--Execute combo, Harass and Laneclear
core.on_tick = function()
    core.AutoKill();
    if (orb.core.is_mode_active(OrbwalkingMode.Combo)) then --Combo
        local target = ts.get_result(function(res, obj, dist)
            if dist <= 725 then
                res.obj = obj
                return true
            end
        end).obj

        --R Cancel 
        if r.CountEnemyChampionsInRange(player.pos, 550) == 0 then 
            if player.buff['katarinarsound'] then 
                player:move(mousePos)
            end
        end

        if target and target.valid and not target.isDead then 
            local menu_ComboStyle = Menu.combo['Combo.Style']:get()
            if menu_ComboStyle == 1 then --Auto
                if target.pos:dist(player) <= 625 then 
                    if q.is_ready() and Menu.combo.useq:get() then 
                        q.is_execute(target);
                        return
                    end
                    if e.is_ready() and target.pos:dist(player) <= 725 and Menu.combo.usee:get() then 
                        local Dag = e.GetBestDagger();
                        if Dag then
                            local DaggerPos = Dag.pos:extend(target.pos, 150)
                            if target.pos:dist(DaggerPos) <= 375 then 
                                e.CastE(DaggerPos)
                                return
                            end
                        else 
                            if player.pos:dist(target) >= 375 then 
                                e.CastE(target.pos)
                                return
                            end 
                        end
                    end 
                    if w.is_ready() and target.pos:dist(player) <= 375 and Menu.combo.usew:get() then  
                        w.is_execute(target);
                        return
                    end
                    if r.is_ready() and Menu.combo.user:get() then  
                        r.is_execute(target);
                        return
                    end
                elseif target.pos:dist(player) <= 725 then
                    if e.is_ready() and target.pos:dist(player) <= 725 and Menu.combo.usee:get() then 
                        local Dag = e.GetBestDagger();
                        if Dag then
                            local DaggerPos = Dag.pos:extend(target.pos, 150)
                            if target.pos:dist(DaggerPos) <= 375 then 
                                e.CastE(DaggerPos);
                                return
                            end
                        else 
                            if player.pos:dist(target) >= 375 then 
                                e.CastE(target.pos);
                                return
                            end 
                        end
                    end 
                    if q.is_ready() and Menu.combo.useq:get() then 
                        q.is_execute(target);
                        return
                    end
                    if w.is_ready() and target.pos:dist(player) <= 375 and Menu.combo.usew:get() then  
                        w.is_execute(target);
                        return
                    end
                    if r.is_ready() and Menu.combo.user:get() then  
                        r.is_execute(target);
                        return
                    end
                end 
            elseif menu_ComboStyle == 2 then  --EWQR
                if e.is_ready() and target.pos:dist(player) <= 725 and Menu.combo.usee:get() then 
                    local Dag = e.GetBestDagger();
                    if Dag then
                        local DaggerPos = Dag.pos:extend(target.pos, 150)
                        if target.pos:dist(DaggerPos) <= 375 then 
                            e.CastE(DaggerPos);
                            return
                        end
                    else 
                        if player.pos:dist(target) >= 375 then 
                            e.CastE(target.pos);
                            return
                        end 
                    end
                end 
                if w.is_ready() and target.pos:dist(player) <= 375 and Menu.combo.usew:get() then  
                    w.is_execute(target);
                    return
                end
                if q.is_ready() and Menu.combo.useq:get() then 
                    q.is_execute(target);
                    return
                end
                if r.is_ready() and Menu.combo.user:get() then  
                    r.is_execute(target);
                    return
                end
            elseif menu_ComboStyle == 3 then --EQWR
                if e.is_ready() and target.pos:dist(player) <= 725 and Menu.combo.usee:get() then 
                    local Dag = e.GetBestDagger();
                    if Dag then
                        local DaggerPos = Dag.pos:extend(target.pos, 150)
                        if target.pos:dist(DaggerPos) <= 375 then 
                            e.CastE(DaggerPos);
                            return
                        end
                    else 
                        if player.pos:dist(target) >= 375 then 
                            e.CastE(target.pos);
                            return
                        end 
                    end
                end
                if q.is_ready() and Menu.combo.useq:get() then 
                    q.is_execute(target);
                    return
                end 
                if w.is_ready() and target.pos:dist(player) <= 375 and Menu.combo.usew:get() then  
                    w.is_execute(target);
                    return
                end
                if r.is_ready() and Menu.combo.user:get() then  
                    r.is_execute(target);
                    return
                end
            elseif menu_ComboStyle == 4 then
                if q.is_ready() and Menu.combo.useq:get() then 
                    q.is_execute(target);
                    return
                end
                if e.is_ready() and target.pos:dist(player) <= 725 and Menu.combo.usee:get() then 
                    local Dag = e.GetBestDagger();
                    if Dag then
                        local DaggerPos = Dag.pos:extend(target.pos, 150)
                        if target.pos:dist(DaggerPos) <= 375 then 
                            e.CastE(DaggerPos);
                            return
                        end
                    else 
                        if player.pos:dist(target) >= 375 then 
                            e.CastE(target.pos);
                            return
                        end 
                    end
                end 
                if w.is_ready() and target.pos:dist(player) <= 375 and Menu.combo.usew:get() then  
                    w.is_execute(target);
                    return
                end
                if r.is_ready() and Menu.combo.user:get() then  
                    r.is_execute(target);
                    return
                end
            end
        end
    elseif (orb.core.is_mode_active(OrbwalkingMode.Harass)) then --Harass
        if Menu.harass['Harass.UseQ']:get() then 
            local target = ts.get_result(function(res, obj, dist)
                if dist <= 625 then
                    res.obj = obj
                    return true
                end
            end).obj

            if target and not target.isDead and target.valid then 
                if q.is_ready() then 
                    q.is_execute(target);
                    return
                end 
            end 
        end
    elseif (orb.core.is_mode_active(OrbwalkingMode.LaneClear)) then  --LaneClear
        for minion in objManager.iminions do
            if minion and minion.isEnemy and not minion.isDead then 
                if Menu.farm['use.lq']:get() and q.is_ready() then  
                    if minion.pos:dist(player) <= 625 or (damage.spell(player, minion, SpellSlot.Q) >= minion.health and minion.pos:dist(player) <= 625)  then
                        q.is_execute(minion);
                        return
                    end
                end
                if Menu.farm['use.lw']:get() and w.is_ready() then  
                    local count = 0;
                    if minion.pos:distSqr(player) <= 400*400 then
                        count = count + 1 
                    end
                    if count >= 3 then 
                        w.is_execute(target);
                        return
                    end
                end 
                if Menu.farm['use.le']:get() and e.is_ready() then  
                    local Dag = e.GetBestDagger();
                    if Dag then
                        if Dag.pos:dist(player) <= 725 then
                            if not e.IsUnderEnemyTurret(Dag.pos) and #r.CountEnemyChampionsInRange(Dag.pos, 725) <= 1 and ((player.health / player.maxHealth) * 100) >= 50 then 
                                local DaggerPos = Dag.pos:extend(minion.pos, 150);
                                local Best_pos = 0;
                                if DaggerPos:distSqr(minion.pos) < 375*375 then 
                                    Best_pos = Best_pos + 1
                                end
                                if Best_pos > 0 then
                                    player:castSpell('pos', 2, DaggerPos)
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif (orb.core.is_mode_active(OrbwalkingMode.LastHit)) then --LastHit
        for minion in objManager.iminions do
            if minion and minion.isEnemy and not minion.isDead then 
                if Menu.farm['use.lastq']:get() and q.is_ready() then  
                    if (damage.spell(player, minion, SpellSlot.Q) >= minion.health and minion.pos:dist(player) <= 625)  then
                        q.is_execute(minion);
                        return
                    end
                end
            end 
        end
    end
end 

return core 