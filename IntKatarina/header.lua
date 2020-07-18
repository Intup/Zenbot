return {
    id = "IntKatarina",
    name = "Int Katarina",
  --[[  encrypt = { 
      'menu', 'core', 'spells/q', 'spells/w', 'spells/e', 'spells/r'
    },]]
    load = function()
      return player.charName == "Katarina"
    end,
  }