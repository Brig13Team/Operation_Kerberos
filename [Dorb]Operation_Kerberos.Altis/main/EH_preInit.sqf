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

DORB_HASH_POOL = [];
DORB_HASH_TO_DELETE = [];
DORB_HASH_CREATED_NEW = [];
DORB_HASH_CREATED_NEW_GLOBAL = [];
DORB_HASH_CREATED = [];
DORB_HASH_COLLECTOR_COLLECT = false;
DORB_HASH_COLLECTOR_ID = 0;
DORB_HASH_COLLECTOR_NAMESPACES = [];
DORB_HASH_COLLECTOR_NAMESPACES_ID = 0;
DORB_HASH_COLLECTOR_VARIABLES = [];
DORB_HASH_COLLECTOR_ARRAYS = [];
DORB_HASH_COLLECTOR_FOUND = [];
DORB_HASH_COLLECTOR_IGNORE = [QUOTE(DORB_HASH_POOL),QUOTE(DORB_HASH_TO_DELETE),QUOTE(DORB_HASH_CREATED_NEW),QUOTE(DORB_HASH_CREATED_NEW_GLOBAL),QUOTE(DORB_HASH_CREATED),QUOTE(DORB_HASH_COLLECTOR_HANDLER),QUOTE(DORB_HASH_COLLECTOR_NEXTEXEC),QUOTE(DORB_HASH_COLLECTOR_NAMESPACES),QUOTE(DORB_HASH_COLLECTOR_VARIABLES),QUOTE(DORB_HASH_COLLECTOR_ARRAYS),QUOTE(DORB_HASH_COLLECTOR_FOUND),QUOTE(DORB_HASH_COLLECTOR_ID),QUOTE(DORB_HASH_COLLECTOR_IGNORE)] apply {toLower _x};
for "_i" from 1 to ([150,500] select isServer) do {
    DORB_HASH_POOL pushBack (DORB_HASH_SYS_CREATE_LOCAL);
};
[FUNC(hash_monitor),(1/3),[]] call CBA_fnc_addPerFrameHandler;
[{If (DORB_HASH_COLLECTOR_COLLECT) then {[] call FUNC(hash_collector);};},(1/4),[]] call CBA_fnc_addPerFrameHandler;

#include "missionsettings.sqf"

[] call FUNC(getComponents);
