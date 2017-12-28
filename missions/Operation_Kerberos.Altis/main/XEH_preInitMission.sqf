#include "script_component.hpp"
/**
 * Name: dorb_main_XEH_preInitMission
 *
 * Author: Dorbedo
 * handles the missionInitialisation
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */

FUNCMAIN(compileComponent);

private _compilingStart = diag_tickTime;
private _allComponents = configProperties [missionConfigFile, "(isClass _x) && {isClass (_x >> 'CfgPatches')}", true];
private _allCfgPatches = (configProperties [ConfigFile >> "CfgPatches", "isClass _x", true]) apply {toLower(configName _x)};

private _componentsToInitialize = [];
private _errorCounter = count _allComponents;
private _temp_CheckedComponents = [];

while {_errorCounter > 0} do {

    If (_allComponents isEqualTo []) then {
        _errorCounter = _errorCounter - 1;
        _allComponents = _temp_CheckedComponents;
    };

    private _curCfg = _allComponents deleteAt 0;
    private _curAddOn = configName _x;
    private _requiredAddons = getArray(_curCfg >> "CfgPatches" >> _curAddOn >> "requiredAddons");

    if (({!((toLower _x) in _allCfgPatches)} count _requiredAddons) isEqualTo 0) then {
        _componentsToInitialize pushBack _curCfg;
    } else {
        _temp_CheckedComponents pushBack _curCfg;
    };
};


GVAR(Events_preInit) = [];
GVAR(Events_postInit) = [];
GVAR(Events_other) = [];

{
    [_x] call FUNC(compileComponent);
    nil
} count _allComponents;

[
    {(!isNil "BIS_fnc_init")&&{BIS_fnc_init}},
    {
        [
            {
                If (GVAR(Events_postinit) isEqualTo []) exitWith {
                    diag_log text "[MissionFile] (System) PostInit compiling finished";
                    (_this select 1) call CBA_fnc_removePerFrameHandler;
                };
                private _current = GVAR(Events_postinit) deleteAt 0;
                #ifdef DEBUG_MODE_FULL
                    private _time = diag_tickTime;
                    diag_log text (format["[MissionFile] (postInit) Compiling %1 started",_current]);
                #endif
                [] call compile preprocessFileLineNumbers _current;
                #ifdef DEBUG_MODE_FULL
                    diag_log text (format["[MissionFile] (postInit) Compiling %1 finished in %2",_current,_time - diag_tickTime]);
                #endif
            },
            0,
            []
        ] call CBA_fnc_addPerFrameHandler;
    },
    []
] call CBA_fnc_waitUntilAndExecute;

[
    {(!isNil "BIS_fnc_init")&&{BIS_fnc_init}},
    {
        [
            {
                If (GVAR(Events_all) isEqualTo []) exitWith {
                    diag_log text "[MissionFile] (main) Events compiling finished";
                    (_this select 1) call CBA_fnc_removePerFrameHandler;
                };
                private _current = GVAR(Events_all) deleteAt 0;
                #ifdef DEBUG_MODE_FULL
                    diag_log text (format["[MissionFile] (main) Compiling %1",_current]);
                #endif
                [] call compile preprocessFileLineNumbers _current;

            },
            0,
            []
        ] call CBA_fnc_addPerFrameHandler;
    },
    []
] call CBA_fnc_waitUntilAndExecute;

private _time = diag_tickTime + 60;
while {(diag_tickTime < _time)&&(!(GVAR(Events_preinit) isEqualTo []))} do {
    private _current = GVAR(Events_preinit) deleteAt 0;
    #ifdef DEBUG_MODE_FULL
        private _time = diag_tickTime;
        diag_log text (format["[MissionFile] (preInit) Compiling %1 started",_current]);
    #endif
    [] call compile preprocessFileLineNumbers _current;
    #ifdef DEBUG_MODE_FULL
        diag_log text (format["[MissionFile] (preInit) Compiling %1 finished in %2",_current,_time - diag_tickTime]);
    #endif
};

IF (!(GVAR(Events_preinit) isEqualTo [])) then {
    diag_log text "[MissionFile] (main) PreInit Compiling not finished";
}else{
    diag_log text format["[MissionFile] (main) PreInit Compiling finished in: %1",(diag_ticktime - _PreinitStartTime)];
};
