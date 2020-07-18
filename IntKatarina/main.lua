-- Main.lua, what he does?
-- This small file is what will be executed. It will make your script work.

--Docs:https://docs.zenbot.gg/#/lib
--Docs:https://docs.zenbot.gg/#/globals
--Docs:https://docs.zenbot.gg/#/mod

--[[
    Remembering: You can program the script and organize it the way you want. You are free for that!
    I usually create the functions in different files. That's my way of organizing

    Exemple:
    spells/q.lua
    spells/w.lua
    spells/e.lua
    spells/r.lua

    core.lua
    main.lua
    menu.lua
]]

local Menu = module.load('IntKatarina', 'menu'); 
local core = module.load('IntKatarina', 'core');
local q = module.load('IntKatarina', 'spells/q');
local w = module.load('IntKatarina', 'spells/w');
local e = module.load('IntKatarina', 'spells/e');
local r = module.load('IntKatarina', 'spells/r');

local orb = module.internal("orb")
local evade = module.seek("evade");
local ts = module.internal('TS');

--Callbacks https://docs.zenbot.gg/#/lib?id=cb
--Add callbacks

--Bad ideia:
--[[
cb.add(cb.load, function() end)
cb.add(cb.load, OnLoad())
]]

--Good!
local function on_load_pre_tick()
    if player.buff['katarinarsound'] then return end
    core.on_tick();

    --Stop orbwalking
    if player.buff['katarinarsound'] then 
        if (evade) then
			evade.core.set_pause(math.huge)
		end
        orb.core.set_pause_move(math.huge)
        orb.core.set_pause_attack(math.huge)
    else
        if (evade) then
            evade.core.set_pause(0)
        end
        orb.core.set_pause_move(0)
        orb.core.set_pause_attack(0)
    end
end 

local function on_load_draw()
    --Docs: https://docs.zenbot.gg/#/class?id=avatarobj
    if player.isDead and not player.isOnScreen  then return end 
    if Menu.draw["draw.lq"]:get() then
        q.on_draw();
    end
    if Menu.draw["draw.lw"]:get() then
        w.on_draw();
    end
    if Menu.draw["draw.le"]:get() then
        e.on_draw();
    end
    if Menu.draw["draw.lr"]:get() then
        r.on_draw();
    end
end 

local function create_obj_dagger(obj)
    e.on_create_obj(obj);
end 

local function deleting_obj_dagger(obj)
    e.on_delete_obj(obj);
end 

local OnLoad = function()
    cb.add(cb.draw, on_load_draw)
    cb.add(cb.pre_tick, on_load_pre_tick)
    --Create dagger
    cb.add(cb.create_object, create_obj_dagger)
    cb.add(cb.delete_object, deleting_obj_dagger)
end 
cb.add(cb.load, OnLoad)


return { }