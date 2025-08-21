local base_results = {
  {type="item", name="iron-ore", amount_min = 0, amount_max = 75, probability = 0.3},
  {type="item", name="stone", amount_min = 0, amount_max = 15, probability = 0.3},
  {type="item", name="copper-ore", amount_min = 0, amount_max = 15, probability = 0.3},
  {type="item", name="carbon", amount_min = 0, amount_max = 42, probability = 0.2},
  {type="item", name="coal", amount_min = 0, amount_max = 9, probability = 0.2},
  {type="item", name="holmium-ore", amount_min = 0, amount_max = 11, probability = 0.2},
  {type="item", name="uranium-ore", amount_min = 0, amount_max = 10, probability = 0.11},
  {type="item", name="tungsten-ore", amount_min = 0, amount_max = 6, probability = 0.1},
  {type="item", name="sulfur", amount_min = 0, amount_max = 25, probability = 0.25},
  {type="item", name="calcite", amount_min = 0, amount_max = 6, probability = 0.07},
}



if mods["Moshine"] and data.raw.item["silicon"] and data.raw.item["neodymium"] then
  table.insert(base_results, {type="item", name="silicon", amount_min = 0, amount_max = 75, probability = 0.2})
  table.insert(base_results, {type="item", name="neodymium", amount_min = 0, amount_max = 15, probability = 0.15})
end


for _, planet in pairs(data.raw["planet"]) do
  if planet.name and planet.icon and planet.surface_properties then

    local surface_conditions = {}
    local results = util.table.deepcopy(base_results)

    if planet.surface_properties.pressure then
      table.insert(surface_conditions, {property = "pressure", min = planet.surface_properties.pressure, max = planet.surface_properties.pressure })
    end

    if planet.surface_properties["magnetic-field"] then
      table.insert(surface_conditions, {property = "magnetic-field", min = planet.surface_properties["magnetic-field"], max = planet.surface_properties["magnetic-field"] })
    end

    if planet.surface_properties.gravity then
      table.insert(surface_conditions, {property = "gravity", min = planet.surface_properties.gravity, max = planet.surface_properties.gravity })
    end

    if planet.name == "nauvis" then
      surface_conditions = {
        {property = "gravity", min = 10, max = 10 },
        {property = "magnetic-field", min = 90, max = 90 },
        {property = "pressure", min = 1000, max = 1000 }
      }
    end
    local orderstring = ""
    if planet.order then orderstring = planet.order end

    if surface_conditions ~= {} then
      data:extend({
        {
          type = "recipe",
          name = "cosmic_incubator_recipe_" .. planet.name,
          localised_name = {"", {"recipe-name.cosmic_incubator_recipe"}, " (", {"space-location-name." .. planet.name}, ")"},
          icons =
          {
            { icon = "__matter_printer__/graphics/icons/galaxy.png", icon_size = 64, scale = 0.5, shift = {0,0} },
            { icon = planet.icon, icon_size = 64, scale = 0.25, shift = {8,8}},
          },
          category = "cosmic_incubator",
          subgroup = "matter_printer_recipes",
          order = orderstring,
          enabled = true,
          energy_required = 30,
          ingredients = {{type = "item", name = "universe_precursor", amount = 1}},
          results = results,
          surface_conditions = surface_conditions,
          allow_productivity = false,
          allow_inserter_overload = true,
          overload_multiplier = 1000,
          auto_recycle = false,
          --hidden = true,
          hide_from_player_crafting = true,
          hidden_in_factoriopedia = false,
        },
      })
    end
  end
end

local function add_result_to_planet(planet, item, max, prob)
  if data.raw["planet"][planet] and data.raw.item[item] and data.raw.recipe["cosmic_incubator_recipe_" .. planet] then
    -- remove existing result from data.raw.recipe["cosmic_incubator_recipe_" .. planet].results
    for i, result in pairs(data.raw.recipe["cosmic_incubator_recipe_" .. planet].results) do
      if result.name == item then
        table.remove(data.raw.recipe["cosmic_incubator_recipe_" .. planet].results, i)
      end
    end
    if max > 0 and prob > 0 then
      table.insert(data.raw.recipe["cosmic_incubator_recipe_" .. planet].results, {type="item", name=item, amount_min = 0, amount_max = max, probability = prob})
    end
  end
end


add_result_to_planet("fulgora", "holmium-ore", 15, 0.3)

add_result_to_planet("gleba", "carbon", 186, 0.4)

add_result_to_planet("vulcanus", "tungsten-ore", 186, 0.4)

add_result_to_planet("aquilo", "lithium", 18, 0.4)
add_result_to_planet("aquilo", "ice", 86, 0.5)

add_result_to_planet("moshine", "neodymium", 90, 0.2)
add_result_to_planet("moshine", "silicon", 160, 0.07)

add_result_to_planet("panglia", "iron-ore", 210, 0.5)
add_result_to_planet("panglia", "copper-ore", 193, 0.3)
add_result_to_planet("panglia", "stone", 100, 0.25)
add_result_to_planet("panglia", "carbon", 920, 0.01)
add_result_to_planet("panglia", "uranium-ore", 0, 0)
add_result_to_planet("panglia", "uranium-238", 20, 0.12)


--log(serpent.block(data.raw.recipe.cosmic_incubator_recipe_nauvis))