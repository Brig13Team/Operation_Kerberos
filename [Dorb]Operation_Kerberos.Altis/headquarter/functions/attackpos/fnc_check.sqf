/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the attackpositions wich need
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - the attackpositions wich need a new strategy
 *
 */
#include "script_component.hpp"

private _return = [];

{
    private _hash = _x;
    private _strategys = HASH_GET_DEF(_hash,"strategies",[]);
    If (_strategys isEqualTo []) then {
        _return pushBack _hash;
    }else{
        If !(({[_x] call FUNC(strategy_checkisworking);}count _strategys)>0) then {
            HASH_SET(_hash,"strategies",[]);
            _return pushBack _hash;
        };
    };
} forEach HASH_GET(GVAR(attackpos),"Locations");





_return;
