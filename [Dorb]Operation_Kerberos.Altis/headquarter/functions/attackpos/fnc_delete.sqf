/*
    Author: Dorbedo

    Description:
        deletes an attackpos;

    Parameter(s):
        0:LOCATION - Attackposition

    Returns:
        BOOL
*/
#include "script_component.hpp"

_this params [["_location",locationNull,[locationNull]]];

private _allAttackpos = HASH_GET(GVAR(attackPos),"locations");
_allAttackpos = _allAttackpos - [_location];
HASH_SET(GVAR(attackPos),"locations",_allAttackpos);
