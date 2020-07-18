--https://docs.zenbot.gg/#/class?id=spellslotobj

local Menu = module.load('IntKatarina', 'menu'); 
local damage = module.internal("damage");

local r = { 
    slot = player:spellSlot(3),
    last = 0,
    range = 550,
};

r.is_ready = function()
    return r.slot.state == 0
end 

r.is_execute = function(target)
    if #r.CountEnemyChampionsInRange(player.pos, 550) < Menu.combo['Combo.R.Minimum']:get() then return end
    if(damage.spell(player, target, SpellSlot.Q) + damage.spell(player, target, SpellSlot.E) + damage.spell(player, target, SpellSlot.P)) <= target.health then
        player:castSpell("self", 3)
    end
end 

r.CountEnemyChampionsInRange = function(pos, range)
	local enemies_in_range = {}
	for enemy in objManager.iheroes do
		if enemy and enemy.isEnemy and pos:dist(enemy.pos) < range and not enemy.isDead then
			enemies_in_range[#enemies_in_range + 1] = enemy
		end
	end
	return enemies_in_range
end

r.on_draw = function()
    if r.slot.level > 0 and r.is_ready() then
        graphics.draw_circle(player.pos, r.range, 1, graphics.argb(255, 255, 255, 200), 40)
    end
end

return r