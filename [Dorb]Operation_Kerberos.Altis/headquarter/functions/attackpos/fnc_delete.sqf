/*
 *  Author: Dorbedo
 *
 *  Description:
 *      deletes an attacklocation
 *
 *  Parameter(s):
 *      0 : LOCATION - the attacklocation to delete
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_location",locationNull,[locationNull]]];
TRACEV_1(_location);
CHECK(isNull _location)

private _allAttackpos = HASH_GET(GVAR(attackPos),"locations");
[_location] call FUNC(attackpos_reduce);
_allAttackpos = _allAttackpos - [_location];
HASH_SET(GVAR(attackPos),"locations",_allAttackpos);
HASH_DELETE(_location);
