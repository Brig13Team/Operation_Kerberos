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


PREP(HashCollector);
PREP(HashCopy);
PREP(HashCopyArray);
PREP(HashCreate);
PREP(HashKeys);
PREP(HashMonitor);
PREP(serialize);
PREP(deserialize);



PREPS(debug,maplog);
PREPS(debug,putinlog);
PREPS(debug,show);
PREPS(debug,write);

ADDON = true;

DORB_HASH_POOL = [];
DORB_HASH_TO_DELETE = [];
DORB_HASH_CREATED_NEW = [];
DORB_HASH_CREATED = [];
DORB_HASH_COLLECTOR_NEXTEXEC = (diag_tickTime + DORB_HASH_COLLECTOR_NEXTEXEC_DELAY);
//DORB_HASH_COLLECTOR_HANDLER = scriptNull;
DORB_HASH_COLLECTOR_ID = 0;
DORB_HASH_COLLECTOR_NAMESPACES = [];
DORB_HASH_COLLECTOR_VARIABLES = [];
DORB_HASH_COLLECTOR_ARRAYS = [];
DORB_HASH_COLLECTOR_FOUND = [];


for "_i" from 1 to 5000 do {
    DORB_HASH_SYS_CREATE(_newHash);
};

[FUNC(HashMonitor),(1/3),[]] call CBA_fnc_addPerFrameHandler;

[
    {
        // don't execute if to less hashes were created or the last execution is long ago
        If !((count DORB_HASH_CREATED_NEW > 100)||{DORB_HASH_COLLECTOR_NEXTEXEC < diag_tickTime}) exitWith {};
        /*
        If !(isNull DORB_HASH_COLLECTOR_HANDLER) exitWith {
            // I don't like to do this in the unsheduled environment
            DORB_HASH_COLLECTOR_HANDLER = [] spawn FUNC(HashCollector);
        };
        */
        [] call FUNC(HashCollector);
    },
    (1/4),
    []
] call CBA_fnc_addPerFrameHandler;
