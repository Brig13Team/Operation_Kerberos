/*
    Author: Dorbedo
    Original Author: ACRE2 team (https://github.com/IDI-Systems/acre2)

    Description:
        collects all hashes and removes lost ones
        called via PFH

    Parameter(s):
        None

    Return
        None
*/
#include "script_component.hpp"

// init the collecting
If (DORB_HASH_COLLECTOR_NAMESPACES isEqualTo []) then {
    If (DORB_HASH_COLLECTOR_FOUND isEqualTo []) then {
        DORB_HASH_COLLECTOR_NAMESPACES = [missionNamespace] + allGroups;
        DORB_HASH_COLLECTOR_VARIABLES = (allVariables missionNamespace);
        DORB_HASH_COLLECTOR_ARRAYS = [];
        DORB_HASH_COLLECTOR_FOUND = [];
        DORB_HASH_COLLECTOR_ID = 0;
        DORB_HASH_COLLECTOR_NEXTEXEC = diag_tickTime + DORB_HASH_COLLECTOR_NEXTEXEC_DELAY;
        DORB_HASH_CREATED = DORB_HASH_CREATED append DORB_HASH_CREATED_NEW;
        DORB_HASH_CREATED_NEW = [];
    }else{
        //// deleting old hashes
        private _time = diag_ticktime + DORB_HASH_COLLECTOR_SEARCHTIME;
        while { (diag_ticktime < _time) && {DORB_HASH_COLLECTOR_ID < (count DORB_HASH_COLLECTOR_FOUND)}} do {
            private _hash = DORB_HASH_CREATED select DORB_HASH_COLLECTOR_ID;
            If !(_hash in DORB_HASH_COLLECTOR_FOUND) then {
                HASH_DELETE(_hash);
            };
            INC(DORB_HASH_COLLECTOR_ID);
        };
    };
};
private _time = diag_ticktime + DORB_HASH_COLLECTOR_SEARCHTIME;
while { (diag_ticktime < _time) && {!(DORB_HASH_COLLECTOR_NAMESPACES isEqualTo [])}} do {
    If (DORB_HASH_COLLECTOR_VARIABLES isEqualTo []) then {
        /// use the next namespace
        DORB_HASH_COLLECTOR_NAMESPACES deleteAt 0;
        if (count DORB_HASH_COLLECTOR_NAMESPACES > 0) then {
            DORB_HASH_COLLECTOR_VARIABLES = (allVariables (DORB_HASH_COLLECTOR_NAMESPACES select 0));
        }else{
            DORB_HASH_COLLECTOR_VARIABLES = [];
        };
    }else{
        private _variable = (DORB_HASH_COLLECTOR_VARIABLES deleteAt 0);
        If !((tolower _variable) in DORB_HASH_COLLECTOR_IGNORE) then {
            private _value = (DORB_HASH_COLLECTOR_NAMESPACES select 0) getVariable _variable;
            If (IS_HASH(_value)) then {
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
        If (IS_HASH(_x)) then {
            If !(_x in DORB_HASH_COLLECTOR_FOUND) then {
                DORB_HASH_COLLECTOR_NAMESPACES pushBackUnique _x;
                DORB_HASH_COLLECTOR_FOUND pushBack _value;
            };
        }else{
            If (IS_ARRAY(_value)) then {
                DORB_HASH_COLLECTOR_ARRAYS pushBack _x;
            };
        };
    } forEach (DORB_HASH_COLLECTOR_ARRAYS deleteAt 0);
};
