#include "script_component.hpp"
/**
 * Author: iJesuz
 * checks if a vehicle is cas-whitelisted
 *
 * Arguments:
 * 0: classname <STRING>
 * 1: Blacklist <ARRAY>
 * 2: Whitelist <ARRAY>
 *
 * Return Value:
 * is whitelisted <BOOL>
 *
 */

 _this params[["_class","",[""]],["_whitelist",[],[[]]],["_blacklist",[],[[]]]];
If (!(isClass(configFile >> "CfgVehicles" >> _class))) exitWith {false};
if (({_class isKindOf _x} count _whitelist) > 0) exitWith {false};
if (({_class isKindOf _x} count _blacklist) > 0) exitWith {true};
if ("CAS_Heli" in ([_class,"availableForSupportTypes",[]] call EFUNC(common,getCfgVehicles))) exitWith {true};
if ("CAS_Bombing" in ([_class,"availableForSupportTypes",[]] call EFUNC(common,getCfgVehicles))) exitWith {true};
if !((configProperties [configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) isEqualTo []) exitWith {true};
false
