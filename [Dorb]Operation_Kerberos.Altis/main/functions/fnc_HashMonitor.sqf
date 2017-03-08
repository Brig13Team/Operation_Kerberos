/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      Monitors the Hash-Pool and the deletion of hashes
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If !(DORB_HASH_TO_DELETE isEqualTo []) then {
    private _time = diag_tickTime;
    while {((diag_tickTime - _time)<0.2)&&((count DORB_HASH_TO_DELETE) > 0)} do {
        deleteLocation (DORB_HASH_TO_DELETE deleteAt 0);
        DORB_HASH_SYS_CREATE(_newHash);
        DORB_HASH_POOL pushBack _newHash;
    };
};
If ((count DORB_HASH_POOL) <= 100) then {
    For "_i" from 0 to 10 do {
        DORB_HASH_SYS_CREATE(_newHash);
        DORB_HASH_POOL pushBack _newHash;
    };
};
