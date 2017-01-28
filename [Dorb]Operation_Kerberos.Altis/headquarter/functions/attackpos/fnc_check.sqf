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
    private _attackLocation = _x;
    private _strategys = HASH_GET_DEF(_attackLocation,"strategies",[]);
    If (_strategys isEqualTo []) then {
        _return pushBack _attackLocation;
    }else{
        If !(({[_x] call FUNC(strategy__checkisworking);}count _strategys)>0) then {
            TRACE("No more working Strategies");
            HASH_SET(_attackLocation,"strategies",[]);
            _return pushBack _attackLocation;
        };
    };
} forEach HASH_GET(GVAR(attackpos),"Locations");





_return;
