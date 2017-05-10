/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Transports a group into the area
 *
 *  Parameter(s):
 *      0 : GROUP - the transporter Group
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_group"];

private _isAir = (vehicle (leader _group)) isKindOf "Air";

private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");
private _droppoint = [_centerpos,200,0] call EFUNC(common,pos_random);

If (_isAir) then {
    [_group] call CBA_fnc_clearWaypoints;
    [_group, [_droppoint], 25, "UNLOAD", "CARELESS", "BLUE", "FULL", "NO CHANGE", "", [1,3,5], 50] call FUNC(waypoints_add);
} else {
    private _waypoints = [getPos (leader _group),_droppoint] call FUNC(waypoints_generate);
    [_group] call CBA_fnc_clearWaypoints;
    [_group, _waypoints, 25, "MOVE", "CARELESS", "BLUE", "FULL", "NO CHANGE", "", [1,3,5], 50] call FUNC(waypoints_add);
    [_group, [_droppoint], 25, "UNLOAD", "CARELESS", "BLUE", "FULL", "NO CHANGE", "", [1,3,5], 50] call FUNC(waypoints_add);
};
