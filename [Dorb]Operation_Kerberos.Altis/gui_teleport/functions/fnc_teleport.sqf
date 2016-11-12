/*
 *  Author: Dorbedo
 *
 *  Description:
 *      teleports a player to a position
 *
 *  Parameter(s):
 *      0 : ARRAY - Targetposition
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
#include "script_component.hpp"
_this params ["_button"];

private _hash = HASH_GET(GVAR(teleporter),_button);
CHECK(isNil "_hash")

private _isActive = HASH_GET(_hash,"active");
CHECK(isNil "_isActive")
If !(call {_isActive}) exitWith {
    [localize LSTRING(teleporter),localize LSTRING(DEACTIVATED)] call EFUNC(gui,message);
};

private _target = HASH_GET(_hash,"target");
CHECK(isNil "_target")

If (IS_ARRAY(_target)) exitWith {
    CHECK(_target isEqualTo [])
    closeDialog IDD_TELEPORT_DLG;
    [] call EFUNC(gui_tablet,close);
    player setPosASL _target;
};
If (IS_CODE(_target)) then {
    [] spawn _target;
};
