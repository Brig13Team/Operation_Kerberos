/*
    Author: Dorbedo

    Description:
        creates a hash

    Parameter(s):
        None

    Return
        None
*/
#include "script_component.hpp"

if ((count DORB_HASH_POOL) > 0) exitWith {
    private _return = (DORB_HASH_POOL deleteAt 0);
    DORB_HASH_CREATED_NEW pushBack _return;
    _return;
};
DORB_HASH_SYS_CREATE(_return);
_return;
