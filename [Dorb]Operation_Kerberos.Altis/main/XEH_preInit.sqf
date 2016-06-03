#include "script_component.hpp"
ADDON = false;

TRIPLES(PREFIX,makro,iscasvehicle) = {
    scriptName QUOTE(TRIPLES(PREFIX,makro,iscasvehicle));
    _this params[["_class","",[""]],["_whitelist",[],[[]]],["_blacklist",[],[[]]]];
    If (!(isClass(configFile >> "CfgVehicles" >> _class))) exitWith {false};
    if (({_class isKindOf _x} count _whitelist) > 0) exitWith {false};
    if (({_class isKindOf _x} count _blacklist) > 0) exitWith {true};
    if ("CAS_Heli" in getArray(configFile >> "CfgVehicles" >> _class >> "availableForSupportTypes")) exitWith {true};
    if ("CAS_Bombing" in getArray(configFile >> "CfgVehicles" >> _class >> "availableForSupportTypes")) exitWith {true};
    false
};

PREP(debug_performance);
PREP(userconfig);
PREPS(debug,maplog);
PREPS(debug,putinlog);
PREPS(debug,show);
PREPS(debug,write);

ADDON = true;
