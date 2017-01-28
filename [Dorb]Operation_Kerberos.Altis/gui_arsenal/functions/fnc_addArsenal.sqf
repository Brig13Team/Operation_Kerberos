/*
    Author: Dorbedo

    Description:
        adds Arsenal to a unit
        can be called via unit-init
*/

#include "script_component.hpp"
SCRIPT(addArsenal);
_this params [["_target",objNull,[objNull]]];
CHECK((isNull _target)||(!(local _target)))

CHECK(!hasInterface)
If (GVAR(fullArsenal)) then {
    [_target,false] call FUNC(addArsenalAction);
}else{
    [_target,GVARMAIN(playerside),true] call FUNC(addSideRestrictedArsenal);
};
