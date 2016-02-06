#include "script_component.hpp"
ADDON = false;

TRIPLES(PREFIX,makro,selectrandom) = {
    scriptName QUOTE(TRIPLES(PREFIX,makro,selectrandom));
    If(count _this < 1) exitwith {[]};
    (_this) select floor random count (_this);
    };
TRIPLES(PREFIX,makro,delete) = {
    scriptName QUOTE(TRIPLES(PREFIX,makro,delete));
    _this params [["_delete",false,[[],objNull,"",grpNull]]];
    If(_this isEqualType [])exitWith{{_x call TRIPLES(PREFIX,makro,delete);}forEach _this;};
    If(_this isEqualType grpNull)exitWith{deletegroup _this;};
    If(_this isEqualType objNull)exitWith{{_this deleteVehicleCrew _x} forEach crew _this; deleteVehicle _this;};
    If(_this isEqualType "STRING")exitWith{deleteMarker _this};
    diag_log text format['TILGE: Nicht unterstuetzt | %1',_this];
    nil;
    };
TRIPLES(PREFIX,makro,map) = {
    scriptName QUOTE(TRIPLES(PREFIX,makro,map));
    _this params[["_code","",[{},""]],["_array",[],[[]]]];
    if (_code isEqualType "STRING") then { _code = compile _code; };
    { _array set [_forEachIndex, (_array select _forEachIndex) call _code]; } forEach _array;
    _array
};
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
PREP(init);
PREPS(debug,maplog);
PREPS(debug,putinlog);
PREPS(debug,show);
PREPS(debug,write);

ADDON = true;
