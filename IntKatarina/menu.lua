--[[Welcome to the menu. 
In this file we will declare the options that users who have used their script and can configure.]]

--Docs: https://docs.zenbot.gg/#/lib?id=menu
--Docs: https://docs.zenbot.gg/#/class?id=menudel

local menu = menu('IntKatarina', 'Int Katarina'); -- ID and NAME MENU
menu:header("a1", "Core"); --I usually add Header to the menu. This indicates, say, the area where the user will configure

--Combo
menu:menu("combo", "Combo"); --menu <- a constant declared in line 6
--           ^ ID    ^ Menu display
menu.combo:header("a2", "Combo Settings");
--    ^ ID combo (Line 10);
menu.combo:dropdown("Combo.Style", "Select combo style", 3, { "Auto", "EWQR", "EQWR", "QEWR" });
menu.combo:boolean("useq", "Use Q in combo", true);
menu.combo:boolean("usew", "Use W in combo", true);
menu.combo:boolean("usee", "Use E in combo", true);
--R
menu.combo:boolean("user", "Use R in combo", true);
menu.combo:header("a3", "R - Settings");
menu.combo:slider("Combo.R.Minimum", "Minimum enemies to use R", 1, 1, 5, 1);

menu.combo:header("a4", "Another settings");
menu.combo:slider("Combo.E.Saver", "Don't go in if my health <= {0}% and QW is not ready.", 15, 1, 100, 1);
menu.combo:boolean("Combo.E.Turret", "Allow E jump under enemy turret", false);
menu.combo:slider("Combo.R.Turret.MinHP", "My health must be >= {0}% to allow enter under enemy tower.", 35, 1, 100, 1);
--Harass
menu:menu("harass", "Harass"); --menu <- a constant declared in line 6
menu.harass:header("a5", "Harass Settings");
--     ^ ID harass (Line 28);
menu.harass:boolean("Harass.UseQ", "Enable Q in harass mode.", true);
menu.harass:header("a6", "Harass Settings");
--AutoHarass
menu.harass:header("a7", "Auto-harass settings");
menu.harass:boolean("Harass.Auto.UseQ", "Enable auto harass with Q.", true);
menu.harass:slider("Harass.Auto.Chance", "Auto harass chance.", 1, 1, 5, 1);
--Faming
menu:menu("farm", "Clear"); --menu <- a constant declared in line 6
menu.farm:header("a8", "Lane Settings");
--     ^ ID farm (Line 40);
menu.farm:boolean("use.lq", "Use Q in lane", true);
menu.farm:boolean("use.lw", "Use W in lane", true);
menu.farm:boolean("use.le", "Use E in lane", true);
menu.farm:header("a9", "LastHit Settings");
menu.farm:boolean("use.lastq", "Use Q in last hit", true);
--Misc
menu:menu("misc", "Misc"); --menu <- a constant declared in line 6
menu.misc:header("a10", "Misc Settings");
--     ^ ID misc (Line 48);
menu.misc:boolean("Misc.KillSteal.UseQ", "Enable Kill Steal with Q.", true);
menu.misc:boolean("Misc.KillSteal.UseE", "Enable Kill Steal with E.", true);
menu.misc:slider("Misc.KillSteal.MinHP", "Your HP must be >= {0}% to use E / Q+E.", 35, 1, 100, 1);
--Flee
-- maybe you can add in the future!

--Drawing
menu:menu("draw", "Drawing"); --menu <- a constant declared in line 6
menu.draw:header("a11", "Drawing Settings");
menu.draw:boolean("draw.lq", "Draw Q range.", true);
menu.draw:boolean("draw.lw", "Draw W range.", true);
menu.draw:boolean("draw.le", "Draw E range.", true);
menu.draw:boolean("draw.lr", "Draw R range.", true);

return menu 