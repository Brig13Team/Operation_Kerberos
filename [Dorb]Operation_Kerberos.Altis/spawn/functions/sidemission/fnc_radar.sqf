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


private _positions = ([(_locationArray select 1),"isObjective",1,_distance] call FUNC(createMissionComposition)) select 0;
private _chosenPos = selectRandom _positions;

private _radarType = ["radar"] call FUNC(getMissionObject);

private _return = [_chosenPos,createGroup GVARMAIN(side),_radarType] call FUNC(vehicle);

[(_return select 1)];
