/*
 *  Author: Dorbedo
 *
 *  Description:
 *      unit can copy the loadout
 *
 *  Parameter(s):
 *      0 : OBJECT - target
 *
 *  Returns:
 *      BOOL - player is allowd to copy the loadout
 *
 */
#include "script_component.hpp"

params [["_target", objNull, [objNull]]];
If ((isNull _target)/*||{!isPlayer _target}*/) exitWith {false};

If !((vehicle ace_player == ace_player)&&(vehicle _target == _target)&&(side ace_player == side _target)) exitWith {false};

If (_target getVariable [QEGVAR(gui_arsenal,ArsenalIsOpened),false]) exitWith {false};

(
    {
        ((!(_x isEqualTo [0,0,0]))&&{(ace_player distance2D _x) < 30})
    } count [getMarkerPos GVARMAIN(respawnMarker),getMarkerPos "respawn_west_land"]
)>0
