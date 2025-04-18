
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
})
