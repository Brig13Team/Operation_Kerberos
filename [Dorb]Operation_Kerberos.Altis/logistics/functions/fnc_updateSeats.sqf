/*
    Author: iJesuz

    Description:
        blocks seats which shouldn't be useable because of the cargo

    Parameter(s):
        0: OBJECT - vehicle
*/
#include "script_component.hpp"
_this params[["_vehicle",objNull,[objNull]]];

if (isNull _vehicle) exitWith {};
if (!isClass (missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle))) exitWith {};
if (!isArray (missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "cargo_pos")) exitWith {};

private _cargo_positions = getArray (missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "cargo_pos");
private _cargo_point = getArray (missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "cargo_point");
private _stack = _vehicle getVariable [QGVAR(stack),[]];

if (_stack isEqualTo []) then {
    { _vehicle lockCargo[_x select 0, false]; } forEach _cargo_positions;
} else {
    private _last_row = _stack select (count _stack - 1);
    private _y = (_last_row select 0 select 1 select 3 select 1) - (_last_row select 0 select 1 select 1);
    private "_i";
    for [{_i = 1},{_i < (count _last_row)},{_i = _i + 1}] do {
        _y = if (_y < ((_last_row select _i select 1 select 3 select 1) - (_last_row select _i select 1 select 1))) then { (_last_row select _i select 1 select 3 select 1) - (_last_row select _i select 1 select 1) } else { _y };
    };

    {
    if (_y <= (_x select 1 select 1)) then {
        _vehicle lockCargo [_x select 0,true];
    } else {
        _vehicle lockCargo [_x select 0,false];
    };
    } forEach _cargo_positions;
};
