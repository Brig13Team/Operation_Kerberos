/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks if the POI are destroyed an removes if this is the case
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

{
    private _curLoc = _x;
    private _IsstillDefended = ({ (side _x == GVARMAIN(side))&&{_x in _curLoc}} count allUnits) > 2;
    If !(_IsstillDefended) then {
        HASH_DELETE(_curLoc);
    };
} forEach HASH_GET(GVAR(POI),"Locations");

private _allPOI = HASH_GET(GVAR(POI),"Locations") - [locationNull];
HASH_SET(GVAR(POI),"locations",_allPOI);
