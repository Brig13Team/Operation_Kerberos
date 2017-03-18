#include "script_component.hpp"

INIT_COMPILE_SYSTEM;

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

FUNCMAIN(recompile) = FUNCSYS(recompile);
FUNCMAIN(recompileComponent) = FUNCSYS(recompilecomponent);

PREP(addMapToLog);
PREP(addToFeatureList);
PREP(addToLog);
PREP(debug_performance);
PREP(getComponents);

PREPS(hash,Acopy);
PREPS(hash,AcopyArray);
PREPS(hash,Adeserialize);
PREPS(hash,Amerge);
PREPS(hash,Collector);
PREPS(hash,Gcopy);
PREPS(hash,GcopyArray);
PREPS(hash,Gcreate);
PREPS(hash,Gdeserialize);
PREPS(hash,GetKeyfromValue);
PREPS(hash,Gmerge);
PREPS(hash,keys);
PREPS(hash,Lcopy);
PREPS(hash,LcopyArray);
PREPS(hash,Lcreate);
PREPS(hash,Ldeserialize);
PREPS(hash,Lmerge);
PREPS(hash,monitor);
PREPS(hash,serialize);

ADDON = true;

DORB_HASH_COLLECTOR_INIT

#include "missionsettings.sqf"

[] call FUNC(getComponents);
