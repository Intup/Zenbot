--https://docs.zenbot.gg/#/class?id=spellslotobj

local Menu = module.load('IntKatarina', 'menu'); 

local q = { 
    slot = player:spellSlot(0),
    last = 0,
    range = 625,
}

q.is_ready = function()
    return q.slot.state == 0
end 

q.is_execute = function(target)
    if target == nil and target.isDead then return end 
    player:castSpell("obj", 0, target)
end 

q.on_draw = function()
    if q.slot.level > 0 and q.is_ready() then
        graphics.draw_circle(player.pos, q.range, 1, graphics.argb(255, 255, 255, 200), 40)
    end
end

return q 