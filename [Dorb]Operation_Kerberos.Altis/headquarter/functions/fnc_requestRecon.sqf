/*
    Author: Dorbedo

    Description:
        request a recon

    Parameter(s):
        none

    Returns:
        none

*/
#include "script_component.hpp"
_this params [["_target",[],[[],objNull],[2,3]]];
If (IS_OBJECT(_target)) then {_target = getPosASL _target;};
