/*
    Author: Dorbedo

    Description:
        returns roads in Area, type of Road

    Parameter(s):
        0 : ARRAY            - Position(2D/3D)
        1 : SCALAR            - Radius

    Return
        ARRAY -    [[Position,Direction,Roadtyp], ...] // Roadtyp (Mainroad=2;Road=1,small=0)
*/
#include "script_component.hpp"

_this params [["_position",[],[[]],[2,3]],["_radius",100,[0]]];

private _fnc_getRoadArray = {
    _this params ["_road"];
    private _roadConnectedTo = roadsConnectedTo _road;
    if (_roadConnectedTo isEqualTo []) exitWith {[]};
    private _connectedRoad = _roadConnectedTo select 0;
    private _vector = (getPos _road) vectorFromTo (getPos _connectedRoad);
    private _rotateVector = [_vector,90] call BIS_fnc_rotateVector2D;
    private _normVector = vectorNormalized _rotateVector;
    private _c = 0;
    for [{_i = 1},{_i < 6},{_i = _i + 1}] do {
        private _multiplyVector = _rotateVector vectorMultiply ((2*_i));
        private _checkpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0.1];
        _c=_i;
        if (!(isOnRoad _checkpos)) exitWith {};
    };
    private _dir = [_road,_roadConnectedTo select 0] call BIS_fnc_dirTo;
    If (_c<=1) exitWith {[];}; //No road
    If (_c<3) exitWith {[getPosASL _road,_dir,0];}; // tiny road
    If (_c<4) exitWith {[getPosASL _road,_dir,1];}; // small road
    [getPosASL _road,_dir,2]; // big road
};

private _roadlist_unformatted = _position nearRoads _radius;
private _roadlist_formatted = [];

{
    private _temp = (_x call (_getroadarray));
    If (!(_temp isEqualTo [])) then {_roadlist_formatted pushBack _temp;};
}forEach _roadlist_unformatted;

_roadlist_formatted;
