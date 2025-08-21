require ("sound-util")
require ("circuit-connector-sprites")
require ("util")
require ("__space-age__.prototypes.entity.circuit-network")
--require ("__space-age__.prototypes.entity.space-platform-hub-cockpit")

local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local space_age_sounds = require ("__space-age__.prototypes.entity.sounds")
local meld = require("meld")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")
--local procession_graphic_catalogue_types = require("__base__/prototypes/planet/procession-graphic-catalogue-types")

--local biochamber_pictures = require("__space-age__.prototypes.entity.biochamber-pictures")


function matter_printer_pipes()
  return
  {
    north =
    {
      filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-N.png",
      priority = "extra-high",
      width = 71,
      height = 38,
      shift = util.by_pixel(2.25, 13.5),
      scale = 0.5
    },
    east =
    {
      filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-E.png",
      priority = "extra-high",
      width = 42,
      height = 76,
      shift = util.by_pixel(-24.5, 1),
      scale = 0.5
    },
    south =
    {
      filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-S.png",
      priority = "extra-high",
      width = 88,
      height = 61,
      shift = util.by_pixel(0, -31.25),
      scale = 0.5
    },
    west =
    {
      filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-W.png",
      priority = "extra-high",
      width = 39,
      height = 73,
      shift = util.by_pixel(25.75, 1.25),
      scale = 0.5
    }
  }
end



--[[
local thinkingbrain_on_animation_layers =
{
  {
    filename = "__factorioplus__/graphics/lab-large-on.png",
    width = 1440/6,
    height = 664/3,
    frame_count = 18,
    line_length = 6,
    animation_speed = 1/3,
    scale = 0.65,
    shift = util.by_pixel(0, 1.5),
  },
  {
    filename = "__factorioplus__/graphics/lab-large-shadow.png",
    width = 388,
    height = 295,
    frame_count = 1,
    repeat_count = 18,
    shift = util.by_pixel(16, 1.5),
    scale = 0.5,
    draw_as_shadow = true,
  },
  {
    filename = "__factorioplus__/graphics/lab-large-mask.png",
    blend_mode = "additive",
    width = 1440/6,
    height = 664/3,
    frame_count = 18,
    line_length = 6,
    animation_speed = 1/3,
    scale = 0.65,
    shift = util.by_pixel(0, 1.5),
    draw_as_light = true,
  },
}

local thinkingbrain_off_animation_layers =
{
  {
    filename = "__factorioplus__/graphics/lab-large-on.png",
    width = 1440/6,
    height = 664/3,
    frame_count = 1,
    line_length = 1,
    -- animation_speed = 1 / 3,
    scale = 0.65,
    shift = util.by_pixel(0, 1.5),
  },
  {
    filename = "__factorioplus__/graphics/lab-large-shadow.png",
    width = 388,
    height = 295,
    frame_count = 1,
    shift = util.by_pixel(16, 1.5),
    scale = 0.5,
    draw_as_shadow = true,
  }
}]]


local vert_shift = -6
local anim_speed = 1/3

