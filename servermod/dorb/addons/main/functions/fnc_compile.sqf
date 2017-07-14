#include "script_component.hpp"
/**
 * Author: Dorbedo
 * compiles a function
 *
 * Arguments:
 * 0: filepath <STRING>
 * 1: functionname <STRING>
 * 2: header <scalar>
 *
 * Return Value:
 * Nothing
 *
 */
private _fnc_scriptName = 'Main compiling function';
scriptName _fnc_scriptName;
_this params [["_pathstring","",[""]],["_funcName","",[""]],["_headertype",0,[1]]];

private _headerstring = switch (_headertype) do { \
    case 2 : {
        format ['private _fnc_scriptNameParent = If (!isNil ''_fnc_scriptName'') then {_fnc_scriptName}else{''%1''};private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName;',_funcName];
    };
    case 3 : {
        format ['private _fnc_scriptNameParent = If (!isNil ''_fnc_scriptName'') then {_fnc_scriptName}else{''%1''};private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName; private _fnc_scriptMap = if !(isnil ''_fnc_scriptMap'') then {_fnc_scriptMap + [''%1'']} else {[''%1'']};',_funcName];
    };
    case 0 : {""};
    default {
        format [ARR_2('private _fnc_scriptName = ''%1'';scriptName _fnc_scriptName;',_funcName)];
    };
};
missionNamespace setVariable [_funcName,compile (_headerstring + preprocessFileLineNumbers _pathstring)];
