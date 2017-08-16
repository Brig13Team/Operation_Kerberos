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
        private _oldHash = (DORB_HASH_TO_DELETE deleteAt 0);
        If (_oldHash isEqualType locationNull) then {
            deleteLocation _oldHash;
            private _newHash = DORB_HASH_SYS_CREATE_LOCAL;
            DORB_HASH_POOL pushBack _newHash;
        }else{
            deleteVehicle _oldHash;
        };
    };
};

If ((count DORB_HASH_POOL) <= 100) then {
    For "_i" from 0 to 100 do {
        private _newHash = DORB_HASH_SYS_CREATE_LOCAL;
        DORB_HASH_POOL pushBack _newHash;
    };
    If ((count DORB_HASH_CREATED_NEW) > ((count DORB_HASH_CREATED) * 0.05)) then {
        DORB_HASH_COLLECTOR_COLLECT = true;
    };
};

If ((count DORB_HASH_CREATED_NEW_GLOBAL) > ([10,50] select isServer)) then {
    DORB_HASH_COLLECTOR_COLLECT = true;
};
