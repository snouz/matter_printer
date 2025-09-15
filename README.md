# Cosmic Incubator

![gif](https://i.imgur.com/vK0KM4V.gif)


The Cosmic Incubator creates a miniature universe that harvests unstable and unobtainable materials. Gameplay wise, it generates various ores, with a different set of results on each planet.

# Modders: change the results when used on your planet

Add this in data-final-fixes.lua and change values to your needs (to remove a resource, add it with 0 results and 0 probability):

if mods["matter_printer"] then
  matter_printer.add_result_to_planet("**YOUR_PLANET_NAME**", "**ITEM_NAME**", **Number_of_results(int)**, **Probability_of_results(0_to_1)**)
end

# Credits:
The Cosmic Incubator is majorly derived from graphics by Hurricane046, contains parts from Krastorio 1
Gifs:
https://giphy.com/gifs/loop-endless-trippy-xT9IgusfDcqpPFzjdS by @xponentialdesign
https://giphy.com/gifs/aesthetic-after-effects-365gifs-3JU6DXqgvGsC3m2lHd by @borrachas1
Universe Precursor based on icon from Periodic Madness

![references](https://i.imgur.com/uo2U5H2.png)


