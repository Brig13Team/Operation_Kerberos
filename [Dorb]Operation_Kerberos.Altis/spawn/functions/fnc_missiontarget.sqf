/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the predefinied Missiontargets
 *
 *  Parameter(s):
 *      0 : ARRAY - The Centerposition
 *      1 : STRING - Type of Maintarget
 *      2 : ANY - Parameter
 *
 *  Returns:
 *      ARRAY - Array with the missionobjects -empty if no valid position was availible
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_missiontype","",[""]],["_parameter",[]]];
CHECK((_centerposition isEqualTo [])||(_missiontype isEqualTo ""))

private _functionname = format[QFUNC(mission_%1),_missiontype];

If (isNil _functionname) exitWith {[]};

_parameter call _functionname;
