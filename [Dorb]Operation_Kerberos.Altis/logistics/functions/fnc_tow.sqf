/*
    Author: iJesuz

    Description:
        towing

    Parameter(s):
        0 : OBJECT - vehicle 1
        1 : OBJECT - vehicle 2
*/
#include "script_component.hpp"

#define BUFFER 3
#define MAX_INDEX 19
#define CREATE_ARRAY(ARG) call { private _array = []; for "_i" from 0 to MAX_INDEX do { _array pushBack (ARG); }; _array }
#define INCREASE_INDEX(ARG) if ((ARG + 1) > MAX_INDEX) then { 0 } else { ARG + 1 }
#define DECREASE_INDEX(ARG) if ((ARG - 1) < 0) then { MAX_INDEX } else { ARG - 1 }

_this params [["_veh1",objNull,[objNull]],["_veh2",objNull,[objNull]]];

if ((isNull _veh1) || (isNull _veh2)) exitWith {};

private _boundingBox1 = boundingBoxReal _veh1;
private _boundingBox2 = boundingBoxReal _veh2;
private _l1 = abs(_boundingBox1 select 1 select 0);
private _l2 = abs(_boundingBox2 select 0 select 0);

private _array = _veh1 getVariable [QGVAR(towArray), CREATE_ARRAY(getDir _veh1)];
private _index = _veh1 getVariable [QGVAR(towIndex), 0];

while {(driver _veh1 == player) && (attachedTo _veh2 == _veh1)} do {
    uiSleep 0.05;

    // status: set speed limit

    if ((abs (speed _veh1)) > 0.2) then {
        // systemChat format ["_dir : %1", getDir _veh1];

        if (speed _veh1 > 0) then {
            // status: ok
            private _dir1 = _array select (INCREASE_INDEX(_index));
            private _dir2 = (getDir _veh1) - _dir1;
            _index = INCREASE_INDEX(_index);
            _array set [_index, getDir _veh1];

            private _y2 = _l2 * cos(_dir2);
            private _x2 = _l2 * sin(_dir2);
            _veh2 attachTo [_veh1, [_x2, -1 * (_l1 + _y2 + BUFFER), 0]];
            _veh2 setDir (- _dir2);
        } else {
            // status:  . could be better (_veh2 should stay after certain angle)
            //            . transform _array when changing from forward to backward
            private _dir1 = _array select (INCREASE_INDEX(_index));
            private _dir2 = (getDir _veh1) - _dir1;
            _index = INCREASE_INDEX(_index);
            _array set [_index, getDir _veh1];

            private _y2 = _l2 * cos(_dir2);
            private _x2 = _l2 * sin(_dir2);
            _veh2 attachTo [_veh1, [_x2, -1 * (_l1 + _y2 + BUFFER), 0]];
            _veh2 setDir (- _dir2);
        };
    };
};

_veh1 setVariable [QGVAR(towArray), _array, true];
_veh1 setVariable [QGVAR(towIndex), _index, true];
