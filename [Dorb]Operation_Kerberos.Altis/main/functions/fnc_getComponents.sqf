/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Compiles all Components
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


private _configs = "((((configname _x) splitString '_') select 0) isEqualTo 'CfgComponent')" configClasses missionConfigFile;

private _fnc_dependecies_CfgPatches = {
    _this params ["_config"];
    If (isClass (_config >> "dependencies")) then {
        (1 > ({!isClass(configFile >> "CfgPatches" >> _x)} count (getArray(_config >> "dependencies" >> "CfgPatches"))));
    }else{
        true;
    };
};


///
private _cfgArray = [];
{
    private _cfg = _x;
    private _cfgname = (configName _x) splitString "_";
    _cfgname deleteAt 0; // remove CfgComponens
    _cfgname deleteAt 0; // remove PREFIX
    _cfgname = _cfgname joinString "_";
    If (([_cfg] call _fnc_dependecies_cfgpatches)&&{(getNumber(missionConfigFile>>"CfgComponents">>_cfgname)>0)||(_cfgname in ["main"])}) then {
        _cfgArray pushBack [_cfg,_cfgname,getArray(_cfg >> "dependencies" >> "CfgComponents")];
        //#ifdef DEBUG_MODE_FULL
            diag_log text (format["[MissionFile] (%1) Component is loading - CfgPatches check passed",_cfgname]);
        //#endif
    }else{
        If (getNumber(missionConfigFile>>"CfgComponents">>_cfgname)>0) then {
            diag_log text (format["[MissionFile] (%1) Component is NOT loading - CfgPatches check failed",_cfgname]);
        }else{
            diag_log text (format["[MissionFile] (%1) Component is NOT loading - disabled via CfgComponents",_cfgname]);
        };
    };
} forEach ("((((configname _x) splitString '_') select 0) isEqualTo 'CfgComponent')" configClasses missionConfigFile);

TRACEV_1(_cfgArray);
private _active_Components = [];
private _active_Components_cfgs = [];
private _time = diag_tickTime + 30;

while {(diag_tickTime < _time)&&((count _cfgArray)>0)} do {
    (_cfgArray deleteAt 0) params ["_cfg","_cfgname","_reqComponents"];
    TRACEV_5(_cfg,_cfgname,_reqComponents,_active_Components,_cfgArray);
    If (({!(_x in _active_Components)} count _reqComponents)<1) then {
        _active_Components pushBack _cfgname;
        _active_Components_cfgs pushBack _cfg;
    }else{
        _cfgArray pushBack [_cfg,_cfgname,_reqComponents];
    };
};

TRACEV_3(_active_Components,_active_Components_cfgs,_cfgArray);

GVAR(Events_preinit) = [];
GVAR(Events_postinit) = [];
GVAR(Events_all) = [];

{
    private _cfg = _x;
    private _cfgname = (configName _x) splitString "_";
    _cfgname deleteAt 0; // remove CfgComponens
    _cfgname deleteAt 0; // remove PREFIX
    _cfgname = _cfgname joinString "_";
    private _allEvents = "(!((configname _x) isEqualTo 'dependencies'))" configclasses _cfg;
    {
        private _eventName = tolower (configName _x);
        private _eventConfig = _x;
        private _add = true;
        If !([_eventConfig] call _fnc_dependecies_cfgpatches) then {
            diag_log text (format["[MissionFile] (%1) Event %2 is NOT loading - CfgPatches failed",_cfgname,_eventName]);
            _add = false;
        };
        If (_add && (0 < ( {!(_x in _active_Components)} count (getArray(_eventConfig >> "dependencies" >> "CfgComponents")) ) ) ) then {
            diag_log text (format["[MissionFile] (%1) Event %2 is NOT loading - CfgComponent failed",_cfgname,_eventName]);
            _add = false;
        };
        If (_add && (isText(_eventConfig >> "dependencies" >> "Condition"))) then {
            private _condition = call compile (getText(_eventConfig >> "dependencies" >> "Condition"));
            If ((IS_BOOL(_condition))&&{!_condition}) then {
                diag_log text (format["[MissionFile] (%1) Event %2 is NOT loading - Condition failed",_cfgname,_eventName]);
                _add = false;
            };
        };
        If !(isServer && hasInterface) then {
            If (isServer) then {
                If ((isNumber(_eventConfig >> "server"))&&{(getNumber(_eventConfig >> "server"))==0}) then {
                    _add = false;
                };
            }else{
                If ((isNumber(_eventConfig >> "client"))&&{(getNumber(_eventConfig >> "client"))==0}) then {
                    _add = false;
                };
            };
        };
        If (_add) then {
            If (([_eventName,"preinit"] call CBA_fnc_find)>-1) then {
                GVAR(Events_preinit) pushBack format["%1\EH_%2.sqf",_cfgname,_eventName];
            }else{
                If (([_eventName,"postinit"] call CBA_fnc_find)>-1) then {
                    GVAR(Events_postinit) pushBack format["%1\EH_%2.sqf",_cfgname,_eventName];
                }else{
                    GVAR(Events_all) pushBack format["%1\EH_%2.sqf",_cfgname,_eventName];
                };
            };
            diag_log text (format["[MissionFile] (%1) Event %2 is loading - Checks passed",_cfgname,_eventName]);
        }else{
            diag_log text (format["[MissionFile] (%1) Event %2 is NOT loading - Checks failed",_cfgname,_eventName]);
        };
    } forEach _allEvents;
} forEach _active_Components_cfgs;

TRACEV_3(GVAR(Events_preinit),GVAR(Events_postinit),GVAR(Events_all));


[
    {
        If (GVAR(Events_preinit) isEqualTo []) then {
            (_this select 1) call CBA_fnc_removePerFrameHandler;
        };
        private _current = GVAR(Events_preinit) deleteAt 0;
        [] call compile preprocessFileLineNumbers _current;
    },
    0,
    []
] call CBA_fnc_addPerFrameHandler;

[
    {(!isNil "BIS_fnc_init")&&{BIS_fnc_init}},
    {
        [
            {
                If (GVAR(Events_postinit) isEqualTo []) then {
                    (_this select 1) call CBA_fnc_removePerFrameHandler;
                };
                private _current = GVAR(Events_postinit) deleteAt 0;
                [] call compile preprocessFileLineNumbers _current;
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
                If (GVAR(Events_all) isEqualTo []) then {
                    (_this select 1) call CBA_fnc_removePerFrameHandler;
                };
                private _current = GVAR(Events_all) deleteAt 0;
                [] call compile preprocessFileLineNumbers _current;
            },
            0,
            []
        ] call CBA_fnc_addPerFrameHandler;
    },
    []
] call CBA_fnc_waitUntilAndExecute;





















//
