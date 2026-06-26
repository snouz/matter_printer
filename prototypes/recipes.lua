
data:extend({
  {
    type = "recipe-category",
    name = "cosmic_incubator"
  },
  {
    type = "item-subgroup",
    name = "matter_printer_recipes",
    group = "other",
    order = "z"
  },
  {
    type = "recipe",
    name = "matter_printer",
    energy_required = 10,
    categories = {"crafting"},
    ingredients =
    {
      {type = "item", name = "assembling-machine-3", amount = 3},
      {type = "item", name = "processing-unit", amount = 10},
      {type = "item", name = "productivity-module-2", amount = 10},
      {type = "item", name = "low-density-structure", amount = 5},
      {type = "item", name = "uranium-235", amount = 5},
    },
    results = {{type = "item", name = "matter_printer", amount = 1}},
    allow_productivity = false,
    enabled = false,
    auto_recycle = true,
  },


  {
    type = "recipe",
    name = "universe_precursor",
    energy_required = 2,
    categories = {"crafting"},
    ingredients =
    {
      {type = "item", name = "iron-ore", amount = 10},
      {type = "item", name = "copper-ore", amount = 10},
      {type = "item", name = "coal", amount = 10},
      {type = "item", name = "stone", amount = 10},
      {type = "item", name = "rocket-fuel", amount = 1},
    },
    results = {{type = "item", name = "universe_precursor", amount = 1}},
    allow_productivity = false,
    enabled = false,
    auto_recycle = true,
  },

})
