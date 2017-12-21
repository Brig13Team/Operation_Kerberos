/**
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
        private _stratValue = 0;
        {
                _stratValue = _stratValue + HASH_GET_DEF(_x,"value",0);
        } forEach _strategys;
        private _attackLocValue = HASH_GET_DEF(_attackLocation,"enemyvalue",0);

        // if the difference is bigger then 15%, add more strategies
        If (_stratValue < (_attackLocValue * 0.85)) then {
            private _temp = _attackLocValue - _stratValue;
            TRACEV_2(_attackLocation,_temp);
            [_attackLocation,true,_temp] call FUNC(strategy__choose);
        };
    };
} forEach HASH_GET_DEF(GVAR(attackpos),"Locations",[]);

_return;
