/*
    Author: iJesuz

    Description:
        logistic script

    Parameter(s):
        0: OBJECT - cargo
        1: OBJECT - vehicle

*/
#include "script_component.hpp"

_this params ["_vehicle","_cargo"];
private _vehicle_class = typeOf _vehicle;
private _cargo_class = [_cargo] call FUNC(getCargoCfg);

if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
    ["unsupported vehicle",["unsupported vehicle"],"",false] call EFUNC(interface,disp_info);
};
if (_cargo_class isEqualTo "") exitWith {
    ["unsupported cargo",["unsupported cargo"],"",false] call EFUNC(interface,disp_info);
};
if (!(isNull attachedTo _cargo)) exitWith {
    ["cargo already attached",["cargo already attached"],"",false] call EFUNC(interface,disp_info);
};

private _cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
private _cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
private _cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");
private _cargo_offset = [0,0,0];
if (isArray(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class)) then {
    _cargo_offset = getArray(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "offset");
};

private _point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo_point");
private _max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
private _max_length = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_length");
private _max_height = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_height");
If (isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo") && {_vehicle call compile getText(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "isextended")}) then {
    _max_width = _max_width max (getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "max_width"));
    _max_length = _max_length max (getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "max_length"));
    _max_height = _max_height max (getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo" >> "max_height"));
};
private _logistic_stack = _vehicle getVariable [QGVAR(stack),[]];

if ((_max_height > 0) && {_cargo_height > _max_height}) exitWith {
    ["cargo to high",["cargo to high"],"",false] call EFUNC(interface,disp_info);
};

private ["_attach_point","_rotate"];

