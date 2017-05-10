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

// carrier detection
private _nearCarriers = _spawnposition nearObjects ["Land_Carrier_01_base_F",400];
If !(_nearCarriers isEqualTo []) then {
    private _offset = ((getPosASL (_nearCarriers select 0)) select 2) + 23.7;
    _spawnposition set[2,_offset];
}else{
    If (surfaceIsWater _spawnposition) then {
        _spawnposition set [2,0];
    }else{
        _spawnposition = AGLtoASL _spawnposition;
    };
};

_spawnposition = ASLtoAGL(_spawnposition);


private _objects = [];

{
    private _temp = createVehicle [_X, _spawnposition, [], 0, "NONE"];
    _objects pushBack _temp;
    _spawnpos = _spawnpos getPos [3,90];
} forEach _vehicles;


_objects
