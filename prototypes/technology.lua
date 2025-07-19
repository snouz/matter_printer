data:extend({
  {
    type = "technology",
    name = "matter_printer-technology",
    icon = "__matter_printer__/graphics/technology/matter_printer_tech.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "matter_printer",
      },
      {
        type = "unlock-recipe",
        recipe = "universe_precursor",
      },
    },
    prerequisites = { "uranium-processing" },
    unit = {
      count = 450,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "space-science-pack", 1 },
      },
      time = 60,
    },
  },
})