/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      creates a hash
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      LOCATION - Created Hash
 *
 */
#include "script_component.hpp"

if ((count DORB_HASH_POOL) > 0) exitWith {
    private _return = (DORB_HASH_POOL deleteAt 0);
    DORB_HASH_CREATED_NEW pushBack _return;
    _return;
};
private _return = DORB_HASH_SYS_CREATE_LOCAL;
DORB_HASH_CREATED_NEW pushBack _return;
_return;
