/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sends a unit on a patrol around the Center
 *
 *  Parameter(s):
 *      0 : GROUP - the group on patrol
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];


private _center = _this getVariable ["target",locationNull];

If (isNull _center) then {
    _center = (HASH_GET_DEF(GVAR(POI),"Locations",[])) select {!isNull _x};
    if (_center isEqualTo []) then {
        _this setVariable ["state","combat"];
        _this setVariable ["target",locationNull];
    }else{
        _center = selectRandom _center;
        _this setVariable ["target",_center];
        _center = locationPosition _center;
    };
}else{
    _center = locationPosition _center;
};
private _distance = 250;
TRACEV_3(_group,_center,_distance);
//[_group,_center,_distance, 5, "MOVE", "AWARE", "WHITE", "LIMITED", selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"], "", [5,10,15],50] call CBA_fnc_taskPatrol;
[_group, _center, _distance, "MOVE", "AWARE", "WHITE", "LIMITED", selectRandom ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"], "", [5,10,15],50] call FUNC(statemachine_patrolTask);
