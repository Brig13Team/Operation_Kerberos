/**
 * Author: Dorbedo
 * the aid mission
 *
 * Arguments:
 * 0: <LOCATION> the mission
 * 1: <ARRAY> the targets
 *
 * Return Value:
 * Nothing
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_mission", "_targets"];

(_targets select 0) setVariable [QGVAR(isActive), true];

TRACEV_1(_targets);

[
    {
        params [["_parameter", [], [[]]], "_handler"];
        _parameter params [["_mission", locationNull, [locationNull]], ["_helipad", objNull, [objNull]]];
        If ((isNull _mission) || {isNull _helipad}) exitWith {
            [_handler] call CBA_fnc_removePerFrameHandler;
        };

        private _nearObjects = nearestObjects [getPos _helipad, ["ReammoBox", "Helicopter", "LandVehicle"], 10, false];
        _objects select {[_x] call EFUNC(common,hasInventory)};

        private _blood = _helipad getVariable [QGVAR(blood), 300];
        private _bandages = _helipad getVariable [QGVAR(bandages), 1500];
        private _morphine = _helipad getVariable [QGVAR(morphine), 500];
        private _epi = _helipad getVariable [QGVAR(epipen), 300];

        {
            private _items = itemCargo _x;
            private _curBlood = {_x == "ace_bloodIV"} count _items;
            If ((_curBlood > 0) && {_blood > 0}) then {
                _curBlood = _curBlood min _blood;
                [_x, "ace_bloodIV", _curBlood] call CBA_fnc_removeItemCargo;
                _blood = _blood - _curBlood;
            };
            private _curBandage = {_x == "ACE_fieldDressing"} count _items;
            If ((_curBandage > 0) && {_bandages > 0}) then {
                _curBandage = _curBandage min _bandages;
                [_x, "ACE_fieldDressing", _curBandage] call CBA_fnc_removeItemCargo;
                _bandages = _bandages - _curBandage;
            };
            private _curMorphine = {_x == "ACE_morphine"} count _items;
            If ((_curMorphine > 0) && {_morphine > 0}) then {
                _curMorphine = _curMorphine min _morphine;
                [_x, "ACE_morphine", _curMorphine] call CBA_fnc_removeItemCargo;
                _morphine = _morphine - _curMorphine;
            };
            private _curEpi = {_x == "ACE_epinephrine"} count _items;
            If ((_curEpi > 0) && {_epi > 0}) then {
                _curEpi = _curEpi min _epi;
                [_x, "ACE_epinephrine", _curEpi] call CBA_fnc_removeItemCargo;
                _epi = _epi - _curEpi;
            };
            nil
        } count _nearObjects;

        _helipad getVariable [QGVAR(blood), _blood];
        _helipad getVariable [QGVAR(bandages), _bandages];
        _helipad getVariable [QGVAR(morphine), _morphine];
        _helipad getVariable [QGVAR(epipen), _epi];

        TRACEV_6(_blood,_bandages,_morphine,_epi,_helipad,_nearobjects);

        if ((_blood <= 0) && {_bandages <= 0} && {_morphine <= 0} && {_epi <= 0}) then {
            [_handler] call CBA_fnc_removePerFrameHandler;
            _helipad call FUNC(statemachine_increaseCounter);
        };
    },
    60,
    [_mission, _targets select 0]
] call CBA_fnc_addPerFrameHandler;

_targets
