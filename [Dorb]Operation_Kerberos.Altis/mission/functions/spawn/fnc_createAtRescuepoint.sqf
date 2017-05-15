/*
 *  Author: Dorbedo
 *
 *  Description:
 *      create a vehicle/vehicles at the rescuepoint
 *
 *  Parameter(s):
 *      0 : STRING/ARRAY - the vehicles to be created
 *
 *  Returns:
 *      ARRAY - a array with the spawned objects
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_vehicles",[],["",[]]]];

If (IS_STRING(_vehicles)) then {
    _vehicles = [_vehicles]
};

private _spawnposition = (getMarkerPos GVARMAIN(rescuemarker));



// detecting carrier/harbour
If (surfaceIsWater _spawnposition) then {
    // carrier detection:
    private _tempos1 = + _spawnposition;
    private _tempos2 = + _tempos1;
    _tempos1 set [2,0];
    _tempos2 set [2,40];
    private _objects = lineIntersectsWith[_tempos1,_tempos2];
    private _offset = 0.5;
    If (({(typeOf _x isKindOf "Land_Carrier_01_hull_base_F")||{(typeOf _x isKindOf "Land_Carrier_01_hull_GEO_Base_F")}} count _objects)>0) then {
        private _nearCarriers = _spawnposition nearObjects ["Land_Carrier_01_base_F",400];
        If !(_nearCarriers isEqualTo []) then {
            _offset = ((getPosASL (_nearCarriers select 0)) select 2) + 23.7;
        };
    };
    _spawnposition set [2,_offset];
}else{
    _spawnposition = AGLtoASL _spawnposition;
};

TRACEV_1(_spawnposition);

private _objects = [];
for "_i" from -2 to 4 do {
    for "_j" from -2 to 2 do {
        private _tempPos = +_spawnposition;
        _tempPos = _tempPos vectorAdd [3*_j,0,0];
        _tempPos = _tempPos vectorAdd [0,6*_i,0];
        TRACEV_3(_spawnposition,_tempPos,AGLtoASL _tempPos);
        If ((nearestObjects [ASLtoAGL _tempPos, ["Air","LandVehicle","Thing"], 2, true]) isEqualTo []) then {
            private _tempType = _vehicles deleteAt 0;
            private _temp = createVehicle [_tempType, _tempPos, [], 0, "NONE"];
            _temp setPosASL _tempPos;
            _objects pushBack _temp;
        };
        CHECK(_vehicles isEqualTo [])
    };
    CHECK(_vehicles isEqualTo [])
};
_objects