data:extend({
  {
    type = "furnace",
    name = "matter_printer",
    icon = "__matter_printer__/graphics/icons/matter_printer_icon.png",
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "matter_printer"},
    crafting_categories = {"cosmic_incubator"},
    fast_replaceable_group = "matter_printer",
    max_health = 700,
    corpse = "matter_printer-remnants",
    dying_explosion = "biochamber-explosion",
    icon_draw_specification = {shift = {0, 1.2}},
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector
    (
      universal_connector_template,
      {
        { variation = 17, main_offset = util.by_pixel( -40, 21), shadow_offset = util.by_pixel( -32, 25), show_shadow = false },
        { variation = 17, main_offset = util.by_pixel( -40, 21), shadow_offset = util.by_pixel( -32, 25), show_shadow = false },
        { variation = 17, main_offset = util.by_pixel( -40, 21), shadow_offset = util.by_pixel( -32, 25), show_shadow = false },
        { variation = 17, main_offset = util.by_pixel( -40, 21), shadow_offset = util.by_pixel( -32, 25), show_shadow = false },
      }
    ),
    collision_box = {{-3.2, -3.2}, {3.2, 3.2}},
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box_vertical_extension = 0.4,
    module_slots = 1,
    allowed_effects = {"speed", "consumption", "pollution", "quality"},
    effect_receiver = { base_effect = { }},
    source_inventory_size = 1,
    result_inventory_size = 20,
    ignore_output_full = true,
    map_color = {74, 127, 156}, --4a7f9c
    graphics_set =
    {
      animation_progress = 0.30,
      --always_draw_idle_animation = false,
      states =
      {
        {
          name = "idle",
          duration = 1,
          next_active = "opening",
          next_inactive = "idle",
        },
        {
          name = "opening",
          duration = 16,
          next_active = "working",
          next_inactive = "closing",
        },
        {
          name = "working",
          duration = 60,
          next_active = "working",
          next_inactive = "closing",
        },
        {
          name = "closing",
          duration = 16,
          next_active = "opening",
          next_inactive = "idle",
        },
      },
      working_visualisations =
      {
        
        {
          name = "idle",
          always_draw = true,
          fadeout = false,
          draw_in_states = {"idle"},
          animation =
          {
            layers =
            {
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base.png",
                priority = "low",
                width = 512,
                height = 512,
                --repeat_count = 60,
                --frame_count = 64,
                line_length = 1,
                animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base-dome.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 1,
                line_length = 1,
                --repeat_count = 60,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-shadow.png",
                priority = "high",
                width = 700,
                height = 700,
                --repeat_count = 60,
                line_length = 1,
                --animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
                draw_as_shadow = true,
              },
            }
          },
        },
        {
          name = "opening",
          always_draw = true,
          fadeout = false,
          constant_speed = true,
          draw_in_states = {"opening"},
          animation =
          {
            layers =
            {
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base.png",
                priority = "low",
                width = 512,
                height = 512,
                repeat_count = 16,
                --frame_count = 64,
                line_length = 1,
                animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-opening.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 16,
                line_length = 8,
                --repeat_count = 15,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-opening2.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 16,
                line_length = 8,
                --repeat_count = 15,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                draw_as_glow = true,
                blend_mode = "additive",
                scale = 0.5,
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-shadow.png",
                priority = "high",
                width = 700,
                height = 700,
                repeat_count = 16,
                --line_length = 1,
                --animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
                draw_as_shadow = true,
              },
            }
          },
        },
        {
          name = "closing",
          always_draw = true,
          --fadeout = false,
          constant_speed = true,
          draw_in_states = {"closing"},
          animation =
          {
            layers =
            {
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base.png",
                priority = "low",
                width = 512,
                height = 512,
                repeat_count = 16,
                --frame_count = 64,
                line_length = 1,
                animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-closing.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 16,
                line_length = 8,
                --repeat_count = 15,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-closing2.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 16,
                line_length = 8,
                --repeat_count = 15,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                draw_as_glow = true,
                blend_mode = "additive",
                scale = 0.5,
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-shadow.png",
                priority = "high",
                width = 700,
                height = 700,
                repeat_count = 16,
                --line_length = 1,
                --animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
                draw_as_shadow = true,
              },
            }
          },
        },
        {
          name = "working",
          --fadeout = true,
          always_draw = true,
          constant_speed = true,
          draw_in_states = {"working"},
          animation = 
          { 
            layers = {
              --[[{
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base-anim.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 15,
                line_length = 8,
                repeat_count = 4,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
              },]]
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base-anim-black.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 15,
                line_length = 8,
                repeat_count = 4,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base.png",
                priority = "low",
                width = 512,
                height = 512,
                repeat_count = 60,
                --frame_count = 64,
                line_length = 1,
                animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-light-anim.png",
                priority="high",
                width = 512,
                height = 512,
                frame_count = 60,
                line_length = 8,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
                draw_as_glow = true,
                blend_mode = "additive",
              },
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-shadow.png",
                priority = "high",
                width = 700,
                height = 700,
                repeat_count = 60,
                line_length = 1,
                --animation_speed = anim_speed,
                --run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
                draw_as_shadow = true,
              },
            }
          },
        },
        {
          name = "universe",
          --fadeout = true,
          always_draw = true,
          --effect = "flicker",
          constant_speed = true,
          draw_in_states = {"working"},
          render_layer = "higher-object-above",
          animation = 
          { 
            layers = {
              {
                filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-base-anim2.png",
                priority="low",
                width = 512,
                height = 512,
                frame_count = 60,
                line_length = 8,
                --repeat_count = 4,
                animation_speed = anim_speed,
                run_mode = "forward",
                shift = util.by_pixel(0, vert_shift),
                scale = 0.5,
                blend_mode = "additive",
                draw_as_glow = true,
              },
            }
          },
        },
      },

      
      frozen_patch =
      {
        filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-frozen.png",
        width = 512,
        height = 512,
        shift = util.by_pixel(0, vert_shift),
        line_length = 1,
        scale = 0.5,
      },
      reset_animation_when_frozen = true,
    },






    impact_category = "metal-large",
    open_sound = {filename = "__matter_printer__/sound/zap-41.ogg", volume = 0.5},
    close_sound = {filename = "__matter_printer__/sound/zap-38.ogg", volume = 0.5},
    working_sound =
    {
      sound = {filename = "__matter_printer__/sound/machine_constant.ogg", volume = 0.9},
      max_sounds_per_prototype = 3,
      fade_in_ticks = 30,
      fade_out_ticks = 0,
      sound_accents = {
        {
          sound = {
          filename = "__matter_printer__/sound/turning_on.ogg", volume = 1.5},
          frame = 1,
          play_for_working_visualisation = "opening"
        },
        {
          sound = {filename = "__matter_printer__/sound/turning_off.ogg", volume = 1.5},
          frame = 1,
          play_for_working_visualisation = "closing"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.6)},
          frame = 1,
          play_for_working_visualisation = "working"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.5)},
          frame = 11,
          play_for_working_visualisation = "working"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.4)},
          frame = 18,
          play_for_working_visualisation = "working"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.3)},
          frame = 27,
          play_for_working_visualisation = "working"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.5)},
          frame = 34,
          play_for_working_visualisation = "working"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.5)},
          frame = 49,
          play_for_working_visualisation = "working"
        },
        {
          sound = {variations = sound_variations("__matter_printer__/sound/zap", 47, 0.2)},
          frame = 55,
          play_for_working_visualisation = "working"
        },
      },
    },
    crafting_speed = 1,
    --[[energy_source =
    {
      type = "burner",
      fuel_categories = {"nutrients"},
      effectivity = 1,
      burner_usage = "nutrients",
      fuel_inventory_size = 1,
      emissions_per_minute = { pollution = 2 },
    },]]
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 167 }
    },
    energy_usage = "50000kW",
    heating_energy = "1000kW",
    
    --[[fluid_boxes_off_when_no_fluid_recipe = true,
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = matter_printer_pipes(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections =
        {
          {
            flow_direction="input",
            direction = defines.direction.north,
            position = {0, -3}
          }
        }
      },
      {
        production_type = "output",
        pipe_picture = matter_printer_pipes(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections =
        {
          {
            flow_direction = "output",
            direction = defines.direction.south,
            position = {0, 3}
          }
        }
      },
    },]]
    water_reflection =
    {
      pictures =
      {
        filename = "__base__/graphics/entity/chemical-plant/chemical-plant-reflection.png",
        priority = "extra-high",
        width = 28,
        height = 36,
        shift = util.by_pixel(5, 60),
        variation_count = 4,
        scale = 5
      },
      rotate = false,
      orientation_to_variation = true
    },
    production_health_effect = nil
  },


  {
    type = "corpse",
    name = "matter_printer-remnants",
    icon = "__matter_printer__/graphics/icons/matter_printer_icon.png",
    hidden_in_factoriopedia = true,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    subgroup = "production-machine-remnants",
    order = "a-a-a",
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    tile_width = 4,
    tile_height = 4,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    --remove_on_tile_placement = false,
    animation =
    {
      filename = "__matter_printer__/graphics/entity/matter_printer/matter_printer-remnants.png",
      line_length = 1,
      width = 512,
      height = 512,
      direction_count = 1,
      shift = util.by_pixel(0, vert_shift),
      scale = 0.5
    }
  },
})
