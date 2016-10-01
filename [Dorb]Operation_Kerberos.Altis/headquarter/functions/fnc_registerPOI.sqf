/*
    Author: Dorbedo

    Description:
        registers a Point of interest

    Parameter(s):
        0:OBJECT/POSITION    - the position to be defended

    Returns:
        BOOL
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

HASH_GET(GVAR(POI),"Positions") pushBack _newPOI;
