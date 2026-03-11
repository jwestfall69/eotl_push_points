# eotl_push_points

This is a TF2 sourcemod plugin I wrote for the [EOTL](https://www.endofthelinegaming.com/) community.

This plugin is targeted towards payload maps and allows adjusting how many points per second a player gets while pushing the cart.  This setting is normally set by the map maker, which most seem to use a value of 0.1 points per second.

### ConVars
<hr>

**eotl_push_points_rate [float]**

Number of points per second a player gets when pushing the cart.  A value that is < 0 will disable the plugin from modify the value.

Default: 0.1

**eotl_push_points_interval [seconds]**

Map makers can adjust the entity property that sets the point per second whenever they want. So the plugin uses a timer to periodically check if it needs to adjust the setting.  This convar is used to determine how often the check is run

Default: 10