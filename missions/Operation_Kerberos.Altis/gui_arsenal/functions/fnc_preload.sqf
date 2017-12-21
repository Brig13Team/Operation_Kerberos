/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preloads the ArsenalList
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_targetName", "", [""]]];

If (_targetName isEqualTo "") then {
    If (GVAR(level)<2) then {
        _targetName = QGVAR(obj_level_1);
    } else {
        _targetName = format[QGVAR(obj_level_%1_%2), GVAR(level), side ace_player];
    };
};

private _side = side ace_player;

private _targetObject = [] call FUNC(createLocalArsenal);
[
    missionNamespace getVariable [_targetName, objNull]
] call EFUNC(common,delete);

missionNamespace setVariable [_targetName, _targetObject];

If (GVAR(level)<1) exitWith {
    GVAR(isPreloaded) = true;
};

If (GVAR(level)<2) exitWith {
    private _arsenalList = [];
    private _neededVersion = format[
        "%1_ArsenalVersion_%2_%3_%4",
        missionName,
        getText(missionConfigFile >> QUOTE(DOUBLES(CfgComponent,ADDON)) >> "version"),
        productVersion select 2,
        GVAR(level)
    ];
    (profileNamespace getVariable [format[QGVAR(arsenalList_%1),str _side],["NotFound",[]]]) params [["_currentVersion","NotFound",[]],["_list",[],[[]]]];
    TRACEV_2(_currentVersion,_neededVersion);
    If (((!(_list isEqualTo []))&&{_currentVersion isEqualTo _neededVersion})&&{!GVAR(forceReload)}) then {
        _arsenalList = _list;
    } else {
        _arsenalList = [] call FUNC(getRestrictedArsenal);
        profileNamespace setVariable [format[QGVAR(arsenalList_%1), str _side], [_neededVersion ,_arsenalList]];
        saveProfileNamespace;
    };

    [_targetObject, _arsenalList, false] call ace_arsenal_fnc_initBox;
    GVAR(isPreloaded) = true;
};

If (GVAR(level)<3) then {
    private _arsenalList = [];
    private _neededVersion = format[
        "%1_ArsenalVersion_%2_%3_%4",
        missionName,
        getText(missionConfigFile >> QUOTE(DOUBLES(CfgComponent,ADDON)) >> "version"),
        productVersion select 2,
        GVAR(level)
    ];
    (profileNamespace getVariable [format[QGVAR(arsenalList_%1),str _side],["NotFound",[]]]) params [["_currentVersion","NotFound",[]],["_list",[],[[]]]];
    TRACEV_2(_currentVersion,_neededVersion);
    If (((!(_list isEqualTo []))&&{_currentVersion isEqualTo _neededVersion})&&{!GVAR(forceReload)}) then {
        _arsenalList = _list;
    } else {
        _arsenalList = [side ace_player, false] call FUNC(getSideRestrictedArsenal);
        profileNamespace setVariable [format[QGVAR(arsenalList_%1), str _side], [_neededVersion ,_arsenalList]];
        saveProfileNamespace;
    };
    [_targetObject, _arsenalList, false] call ace_arsenal_fnc_initBox;
    GVAR(isPreloaded) = true;
} else {
    private _arsenalList = [];
    private _neededVersion = format[
        "%1_ArsenalVersion_%2_%3_%4",
        missionName,
        getText(missionConfigFile >> QUOTE(DOUBLES(CfgComponent,ADDON)) >> "version"),
        productVersion select 2,
        GVAR(level)
    ];
    (profileNamespace getVariable [format[QGVAR(arsenalList_%1),str _side],["NotFound",[]]]) params [["_currentVersion","NotFound",[]],["_list",[],[[]]]];
    TRACEV_2(_currentVersion,_neededVersion);
    If (((!(_list isEqualTo []))&&{_currentVersion isEqualTo _neededVersion})&&{!GVAR(forceReload)}) then {
        _arsenalList = _list;
    } else {
        _arsenalList = [side ace_player, true] call FUNC(getSideRestrictedArsenal);
        profileNamespace setVariable [format[QGVAR(arsenalList_%1), str _side], [_neededVersion ,_arsenalList]];
        saveProfileNamespace;
    };

    [_targetObject, _arsenalList, false] call ace_arsenal_fnc_initBox;
    GVAR(isPreloaded) = true;
};
