
data:extend({
  {
    type = "recipe-category",
    name = "matter_printer"
  },
  {
    type = "recipe",
    name = "matter_printer",
    energy_required = 10,
    category = "crafting",
    ingredients =
    {
      {type = "item", name = "processing-unit", amount = 10},
      {type = "item", name = "productivity-module-2", amount = 10},
      {type = "item", name = "low-density-structure", amount = 5},
      {type = "item", name = "uranium-235", amount = 5},
    },
    results = {{type = "item", name = "matter_printer", amount = 1}},
    allow_productivity = false,
    enabled = false,
  },


  {
    type = "recipe-category",
    name = "cosmic_incubator"
  },

--[[

  {
    type = "recipe",
    name = "cosmic_incubator_aquilo",
    icon = "__matter_printer__/graphics/icons/matter_printer_icon.png",
    category = "cosmic_incubator",
    enabled = true,
    energy_required = 15,
    ingredients = {{type = "item", name = "iron-plate", amount = 5}},
    results = {{type="item", name="steel-plate", amount=1}},
    surface_conditions = { { property = "pressure", min = 300, max = 300 } },
    allow_productivity = false,
    allow_inserter_overload = true,
    overload_multiplier = 1000,
    auto_recycle = false,
  },
  {
    type = "recipe",
    name = "cosmic_incubator_gleba",
    icon = "__matter_printer__/graphics/icons/matter_printer_icon.png",
    category = "cosmic_incubator",
    enabled = true,
    energy_required = 15,
    ingredients = {{type = "item", name = "iron-plate", amount = 5}},
    results = {
      {type="item", name="iron-ore", amount_min = 0, amount_max = 75, probability = 0.1},
      {type="item", name="stone", amount_min = 0, amount_max = 15, probability = 0.1},
      {type="item", name="copper-ore", amount_min = 0, amount_max = 15, probability = 0.1},
      {type="item", name="carbon", amount_min = 0, amount_max = 42, probability = 0.1},
      {type="item", name="coal", amount_min = 0, amount_max = 9, probability = 0.1},
      {type="item", name="holmium-ore", amount_min = 0, amount_max = 2, probability = 0.1},
      {type="item", name="holmium-ore", amount_min = 0, amount_max = 2, probability = 0.1},
    },
    surface_conditions = { { property = "pressure", min = 2000, max = 2000 } },
    allow_productivity = false,
    allow_inserter_overload = true,
    overload_multiplier = 1000,
    auto_recycle = false,
  },
]]
-- nauvis surface_conditions = { property = "pressure", min = 1000, max = 1000 } },
-- space surface_conditions = { { property = "gravity", min = 0, max = 0 } },

-- gleba surface_conditions = { { property = "pressure", min = 2000, max = 2000 } },
-- vulcanus surface_conditions = { { property = "pressure", min = 4000, max = 4000 } },
-- fulgora surface_conditions = { { property = "magnetic-field", min = 99, max = 99 } },
-- aquilo surface_conditions = { { property = "pressure", min = 300, max = 300 } },

})
