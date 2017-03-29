/*
 *  Author: Dorbedo
 *  Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)
 *
 *  Description:
 *      gathers all hashes and deletes old ones to release the used space
 *      global hashes are collected only where they are local.
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

// If the collecting is not in progress, exit and initialize the collecting (wait for the next call via PFH)
If ((DORB_HASH_COLLECTOR_NAMESPACES_ID >= (count DORB_HASH_COLLECTOR_NAMESPACES))&&{DORB_HASH_COLLECTOR_ARRAYS isEqualTo []}) exitWith {
    If (DORB_HASH_COLLECTOR_FOUND isEqualTo []) then {
        //start the collecting by initializing the variables
        DORB_HASH_COLLECTOR_NAMESPACES = [missionNamespace] + allGroups + allPlayers + (call FUNC(hash_getAllGlobal));
        DORB_HASH_COLLECTOR_NAMESPACES_ID = 0;
        DORB_HASH_COLLECTOR_VARIABLES = (allVariables missionNamespace);
        DORB_HASH_COLLECTOR_ARRAYS = [];
        DORB_HASH_COLLECTOR_FOUND = [];
        DORB_HASH_COLLECTOR_ID = 0;
        DORB_HASH_CREATED append DORB_HASH_CREATED_NEW;
        DORB_HASH_CREATED_NEW = [];
        // add the global hashes, ignore the hashes with a changed owner
        DORB_HASH_CREATED append (DORB_HASH_CREATED_NEW_GLOBAL select {local _x});
        DORB_HASH_CREATED_NEW_GLOBAL = [];
    }else{
        //// deleting old hashes
        private _time = diag_ticktime + DORB_HASH_COLLECTOR_SEARCHTIME;
        while { (diag_ticktime < _time) && {DORB_HASH_COLLECTOR_ID < (count DORB_HASH_CREATED)}} do {
            // moving through the created hashes and delete the hashes, if the are not found
            private _hash = DORB_HASH_CREATED select DORB_HASH_COLLECTOR_ID;
            If !(_hash in DORB_HASH_COLLECTOR_FOUND) then {
                // don't delete global hashes, if they are not local
                If !((IS_GHASH(_hash))&&{!local _x}) then {
                    HASH_DELETE(_hash);
                };
            };
            INC(DORB_HASH_COLLECTOR_ID);
        };
        If (DORB_HASH_COLLECTOR_ID >= (count DORB_HASH_CREATED)) then {
            DORB_HASH_CREATED = DORB_HASH_COLLECTOR_FOUND;
            DORB_HASH_COLLECTOR_FOUND = [];
            DORB_HASH_COLLECTOR_COLLECT = false;
        };
    };
};

// first check the namespaces for hashes
private _time = diag_ticktime + DORB_HASH_COLLECTOR_SEARCHTIME;
while { (diag_ticktime < _time) && {DORB_HASH_COLLECTOR_NAMESPACES_ID < (count DORB_HASH_COLLECTOR_NAMESPACES)}} do {
    // get the variables from the namespace
    If (DORB_HASH_COLLECTOR_VARIABLES isEqualTo []) then {
        /// use the next namespace
        INC(DORB_HASH_COLLECTOR_NAMESPACES_ID);
        if (DORB_HASH_COLLECTOR_NAMESPACES_ID < (count DORB_HASH_COLLECTOR_NAMESPACES)) then {
            DORB_HASH_COLLECTOR_VARIABLES = (allVariables (DORB_HASH_COLLECTOR_NAMESPACES select DORB_HASH_COLLECTOR_NAMESPACES_ID));
        }else{
            DORB_HASH_COLLECTOR_VARIABLES = [];
        };
    }else{
    // if there are some variables to check, check them
        private _variable = (DORB_HASH_COLLECTOR_VARIABLES deleteAt 0);
        // prevent endless looping by ignoring the internal variables
        If !((tolower _variable) in DORB_HASH_COLLECTOR_IGNORE) then {
            private _value = (DORB_HASH_COLLECTOR_NAMESPACES select DORB_HASH_COLLECTOR_NAMESPACES_ID) getVariable _variable;
            If (IS_AHASH(_value)) then {
                If !(_value in DORB_HASH_COLLECTOR_FOUND) then {
                    DORB_HASH_COLLECTOR_NAMESPACES pushBackUnique _value;
                    DORB_HASH_COLLECTOR_FOUND pushBack _value;
                };
            }else{
                If (IS_ARRAY(_value)) then {
                    DORB_HASH_COLLECTOR_ARRAYS pushBack _value;
                };
            };
        };
    };
};
private _time = diag_ticktime + DORB_HASH_COLLECTOR_SEARCHTIME;
while { (diag_ticktime < _time)&&{!(DORB_HASH_COLLECTOR_ARRAYS isEqualTo [])}} do {
    {
        If (IS_AHASH(_x)) then {
            If !(_x in DORB_HASH_COLLECTOR_FOUND) then {
                DORB_HASH_COLLECTOR_NAMESPACES pushBackUnique _x;
                DORB_HASH_COLLECTOR_FOUND pushBack _value;
            };
        }else{
            If (IS_ARRAY(_value)) then {
                DORB_HASH_COLLECTOR_ARRAYS pushBack _x;
            };
        };
        nil;
    } count (DORB_HASH_COLLECTOR_ARRAYS deleteAt 0);
};
