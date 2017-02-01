/*
 *  Author: Dorbedo
 *
 *  Description:
 *      server postInit
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

// Interference
private _interference = ["acre_sys_core_interference",true,true,"server"] call CBA_Settings_fnc_set;
// Full duplex
private _fullDuplex = ["acre_sys_core_fullDuplex",true,true,"server"] call CBA_Settings_fnc_set;
// Antena direction
private _ignoreAntennaDirection = ["acre_sys_core_ignoreAntennaDirection",true,true,"server"] call CBA_Settings_fnc_set;
// Terrain loss
private _terrainLoss = ["acre_sys_core_terrainLoss",0.5,true,"server"] call CBA_Settings_fnc_set;
// Reveal to AI
private _revealToAI = ["acre_sys_core_revealToAI",true,true,"server"] call CBA_Settings_fnc_set;

LOG_5(_interference,_fullDuplex,_ignoreAntennaDirection,_terrainLoss,_revealToAI);
