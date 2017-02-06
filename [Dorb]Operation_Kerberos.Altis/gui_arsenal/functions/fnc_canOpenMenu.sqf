/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if the player can open the menu
 *
 *  Parameter(s):
 *      0 : OBJECT - player
 *
 *  Returns:
 *      BOOL - is allowed to open the list
 *
 */
#include "script_component.hpp"
_this params [["_player",objNull,[objNull]]];

If ((isNull _player)||(!(isPlayer _player))) exitWith {
    TRACE("player != player");
    false;
};
If !(vehicle _player == _player) exitWith {
    TRACE("vehicle player != player");
    false;
};

private _spawnpositions = GVAR(allowedPositions);
{
    _spawnpositions pushBack (getPos _x);
} forEach (missionnamespace getvariable [QGVAR(arsenal_boxes),[]]);

If ((isNil "_spawnpositions")) exitWith {
    TRACE("spawnposition == nil||null");
    false;
};

If !(_spawnpositions isEqualTypeAll []) exitWith {
    TRACE("allowedPositions - array is corrupt");
    false;
};

(
    {
        If ((_x isEqualTypeAll 0)&&{count _x >1}) then {
            (_player distance2D _x)< GVAR(allowedradius);
        }else{
            TRACE("allowedPositions - _x is not a position");
            false;
        };
    }count GVAR(allowedPositions)
) > 0;
