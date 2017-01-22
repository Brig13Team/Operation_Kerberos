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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_locationArray",[],[[]]],["_distance",500,[0]]];

private _positions = ["artillery"] call FUNC(createMissionComposition);

private _typeRand = floor (random 2);
private _objectType = switch (_typeRand) do {
    default {"artillery"};
    case 1 : {"rockets"};
};

private _allTargets = [];
{
    private _targetType = [_objectType] call FUNC(getMissionObject);
    private _return = [_chosenPos,createGroup GVARMAIN(side),_radarType] call FUNC(vehicle);
    _allTargets pushBack (_return select 1);
} forEach _positions;

_allTargets;
