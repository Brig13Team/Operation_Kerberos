/*
    Author: iJesuz, Dorbedo

    Description:
        logistic script

    Parameter(s):
        0: OBJECT - vehicle
*/
#include "script_component.hpp"

params ["_vehicle"];

private _vehicle_class = typeOf _vehicle;
private _logistic_stack = _vehicle getVariable [QGVAR(stack),[]];

if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
    ["unsupported vehicle",["unsupported vehicle"],"",false] call EFUNC(interface,disp_info);
};
if (_logistic_stack isEqualTo []) exitWith {
    ["vehicle is empty",["vehicle is empty"],"",false] call EFUNC(interface,disp_info);
};

private _last_row = _logistic_stack select ((count _logistic_stack) - 1);
private _last_cargo = _last_row select ((count _last_row) - 1);
_last_row resize (count _last_row - 1);

if (_last_row isEqualTo []) then { _logistic_stack resize ((count _logistic_stack) - 1); } else { _logistic_stack set [(count _logistic_stack) - 1, _last_row]; };

private _vehicle_mass = getMass _vehicle;

if (!((_last_cargo select 4) isEqualTo [])) then {
    private _index = _last_cargo select 4;
    private _row = _logistic_stack select (_index select 0);
    private _elem = _row select (_index select 1);
    _elem set [5,false];
    _row set [_index select 0, _elem];
    _logistic_stack set [_index select 0, _row];
};

private "_cargo_mass";
if (!((_last_cargo select 0) in (attachedObjects _vehicle))) exitWith {
    _cargo_mass = getMass (_last_cargo select 0);
    _vehicle setVariable [QGVAR(stack),_logistic_stack];
    _vehicle setMass (_vehicle_mass - _cargo_mass);
};

private _detach_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "load_point");
private _cargo_width = _last_cargo select 1 select 0;
private _cargo_length = _last_cargo select 1 select 1;
private _cargo_height = _last_cargo select 1 select 2;
private _offset = [0,0,0];
if (isArray(missionConfigFile >> "logistics" >> "cargos" >> ([_last_cargo select 0] call FUNC(getCargoCfg)))) then {
    _offset = getArray(missionConfigFile >> "logistics" >> "cargos" >> ([_last_cargo select 0] call FUNC(getCargoCfg)) >> "offset");
};
_detach_point = _detach_point vectorAdd _offset;
_detach_point = _detach_point vectorDiff [0,_cargo_length/2,0];
_detach_point = _vehicle modelToWorld _detach_point;

detach (_last_cargo select 0);
_cargo_mass = getMass (_last_cargo select 0);
(_last_cargo select 0) setPos _detach_point;
(_last_cargo select 0) setDir (getDir _vehicle);
(_last_cargo select 0) lock false;

if (isMultiplayer && {!local _vehicle}) then {
    [QGVAR(updateSeats_Vehicle),[_vehicle],_vehicle] call CBA_fnc_targetEvent;
} else {
    [_vehicle] call FUNC(updateSeats);
};

SETVAR(player,GVAR(isloading),false);
if ([_vehicle,false] call FUNC(candrop)) then {
    [(_last_cargo select 0),_vehicle] spawn {
        SCRIPTIN(unload,paradrop);
        params["_cargo","_vehicle"];
        private _time = CBA_missionTime;
        waitUntil{(((getPos _cargo)select 2)<10)||((_cargo distance _vehicle)>35)||(CBA_missionTime>(_time + 20))};
        CHECK((((getPos _cargo)select 2)<10)||(CBA_missionTime>(_time + 20)))
        private _para = createVehicle ["B_Parachute_02_F",(getPos _cargo),[],0,"FLY"];
        _para setDir (getDir _cargo);
        _para setPos (getPos _cargo);
        _cargo attachTo [_para,[0,0,0]];
        private _velocity = velocity _cargo;
        detach _para;
        _para setVelocity _velocity;
        _cargo attachTo [_para, [0,0,0]];
        _time = CBA_missionTime;
        waitUntil{((((getPos _cargo)select 2)<2)||(CBA_missionTime>(_time + 600)))};
        deleteVehicle _para;
    };
};

_vehicle setVariable [QGVAR(stack),_logistic_stack];
_vehicle setMass (_vehicle_mass - _cargo_mass);

private _aceActions = (_last_cargo select 0) getVariable [QGVAR(aceactions),[]];
If(_aceActions isEqualTo []) exitWith {};
If (_aceActions select 0) then {
    (_last_cargo select 0) setVariable ["ACE_dragging_canDrag",true,true];
};
If (_aceActions select 1) then {
    (_last_cargo select 0) setVariable ["ACE_dragging_canCarry",true,true];
};