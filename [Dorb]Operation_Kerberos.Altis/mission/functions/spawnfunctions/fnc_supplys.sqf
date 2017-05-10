/*
 *  Author: Dorbedo
 *
 *  Description:
 *      special spawnfunction for a supply transport
 *
 *  Parameter(s):
 *      0 : ARRAY - the centerpositions
 *
 *  Returns:
 *      ARRAY - Array with the supply wich have to be transported
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_centerpos"];


// spawn the targetvehicle








// spawn the container
private _Units = ["supplys"] call FUNC(spawn_getObjects);

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

private _objects = [];

{
    private _temp = createVehicle [_X, _spawnposition, [], 0, "NONE"];
    _objects pushBack _temp;
} forEach _Units;







_objects;
//
