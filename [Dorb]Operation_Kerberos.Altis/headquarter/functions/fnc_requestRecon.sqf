/*
 *  Author: Dorbedo
 *
 *  Description:
 *      execuetes the request for recon
 *
 *  Parameter(s):
 *      0 : POSITION/OBJECT - Position or Object where to recon
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_target",[],[[],objNull],[2,3]]];
If (IS_OBJECT(_target)) then {_target = getPosASL _target;};

/*
 *  Not implemented for now
 */
