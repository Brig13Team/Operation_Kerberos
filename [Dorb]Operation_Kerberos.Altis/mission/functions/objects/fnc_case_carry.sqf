/*
    Author: Dorbedo
    
    Description:
        init function
    
*/
#include "script_component.hpp"
SCRIPT(carry);

CHECK(!hasinterface)

params["_suitcase","_carrier"];

_carrier action ["SwitchWeapon", _carrier, _carrier, 100];

uiSleep ANIM_TIME;

_suitcase attachTo [_carrier, ATTACH_POINT, "RightHand"];
_suitcase setDir 90;
_carrier forceWalk true;

_suitcase setVariable [QGVAR(objects_carrier),_carrier,true];
_carrier setVariable [QGVAR(objects_suitcase),_suitcase];

If (isMultiplayer) then {
    [{
        params ["_suitcase"];
        [{_this call FUNC(objects_handle); }, 1, [_suitcase]] call CBA_fnc_addPerFrameHandler;
    }, [_suitcase],0] call EFUNC(common,globalExec);
}else{
    [{_this call FUNC(objects_handle); }, 1, [_suitcase]] call CBA_fnc_addPerFrameHandler;
};