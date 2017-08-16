/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if a mission is active
 *
 *  Parameter(s):
 *      0 : LOCATION - the mission
 *
 *  Returns:
 *      BOOL - the mission is active
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_mission",locationNull,[locationNull]]];

private _progress = _mission getVariable ["progress","none"];
!((isNull _mission)||{_progress in ["cancel","succeeded","neutral","failed"]})
