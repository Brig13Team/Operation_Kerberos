/*
 * (old file)
 *
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "SCARAB" : Conditional Function
 *
 *  Parameter(s):
 *      0 : ARRAY - SCARAB-Objects
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params [["_scarabs",[],[[]]]];

private _activeScarabs = {
    (!isNull _x )&&
    (alive gunner _x)&&
    (alive _x)
} count _scarabs;

If !(count _scarabs == _activeScarabs) exitWIth { "Failed" };

If (CBA_MissionTime > GVAR(timer)) exitWIth {
    {
        private _abschussrampe = _x;
        private _dir = getDir _abschussrampe;
        private _zielpos = [_abschussrampe, 20000, _dir] call BIS_fnc_relPos;
        [_abschussrampe,_zielpos] call rhs_fnc_ss21_AI_launch;
    } forEach _scarabs;
    "Failed"
};

If ((CBA_MissionTime > (GVAR(timer)- 300))&&(GVAR(scarab_waiting))) then {
    GVAR(scarab_waiting) = false;
    {[_x,1] spawn rhs_fnc_ss21_AI_prepare;} forEach _scarabs;
};
""
