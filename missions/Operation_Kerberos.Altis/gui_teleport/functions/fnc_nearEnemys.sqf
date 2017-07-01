/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if there are Enemys near a position
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *
 *  Returns:
 *      BOOL - True if there are enemys near
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_pos",[],[[]],[3]]];
If (_pos isEqualTo []) exitWith {false};


(
    {
        (side _x == GVARMAIN(side))&&
        {(_x distance2D _pos)<3000}
    } count allUnits
)>0
