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
#include "script_component.hpp"

_this params[["_POI",[],[[],objNull],[2,3]]];
If (_POI isEqualTo []) exitWith {};

If (IS_OBJECT(_POI)) then {
    _POI = getPos _POI;
};

/// POI is not in the comabt area
If (((abs((_POI select 0)-(GVAR(centerpos) select 0)))>(GVAR(definitions) select 0))||
    ((abs((_POI select 1)-(GVAR(centerpos) select 1)))>(GVAR(definitions) select 0))) exitWith {};

private _newPOI = HASH_CREATE;
_newPOI setPosition _POI;
_newPOI setSize [50,50];
_newPOI setRectangular false;
HASH_SET(_newPOI,"isPOI",true);
HASH_SET(_newPOI,"isActive",true);

HASH_GET(GVAR(POI),"Locations") pushBack _newPOI;
