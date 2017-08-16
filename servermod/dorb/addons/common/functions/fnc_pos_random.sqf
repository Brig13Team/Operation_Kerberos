/*
    Author: Dorbedo

    Description:
    Random Position

    Parameter(s):
        0 : ARRAY   - Posistion
        1 : NUMBER  - Radius
        2 : NUMBER  - Typ


    Returns:
    Position
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
private ["_pos","_generiere"];
_this params [
    ["_start",[],[[]],[2,3]],
    ["_rad",200,[0]],
    ["_typ",0,[0]]
];

If (_start isEqualTo []) exitWith {ERROR(FORMAT_1("Wrong Input detected = %1",_this))};

#ifdef DEBUG_MODE_FULL
    If (count _start < 2) then {
        TRACEV_4(_this,_start,_rad,_typ);
    };
#endif

private _max_run = 3000;

switch _typ do {
    // in radius
    case 0 : {
        _generiere=true;
        while {(_generiere && (_max_run>0))} do {
            _pos = _start getPos [random _rad,random 360];
            If (!(surfaceIsWater _pos)) then {
                _pos set [2,0];
                _generiere = false;
            };
            DEC(_max_run);
        };
    };
    // at Radius
    case 1 : {
        _generiere=true;
        while {(_generiere && (_max_run>0))} do {
            _pos = _start getPos [_rad,random 360];
            If (!(surfaceIsWater _pos)) then {
                _pos set [2,0];
                _generiere = false;
            };
            If (!(surfaceIsWater _pos)) then {
                _pos set [2,0];
                _generiere = false;
            };
            DEC(_max_run);
        };
    };
    // with distance to player
    case 2 : {
        _generiere=true;
        private _players = [];
        while {(_generiere && (_max_run>0))} do {
            _pos = _start getPos [random _rad,random 360];
            private _players = (call FUNC(players)) select {(_x distance _pos) > 1500};
            If ((!(surfaceIsWater _pos))&&{_players isEqualTo []}) then {
                _pos set [2,0];
                _generiere = false;
            };
            DEC(_max_run);
        };
    };
    //Water
    case 3 : {
        _generiere=true;
        private "_temp";
        while {(_generiere && (_max_run>0))} do {
            _pos = _start getPos [random _rad,random 360];
            If ((surfaceIsWater _pos)) then {
                If ((getTerrainHeightASL _pos)<(-15)) then {
                    _generiere=false;
                }else{
                    _temp=_pos;
                };
            };
            DEC(_max_run);
        };
        If (_max_run<1) then {
            If (surfaceIsWater _temp) then {
                _pos = _temp;
            }else{
                _pos=[];
            };
        };
    };
    //Random pos including water
    case 4 : {
        _pos = _start getPos [random _rad,random 360];
        _pos set [2,0];
    };
};
_pos
