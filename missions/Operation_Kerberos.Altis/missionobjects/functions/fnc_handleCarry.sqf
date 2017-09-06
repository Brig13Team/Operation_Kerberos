/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params["_params","_handle"];
_params params ["_carrier","_suitcase"];

private _drop = false;
private _pos = _suitcase getVariable QGVAR(obj_pickupPoint);

private _registeredCarrier = _suitcase getVariable [QGVAR(obj_carrier),objNull];

// remove the handler, if a new handle was registered;
If ((!(_carrier == _registeredCarrier))||{isNull _registeredCarrier}) then {
    [_handle] call CBA_fnc_removePerFrameHandler;
};

// drop the case, if the unit is dead, or not existent
If !(alive _carrier) then {
    _drop = true;
    If (isNull _carrier) then {
        _pos = getPosASL _carrier;
    };
};

If (_drop) exitWith {
    _carrier forceWalk false;
    _suitcase setPosASL _pos;
    [_handle] call CBA_fnc_removePerFrameHandler;
};

// carrier is inside a vehicle and suitcase is still attached
If ((vehicle _carrier != _carrier)&&(!(isNull attachedTo _suitcase))) then {
    detach _suitcase;
    if (isMultiplayer) then {
        _suitcase enableSimulationGlobal false;
    } else {
        _suitcase enableSimulation false;
    };
    _carrier forceWalk false;
    _suitcase setPosASL [0,0,1000];
};


If ( ((isNull attachedTo _suitcase)) && {(vehicle _carrier) == _carrier} ) exitWith {
    if (isMultiplayer) then {
        _suitcase enableSimulationGlobal true;
    } else {
        _suitcase enableSimulation true;
    };
    [_suitcase,_carrier] spawn {
        params ["_suitcase","_carrier"];

        _carrier action ["SwitchWeapon", _carrier, _carrier, 100];

        uiSleep ANIM_TIME;
        _suitcase attachTo [_carrier, ATTACH_POINT, "RightHand"];
        _suitcase setDir 90;
        _carrier forceWalk true;
    };
};
