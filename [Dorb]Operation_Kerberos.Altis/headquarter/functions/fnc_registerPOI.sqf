/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a point of interest
 *
 *  Parameter(s):
 *      0 : OBJECT/POSITION - The position / the position of a object is registered as a POI
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params[["_POI",[],[[],objNull],[2,3]]];
If (_POI isEqualTo []) exitWith {};

If (IS_OBJECT(_POI)) then {
    _POI = getPos _POI;
};
// waitUntil the HQ is initialized
private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");
If (isNil "_centerpos") exitWith {
    [
        {HASH_HASKEY(GVAR(dangerzones),"centerpos")},
        {_this call FUNC(registerPOI)},
        [_POI]
    ] call CBA_fnc_waitUntilAndExecute;
};

private _xMin = HASH_GET(GVAR(dangerzones),"x") select 0;
private _xMax = HASH_GET(GVAR(dangerzones),"x") select 1;
private _yMin = HASH_GET(GVAR(dangerzones),"y") select 0;
private _yMax = HASH_GET(GVAR(dangerzones),"y") select 1;

If (
        ((_POI select 0) < _xMin)||
        ((_POI select 0) > _xMax)||
        ((_POI select 1) < _yMin)||
        ((_POI select 1) > _yMax)
    ) exitWith {};


private _newPOI = HASH_CREATE;
// add the hash to the dump to prevent the loosing because of the changed locationPosition
EGVAR(spawn,cleanUpDump) pushBack _newPOI;
_newPOI setPosition _POI;
_newPOI setSize [50,50];
_newPOI setRectangular false;
HASH_SET(_newPOI,"isPOI",true);
HASH_SET(_newPOI,"isActive",true);

#ifdef DEBUG_MODE_FULL
    [_POI,"POI","ColorRed","mil_flag"] call EFUNC(common,debug_marker_create);
#endif


HASH_GET(GVAR(POI),"Locations") pushBack _newPOI;