if (!(_logistic_stack isEqualTo [])) then {
    // vehicle has already a cargo
    private _last_row = _logistic_stack select ((count _logistic_stack) - 1);
    private _last_cargo = _last_row select ((count _last_row) - 1);

    private _row_width = 0;
    private _row_length = _last_row select 0 select 2;
    private _left_length = _row_length + (if ((getDir (_last_cargo select 0)) == (getDir _vehicle)) then { _last_row select 0 select 1 select 1 } else { _last_row select 0 select 1 select 0 });

    {
        _row_width = _row_width + (if ((getDir (_x select 0)) == (getDir _vehicle)) then { _x select 1 select 0 } else { _x select 1 select 1 });
        if (_row_length >= (_x select 2)) then {
            _last_cargo = _x;
            _row_length = _last_cargo select 2;
        };
    } forEach _last_row;
    _row_width = _row_width + (count _last_row - 1) * SPACE_BETWEEN_CARGO;

    if ( ((_max_width - _row_width >= _cargo_width + SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_length + SPACE_BETWEEN_CARGO)) || // cargo fits in row without rotating
         ((_max_width - _row_width >= _cargo_length + SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_width + SPACE_BETWEEN_CARGO)) /* cargo fits in row if rotated */) then {

        // add to existing row

        private ["_dir","_apoint"];
        _rotate = true;
        if ((_max_width - _row_width >= _cargo_width - SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_length - SPACE_BETWEEN_CARGO)) then { _rotate = false; };

        if (_rotate) then {
            _row_width = _row_width + SPACE_BETWEEN_CARGO + _cargo_length;
            {
                _apoint = _x select 1 select 3;
                _apoint set [0,(_apoint select 0) - ((SPACE_BETWEEN_CARGO + _cargo_length) / 2)];
                _dir = (getDir (_x select 0)) == (getDir _vehicle);
                (_x select 0) attachTo [_vehicle,_apoint];
                (_x select 1) set [3,_apoint];
            } forEach _last_row;
            _attach_point = [
                (_apoint select 0) + (_cargo_offset select 0) + SPACE_BETWEEN_CARGO + _cargo_length/2 + ((if ((getDir (_last_cargo select 0)) == (getDir _vehicle)) then { _last_cargo select 1 select 0 } else { _last_cargo select 1 select 1 })/2),
                (_point select 1) + (_cargo_offset select 1) - _max_length + _left_length - (_cargo_width/2),
                (_point select 2) + (_cargo_height / 2)  + (_cargo_offset select 2)
            ];
            _last_row pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point], _left_length - _cargo_width, _rotate, [], false];
            _logistic_stack resize (count _logistic_stack - 1);
            _logistic_stack pushBack _last_row;
        } else {
            _row_width = _row_width + SPACE_BETWEEN_CARGO + _cargo_width;
            {
                _apoint = _x select 1 select 3;
                _apoint set [0,(_apoint select 0) - ((SPACE_BETWEEN_CARGO + _cargo_width) / 2)];
                _dir = (getDir (_x select 0)) == (getDir _vehicle);
                (_x select 0) attachTo [_vehicle,_apoint];
                (_x select 1) set [3,_apoint];
            } forEach _last_row;
            _attach_point = [
                (_apoint select 0) + (_cargo_offset select 0) + SPACE_BETWEEN_CARGO + _cargo_width/2 + ((if ((getDir (_last_cargo select 0)) == (getDir _vehicle)) then { _last_cargo select 1 select 0 } else { _last_cargo select 1 select 1 })/2),
                (_point select 1) + (_cargo_offset select 1) - _max_length + _left_length - (_cargo_length/2),
                (_point select 2) + (_cargo_height / 2)  + (_cargo_offset select 2)
            ];
            _last_row pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point], _left_length - _cargo_length, _rotate, [], false];
            _logistic_stack resize (count _logistic_stack - 1);
            _logistic_stack pushBack _last_row;
        };
    } else {
        private _stackable = false;

        private "_i";
        for [{_i = 0},{_i < (count _last_row)},{_i = _i + 1}] do {
            if (((getModelInfo (_last_row select _i select 0) select 0) == (getModelInfo _cargo select 0)) && (!(_last_row select _i select 5)) && (((_last_row select _i select 1 select 3 select 2) +  2 * _cargo_height) <= _max_height)) exitWith { _stackable = true; };
        };

        if (_stackable) then {
            // stack cargo

            private _under = _last_row select _i;
            _under set [5,true];

            _attach_point =+ (_under select 1 select 3);
            _attach_point set [2,(_attach_point select 2) + _cargo_height + (_cargo_offset select 2)];
            _rotate = _under select 3;

            _last_row set [_i,_under];
            _last_row pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point],_under select 2,_rotate,[(count _logistic_stack) - 1, _i], false];
            _logistic_stack resize (count _logistic_stack - 1);
            _logistic_stack pushBack _last_row;
        } else {
            // create new row

            if (((_row_length < _cargo_length + SPACE_BETWEEN_CARGO) || (_max_width < _cargo_width)) && // cargo fits without rotating
                ((_row_length < _cargo_width + SPACE_BETWEEN_CARGO) || (_max_width < _cargo_length)) /* cargo fits if rotated */ ) exitWith {
                _attach_point = [];
            };

            _rotate = true;
            if ((_row_length >= _cargo_length - SPACE_BETWEEN_CARGO) && (_max_width >= _cargo_width)) then { _rotate = false; };
            // if ( && {(_max_length >= _cargo_width - SPACE_BETWEEN_CARGO) && (_max_width >= _cargo_length)}) then { _rotate = true; };

            if (_rotate) then {
                _attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_width / 2) - SPACE_BETWEEN_CARGO - _max_length + (_last_cargo select 2) + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2)  + (_cargo_offset select 2)];
                _logistic_stack pushBack [[_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point],_row_length - SPACE_BETWEEN_CARGO - _cargo_width, _rotate, [], false]];
            } else {
                _attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_length / 2) - SPACE_BETWEEN_CARGO - _max_length + (_last_cargo select 2) + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2)  + (_cargo_offset select 2)];
                _logistic_stack pushBack [[_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point],_row_length - SPACE_BETWEEN_CARGO - _cargo_length, _rotate, [], false]];
            };
        };
    };
} else {
    // vehicle is empty

    if (((_max_length < _cargo_length) || (_max_width < _cargo_width)) && ((_max_length < _cargo_width) || (_max_width < _cargo_length))) exitWith {
        _attach_point = [];
    };

    _rotate = true;
    if ((_max_length >= _cargo_length) && (_max_width >= _cargo_width)) then { _rotate = false; };
    // if (_rotate && {(_max_length >= _cargo_width) && (_max_width >= _cargo_length)}) then { _rotate = true; };

    if (_rotate) then {
        _attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_width / 2)  + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2) + (_cargo_offset select 2)];
        _logistic_stack pushBack [[_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point],_max_length - _cargo_width, _rotate, [], false]];
    } else {
        _attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_length / 2)  + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2) + (_cargo_offset select 2)];
        _logistic_stack pushBack [[_cargo,[_cargo_width,_cargo_length,_cargo_height,_attach_point],_max_length - _cargo_length, _rotate, [], false]];
    };
};

if(_attach_point isEqualTo []) exitWith {
    ["cargo doesn't fit",["cargo doesn't fit"],"",false] call EFUNC(interface,disp_info);
};

private _cargo_mass = getMass _cargo;
private _vehicle_mass = getMass _vehicle;

_cargo lock true;
_cargo attachTo [_vehicle,_attach_point];
if(_rotate) then { _cargo setDir 90; };
_vehicle setVariable [QGVAR(stack),_logistic_stack,true];
_vehicle setMass (_vehicle_mass + _cargo_mass);

if (isMultiplayer && {!local _vehicle}) then {
    [QGVAR(updateSeats_Vehicle),[_vehicle],_vehicle] call CBA_fnc_targetEvent;
} else {
    [_vehicle] call FUNC(updateSeats);
};

[_cargo,_vehicle] call EFUNC(common,setOwner);