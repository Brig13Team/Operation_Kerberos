/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onTransitionEvent is called if defined
 *
 *  Parameter(s):
 *      0 : LOCATION - the mission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _eventName = format["on%1",_thisTransition];
private _value = _mission getVariable _eventName;
TRACEV_3(_eventName,_value,typename _value);
If (!isNil "_value") then {
    If (IS_CODE(_value)) exitWith {
        _this call _value;
    };
    If (IS_STRING(_value)) then {
        _this call (missionNamespace getVariable _value);
    };
};
