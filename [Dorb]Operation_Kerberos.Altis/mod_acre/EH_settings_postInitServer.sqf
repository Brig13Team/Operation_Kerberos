/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Settings for ACRE2
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


// Difficulty settings

// Interference
["acre_sys_core_interference",true,true,"mission"] call CBA_Settings_fnc_set;
// Full duplex
["acre_sys_core_fullDuplex",true,true,"mission"] call CBA_Settings_fnc_set;
// Antena direction
["acre_sys_core_ignoreAntennaDirection",true,true,"mission"] call CBA_Settings_fnc_set;
// Terrain loss
["acre_sys_core_terrainLoss",0.5,true,"mission"] call CBA_Settings_fnc_set;
// Reveal to AI
["acre_sys_core_revealToAI",true,true,"mission"] call CBA_Settings_fnc_set;
