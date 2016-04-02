/*
    Author: Dorbedo
    
    Description:
        shows the loadable cargo
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        ARRAY - ChildActions
*/
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];
CHECKRET(isNull _target,[]);

private _load_point_offset = getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point");
private _load_point = _target modelToWorld _load_point_offset;
private _nearObjects = nearestObjects[_load_point, ["AllVehicles","ThingX"], 3];


private _loadActions = [];


{
    _cargo = _x;   
    If ((_target != _cargo)&&{[_target,_cargo] call FUNC(canbeLoaded)}) then {
        _loadActions pushBack [
            QGVAR(action_load),
            localize LSTRING(ACTION_LOAD),
            "",
            {[_target] spawn FUNC(doload);},
            {true}
        
        ];
    };
    
} forEach _nearObjects;








private ["_vehicleActions", "_actions", "_action", "_vehicles", "_vehicle", "_needToAdd", "_magazineHelper", "_turretPath", "_magazines", "_magazine", "_icon", "_cnt"];


_vehicles = nearestObjects [_target, ["AllVehicles"], 20];
if (count _vehicles < 2) exitWith {false}; // Rearming needs at least 2 vehicles

_vehicleActions = [];
{
    _actions = [];
    _vehicle = _x;
    _needToAdd = false;
    _action = [];
    if !((_vehicle == _target) || (_vehicle isKindOf "CAManBase")) then {
        _magazineHelper = [];
        {
            _turretPath = _x;
            _magazines = [_vehicle, _turretPath] call FUNC(getConfigMagazines);
            {
                _magazine = _x;
                _currentMagazines = { _x == _magazine } count (_vehicle magazinesTurret _turretPath);
                if ((_currentMagazines < ([_vehicle, _turretPath, _magazine] call FUNC(getMaxMagazines))) && !(_magazine in _magazineHelper)) then {
                    _action = [_magazine,
                        getText(configFile >> "CfgMagazines" >> _magazine >> "displayName"),
                        getText(configFile >> "CfgMagazines" >> _magazine >> "picture"),
                        {_this call FUNC(takeAmmo)},
                        {true},
                        {},
                        [_magazine, _vehicle]] call EFUNC(interact_menu,createAction);
                    _actions pushBack [_action, [], _target];
                    _magazineHelper pushBack _magazine;
                    _needToAdd = true;
                } else {
                    if (((_vehicle magazineTurretAmmo [_magazine, _turretPath]) < getNumber (configFile >> "CfgMagazines" >> _magazine >> "count")) && !(_magazine in _magazineHelper)) then {
                        _action = [_magazine,
                            getText(configFile >> "CfgMagazines" >> _magazine >> "displayName"),
                            getText(configFile >> "CfgMagazines" >> _magazine >> "picture"),
                            {_this call FUNC(takeAmmo)},
                            {true},
                            {},
                            [_magazine, _vehicle]] call EFUNC(interact_menu,createAction);
                        _actions pushBack [_action, [], _target];
                        _magazineHelper pushBack _magazine;
                        _needToAdd = true;
                    };
                };
            } forEach _magazines;
        } forEach REARM_TURRET_PATHS;
    };
    if (_needToAdd && !(_vehicle getVariable [QGVAR(disabled), false])) then {
        _icon = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "Icon");
        if !((_icon select [0, 1]) == "\") then {
            _icon = "";
        };
        if (GVAR(level) == 0) then {
            _action = [_vehicle,
                getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName"),
                _icon,
                {_this call FUNC(rearmEntireVehicle)},
                {true},
                {},
                _vehicle] call EFUNC(interact_menu,createAction);
            _vehicleActions pushBack [_action, [], _target];
        } else {
            _action = [_vehicle,
                getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName"),
                _icon,
                {},
                {true},
                {},
                []] call EFUNC(interact_menu,createAction);
            _vehicleActions pushBack [_action, _actions, _target];
        };
    };
} forEach _vehicles;

_vehicleActions