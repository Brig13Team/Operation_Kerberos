/*
 *  Author: Dorbedo
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

EGVAR(headquarter,costs) = HASH_CREATE;
EGVAR(headquarter,strength) = HASH_CREATE;
EGVAR(headquarter,defence) = HASH_CREATE;


private _allVehicles = configProperties [
    configFile >> "CfgVehicles",
    "(isClass _x)&&{(getnumber(_x >> 'scope')>1)&&(((configName _x) isKindOf 'Air')||((configName _x) isKindOf 'LandVehicle')||((configName _x) isKindOf 'CAManBase'))}",
    true
];
_allVehicles = _allVehicles apply {configName _x};
{
"ace_clipboard" callExtension format [
"%1;%2;%3;%4;%5;%6
",
getText(configFile>>"CfgVehicles">>_x>>"displayName"),
_x,
[_x] call dorb_headquarter_fnc_getCost,
[_x] call dorb_headquarter_fnc_getStrengthAI,
[_x] call dorb_headquarter_fnc_getDefence,
[_x] call dorb_headquarter_fnc_getType
];
}forEach _allVehicles;
"ace_clipboard" callExtension "    ";
"ace_clipboard" callExtension "--COMPLETE--";
