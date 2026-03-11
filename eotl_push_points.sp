#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <regex>

#define PLUGIN_AUTHOR  "ack"
#define PLUGIN_VERSION "0.1"

public Plugin myinfo = {
	name = "eotl_push_points",
	author = PLUGIN_AUTHOR,
	description = "Adjust the rate of point players get for pushing the cart",
	version = PLUGIN_VERSION,
	url = ""
};

ConVar g_cvRate;
ConVar g_cvInterval;

public void OnPluginStart() {
	LogMessage("version %s starting", PLUGIN_VERSION);
	g_cvRate = CreateConVar("eotl_push_points_rate", "0.1", "points per second for pushing the cart", FCVAR_NONE);
    g_cvInterval = CreateConVar("eotl_push_points_interval", "10.0", "how often to check if we need to adjust the rate", FCVAR_NONE, true, 0.1);
}

public void OnMapStart() {
	CreateTimer(g_cvInterval.FloatValue, CheckRateTimer, 0, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
}

public Action CheckRateTimer(Handle timer, int junk) {
	float new_rate = g_cvRate.FloatValue;

	if(new_rate < 0.0) {
		return Plugin_Continue;
	}

	int entity = FindEntityByClassname(-1, "team_control_point_master");
	if(entity < 0) {
		return Plugin_Continue;
	}

	if(!HasEntProp(entity, Prop_Data, "m_flPartialCapturePointsRate")) {
		return Plugin_Continue;
	}

	float orig_rate = GetEntPropFloat(entity, Prop_Data, "m_flPartialCapturePointsRate");
	if(orig_rate != new_rate) {
		SetEntPropFloat(entity, Prop_Data, "m_flPartialCapturePointsRate", new_rate);
		LogMessage("Adjusted Cap Point Rate %.1f -> %.1f", orig_rate, new_rate);
	}
	return Plugin_Continue;
}