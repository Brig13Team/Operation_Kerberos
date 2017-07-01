#include "script_component.hpp"

ISNIL(logging,[]);

FUNCMAIN(compile) = {
    private _fnc_scriptName = 'Compiling SyS';
    scriptName _fnc_scriptName;
    _this params ["_namespace","_pathstring","_funcName","_headertype"];
    private _headerstring = switch (_headertype) do {
        case 2 : {format ['private _fnc_scriptNameParent = If (!isNil ''_fnc_scriptName'') then {_fnc_scriptName}else{''%1''};private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName;',_funcName];};
        case 3 : {format ['private _fnc_scriptNameParent = If (!isNil ''_fnc_scriptName'') then {_fnc_scriptName}else{''%1''};private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName; private _fnc_scriptMap = if !(isnil ''_fnc_scriptMap'') then {_fnc_scriptMap + [''%1'']} else {[''%1'']};',_funcName];};
        case 0 : {""};
        default {format ['private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName;',_funcName];};
    };
    _namespace setVariable [_funcName,compile (_headerstring + preprocessFileLineNumbers _pathstring)];
};


ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

[] call FUNC(hash_initialize);

#include "missionsettings.sqf"

[] call FUNC(getComponents);
