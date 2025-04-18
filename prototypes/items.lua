local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
  {
    type = "item",
    name = "matter_printer",
    icon = "__matter_printer__/graphics/icons/matter_printer_icon.png",
    subgroup = "production-machine",
    order = "hd[matter_printer]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    place_result = "matter_printer",
    stack_size = 5,
    default_import_location = "nauvis",
    weight = 200 * kg
  },
})
