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
        // no strategie is working
        If !(({[_x] call FUNC(strategy__checkisworking);}count _strategys)>0) then {
            TRACE("No more working Strategies");
            HASH_SET(_attackLocation,"strategies",[]);
            _return pushBack _attackLocation;
        }else{
            // check if the enemy got reinforements and add additional strategies
            private _stratValArray = [0,0,0];
            {
                    private _curStratName = HASH_GET(_x,"strategytype");
                    private _type = getArray(missionConfigFile >> "strategy" >> _curStratName >> "type");
                    private _value = getNumber(missionConfigFile >> "strategy" >> _curStratName >> "value");
                    _stratValArray = [((_type select 0) * _value),((_type select 1) * _value),((_type select 2) * _value)];
            } forEach _strategys;
            private _attackLocValArray = HASH_GET(_attackLocation,"enemyvalue");

            private _update = (((_stratValArray select 0) < ((_attackLocValArray select 0)*0.85))||
                ((_stratValArray select 1) < ((_attackLocValArray select 1)*0.85))||
                ((_stratValArray select 2) < ((_attackLocValArray select 2)*0.85)));



            // if the difference is bigger then 15%, add more strategies
            If (_update) then {
                private _temp = [
                    ((_attackLocValArray select 0) - (_stratValArray select 0)) max 0,
                    ((_attackLocValArray select 1) - (_stratValArray select 1)) max 0,
                    ((_attackLocValArray select 2) - (_stratValArray select 2)) max 0
                ];
                [_attackLocation,true,_temp] call FUNC(strategy__choose);
            };
        };
    };
    private _enemygroups = HASH_GET_DEF(_attackLocation,"enemygroups",[]);
    If (_enemygroups isEqualTo []) exitWith {[_attackLocation] call FUNC(attackpos_delete);};
} forEach HASH_GET(GVAR(attackpos),"Locations");





_return;
