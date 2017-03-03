/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


dorb_grouptestvalue = [1,6125000,[1,0.5,0.1]];

dorb_headquarter_playergroups_new = cba_missiontime - 10;
[[true]] call EFUNC(headquarter,handlePlayerGroups);

[objNull,player,objNull] spawn dorb_headquarter_fnc_killedUnit;
