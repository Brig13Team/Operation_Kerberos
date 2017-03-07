/*
 *  Author: iJesuz
 *
 *  Description:
 *      Sidemission "Radar"
 *
 *  Parameter(s):
 *      0 : ARRAY       - position
 *      1 : [NUMBER]    - [radius]
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_radius",500,[0]]];
TRACEV_3(_centerposition,_parameter,_radius);

private _targetPositions = [_centerposition,["radar","isObjective"],1,_radius] call FUNC(createMissionComposition);
private _targetPos = selectRandom (_targetPositions select 0);
private _obj = ["radar"] call FUNC(getMissionObject);
TRACEV_3(_targetPositions,_targetPos,_obj);

private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];
_targetPos set [2,0];
_curTarget setPosATL _targetPos;
If !(isNil QEFUNC(headquarter,registerPOI)) then {
    [_curTarget] call EFUNC(headquarter,registerPOI);
};

[_curTarget]
