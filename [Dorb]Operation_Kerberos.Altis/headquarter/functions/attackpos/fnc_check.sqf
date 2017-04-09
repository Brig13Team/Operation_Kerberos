/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns the attacklocations which need strategies
 *      removes delete strategies
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      ARRAY - Array of attaclocations which need new strategies
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _return = [];

{
    private _attackLocation = _x;
    private _CompleteTest = false;
    private _strategys = HASH_GET_DEF(_attackLocation,"strategies",[]);

    // evaluate if the strategies are still working
    private _workingStrategiesCount = {[_x] call FUNC(strategy__checkisworking);}count _strategys;
    // remove finished strategies
    _strategys = _strategys - [locationNull];
    HASH_SET(_attackLocation,"strategies",_strategys);

    If (_strategys isEqualTo []) then {
        // the array is empty -> no strategies were chosen
        _return pushBack _attackLocation;
    }else{
        // update the attacklocation
        [_attackLocation] call FUNC(attackpos_update);

        // check if there is a need for additional strategies (some strategies have failed or have been fought back)
        private _stratValArray = [0,0,0];
        {
                private _curStratName = HASH_GET(_x,"strategytype");
                private _type = getArray(missionConfigFile >> "strategy" >> _curStratName >> "type");
                private _value = getNumber(missionConfigFile >> "strategy" >> _curStratName >> "value");
                _stratValArray = [((_type select 0) * _value),((_type select 1) * _value),((_type select 2) * _value)];
        } forEach _strategys;
        private _attackLocValArray = HASH_GET(_attackLocation,"enemyvalue");

        // if the difference is bigger then 15%, add more strategies
        private _update = (((_stratValArray select 0) < ((_attackLocValArray select 0)*0.85))||
            ((_stratValArray select 1) < ((_attackLocValArray select 1)*0.85))||
            ((_stratValArray select 2) < ((_attackLocValArray select 2)*0.85)));
        If (_update) then {
            private _temp = [
                ((_attackLocValArray select 0) - (_stratValArray select 0)) max 0,
                ((_attackLocValArray select 1) - (_stratValArray select 1)) max 0,
                ((_attackLocValArray select 2) - (_stratValArray select 2)) max 0
            ];
            TRACEV_2(_attackLocation,_temp);
            [_attackLocation,true,_temp] call FUNC(strategy__choose);
        };
    };
} forEach HASH_GET(GVAR(attackpos),"Locations");

_return;
