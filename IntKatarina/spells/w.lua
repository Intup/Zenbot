--https://docs.zenbot.gg/#/class?id=spellslotobj

local Menu = module.load('IntKatarina', 'menu'); 

local w = { 
    slot = player:spellSlot(1),
    last = 0,
    range = 375,
}

w.is_ready = function()
    return w.slot.state == 0
end 

w.is_execute = function(target)
    if target == nil and target.isDead then return end 
    player:castSpell("self", 1)
end

w.on_draw = function()
    if w.slot.level > 0 and w.is_ready() then
        graphics.draw_circle(player.pos, w.range, 1, graphics.argb(255, 255, 255, 200), 40)
    end
end

return w 