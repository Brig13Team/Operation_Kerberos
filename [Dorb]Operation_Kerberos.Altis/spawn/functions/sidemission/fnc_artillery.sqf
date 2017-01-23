/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Sidemission
 *
 *  Parameter(s):
 *      0 : ARRAY - Location array
 *      1 : SCALAR - Distance
 *
 *  Returns:
 *      ARRAY - params for condition-check
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_locationArray",[],[[]]],["_distance",500,[0]]];

private _positions = ([(_locationArray select 1),"artillery",1,_distance] call FUNC(createMissionComposition)) select 0;
TRACEV_1(_positions);
private _typeRand = floor (random 2);
private _objectType = switch (_typeRand) do {
    default {"artillery"};
    //case 1 : {"rockets"}; -> bm-21 can't shoot more then 4000m with commandArtilleryFire (RHS 0.4.2)
};

private _allTargets = [];
{
    private _targetType = [_objectType] call FUNC(getMissionObject);
    private _return = [_x,createGroup GVARMAIN(side),_targetType] call FUNC(vehicle);
    TRACEV_4(_x,createGroup GVARMAIN(side),_targetType,_return);
    [(_return select 1)] call EFUNC(headquarter,fdc_register);
    _allTargets pushBack (_return select 1);
} forEach _positions;

_allTargets;
