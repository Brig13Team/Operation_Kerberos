#include "script_component.hpp"
SCRIPT(XEH_PREINIT);
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
TRIPLES(PREFIX,makro,compileFile) = {
    scriptName QUOTE(TRIPLES(PREFIX,makro,compileFile));
    _this params [["_path","",[""]],["_funcName","",[""]],["_addheader",false,[false]]];
    private _headerstring = If (_addheader) then {
        format ["private _fnc_scriptNameParent = If (!isNil '_fnc_scriptName') then {_fnc_scriptName}else{'%1'};private _fnc_scriptName = '%1';scriptName _fnc_scriptName;",_funcName];
    }else{
        format ["private _fnc_scriptName = '%1';scriptName _fnc_scriptName;",_funcName];
    };
    missionNamespace setVariable [_funcName, compile (_headerstring + preprocessFileLineNumbers _path)];
    nil;
};
TRIPLES(PREFIX,makro,compileFileFinal) = {
    scriptName QUOTE(TRIPLES(PREFIX,makro,compileFileFinal));
    _this params [["_path","",[""]],["_funcName","",[""]],["_addheader",false,[false]]];
    private _headerstring = If (_addheader) then {
        format ["private _fnc_scriptNameParent = If (!isNil '_fnc_scriptName') then {_fnc_scriptName}else{'%1'};private _fnc_scriptName = '%1';scriptName _fnc_scriptName;",_funcName];
    }else{
        format ["private _fnc_scriptName = '%1';scriptName _fnc_scriptName;",_funcName];
    };
    If (isClass(configFile>>"cfgPatches">>"cba_cache_disable")) then {
        missionNamespace setVariable [_funcName, compileFinal (_headerstring + preprocessFileLineNumbers _path)];
    }else{
        private _cache = uiNamespace getVariable _funcName;
        if (isNil "_cache") then {
            uiNamespace setVariable [_funcName, compileFinal (_headerstring + preprocessFileLineNumbers _path)];
            missionNamespace setVariable [_funcName, uiNamespace getVariable _funcName];
        }else{
            missionNamespace setVariable [_funcName,_cache];
        };
    };
    nil;
};

PREP(debug_performance);
PREP(userconfig);
PREP(init);
PREPS(debug,putinlog);
PREPS(debug,show);
PREPS(debug,write);

ADDON = true;
