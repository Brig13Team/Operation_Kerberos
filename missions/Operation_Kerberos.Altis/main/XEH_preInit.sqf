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

FUNCMAIN(recompile) = FUNC(recompile);

[] call FUNC(hash_initialize);

#include "missionsettings.sqf"

If ((GVARMAIN(playerside) == west)&& ((getMissionConfigValue ["isKerberos", 0]) > 0) ) then {
    GVARMAIN(respawnmarker) = "respawn_west";
    GVARMAIN(side) = east;
    CIVILIAN setFriend [WEST, 1];

    WEST setFriend [CIVILIAN, 1];
    WEST setFriend [EAST, 0];
    WEST setFriend [INDEPENDENT, 0];

    EAST setFriend [CIVILIAN, 1];
    EAST setFriend [WEST, 0];
    EAST setFriend [INDEPENDENT, 1];

    INDEPENDENT setFriend [CIVILIAN, 1];
    INDEPENDENT setFriend [WEST, 0];
    INDEPENDENT setFriend [EAST, 1];
};
If ((GVARMAIN(playerside) == east)&& ((getMissionConfigValue ["isKerberos", 0]) > 0) ) then {
    GVARMAIN(respawnmarker) = "respawn_east";
    GVARMAIN(side) = west;
    CIVILIAN setFriend [EAST, 1];

    WEST setFriend [CIVILIAN, 1];
    WEST setFriend [EAST, 0];
    WEST setFriend [INDEPENDENT, 1];

    EAST setFriend [CIVILIAN, 1];
    EAST setFriend [WEST, 0];
    EAST setFriend [INDEPENDENT, 0];

    INDEPENDENT setFriend [CIVILIAN, 1];
    INDEPENDENT setFriend [WEST, 1];
    INDEPENDENT setFriend [EAST, 0];
};

[] call FUNC(getComponents);
