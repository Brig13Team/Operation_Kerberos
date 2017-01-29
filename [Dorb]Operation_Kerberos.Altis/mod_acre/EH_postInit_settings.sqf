/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Settings for ACRE2
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


// Difficulty settings

// Interference
["acre_sys_core_interference",true,true,"mission"] call CBA_Settings_fnc_set;
// Full duplex
["acre_sys_core_fullDuplex",true,true,"mission"] call CBA_Settings_fnc_init;
// Antena direction
["acre_sys_core_ignoreAntennaDirection",false,true,"mission"] call CBA_Settings_fnc_init;
// Terrain loss
["acre_sys_core_terrainLoss",0.5,true,"mission"] call CBA_Settings_fnc_init;
// Reveal to AI
["acre_sys_core_revealToAI",true,true,"mission"] call CBA_Settings_fnc_init;