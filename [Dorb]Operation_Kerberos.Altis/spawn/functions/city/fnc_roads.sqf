/*
    Author: Dorbedo
    
    Description:
        returns roads in Area, type of Road
    
    Parameter(s):
        0 : ARRAY            - Position(2D/3D)
        1 : SCALAR            - Radius

    Return
        ARRAY -    [Position,Direction,Roadtyp] // Roadtyp (Mainroad=2;Road=1,small=0)
*/
#include "script_component.hpp"
SCRIPT(roads);
Private["_position","_radius","_temp","_getroadarray","_roadlist_formatted","_roadlist_unformatted"];

_position = [_this,0,[],[[]],[2,3]] call BIS_fnc_Param;
_radius = [_this,1,100,[0]] call BIS_fnc_Param;
_temp=[];

_getroadarray = {
    Private["_roadConnectedTo","_connectedRoad","_vector","_rotateVector","_normVector","_multiplyVector","_checkpos","_dir","_c","_i","_road"];
    _road=_this;
    _roadConnectedTo = roadsConnectedTo _road;
    if (_roadConnectedTo isEqualTo [])exitWith{[]};
    
    _connectedRoad = _roadConnectedTo select 0;
    
    _vector= (getPos _road) vectorFromTo (getPos _connectedRoad);
    
    _rotateVector = [_vector,90] call BIS_fnc_rotateVector2D;
    _normVector = vectorNormalized _rotateVector;
    
    for [{_i = 1},{_i < 6},{_i = _i + 1}] do {
        _multiplyVector = _rotateVector vectorMultiply ((2*_i));
        _checkpos=[((_multiplyVector select 0)+((getPos _road select 0))),((_multiplyVector select 1)+((getPos _road select 1))),0.1];
        _c=_i;
        if (!(isOnRoad _checkpos)) exitWith {};
    };
    _dir = [_road,_roadConnectedTo select 0] call BIS_fnc_dirTo;
    If (_c<=1) exitWith {[];}; //No road
    If (_c<3) exitWith {[getPosASL _road,_dir,0];}; // tiny road
    If (_c<4) exitWith {[getPosASL _road,_dir,1];}; // small road
    [getPosASL _road,_dir,2]; // big road
};


_roadlist_unformatted = _position nearRoads _radius;
_roadlist_formatted = [];

{
    _temp = (_x call (_getroadarray));
    If (!(_temp isEqualTo [])) then {_roadlist_formatted pushBack _temp;};
}forEach _roadlist_unformatted;

_roadlist_formatted 