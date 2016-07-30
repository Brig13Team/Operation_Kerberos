/*
    Author: Dorbedo
    
    Description:
        Checks if a object can be loaded
        
    Parameter(s):
        0 : OBJECT - Target
        1 : OBJECT - Unit
        
    Returns:
        BOOL
*/
#include "script_component.hpp"
_this params ["_target","_cargo"];

If ((typeOf _cargo in ["RHS_M119_WD","RHS_M119_WD","rhs_D30_vdv","rhs_D30_at_vdv"])&&{(_cargo doorPhase 'fold_arty' == 0)}) exitWith {false};

private _cargo_class = [_cargo] call FUNC(getCargoCfg);
If ((_cargo_class isEqualTo "")||{!(isNull (attachedTo _cargo))}) exitWith {false};

private _vehicle_class = typeOf _target;

private _max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
private _max_length = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_length");
private _max_height = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_height");
If (isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo") && {_vehicle call compile getText(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "isextended")}) then {
    _max_width = _max_width max (getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "max_width"));
    _max_length = _max_length max (getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "max_length"));
    _max_height = _max_height max (getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "max_height"));
};

private _cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
private _cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
private _cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");
/// Exit if no entry in cfg
If (!(_max_width>0)) exitWith {false};
/// Way to big
If (
    (
        (
            (_cargo_length > _max_length) ||
            (_cargo_width > _max_width)
        )&&(
            (_cargo_length > _max_width) ||
            (_cargo_width > _max_length)
        )
    )||(
        _cargo_height > _max_height
    )
    ) exitWith {false};

private _logistic_stack = _target getVariable [QGVAR(stack),[]];
/// EMPTY Truck
if (_logistic_stack isEqualTo []) exitWith {true};
private _last_row = _logistic_stack select ((count _logistic_stack) - 1);
private _last_cargo = _last_row select ((count _last_row) - 1);
private _row_width = 0;
private _row_length = _last_row select 0 select 2;
private _left_length = _row_length + (if ((getDir (_last_cargo select 0)) == (getDir _vehicle)) then { _last_row select 0 select 1 select 1 } else { _last_row select 0 select 1 select 0 });
{
    _row_width = _row_width + (if ((getDir (_x select 0)) == (getDir _vehicle)) then { _x select 1 select 0 } else { _x select 1 select 1 });
    _row_length = if ((_x select 2) < _row_length) then { _x select 2 } else { _row_length };
} forEach _last_row;
_row_width = _row_width + (count _last_row - 1) * SPACE_BETWEEN_CARGO;

if (((_max_width - _row_width >= _cargo_width + SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_length + SPACE_BETWEEN_CARGO)) || ((_max_width - _row_width >= _cargo_length + SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_width + SPACE_BETWEEN_CARGO))) exitWith { true };
if (!(((_row_length < _cargo_length + SPACE_BETWEEN_CARGO) || (_max_width < _cargo_width)) && ((_row_length < _cargo_width + SPACE_BETWEEN_CARGO) || (_max_width < _cargo_length)))) exitWith { true };

/// STACKING
private _stackable = false; 
for [{_i = 0},{_i < (count _last_row)},{_i = _i + 1}] do {
    if (((getModelInfo (_last_row select _i select 0) select 0) == (getModelInfo _cargo select 0)) && (!(_last_row select _i select 5)) && (((_last_row select _i select 1 select 3 select 2) + 2 * _cargo_height) <= _max_height)) exitWith { _stackable = true; };
};
if (_stackable) exitWith { true };

false;