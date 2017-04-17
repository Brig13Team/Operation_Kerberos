/**
 *  Author: Dorbedo
 *
 *  Description:
 *      Checks the radars and registers the possible targets
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

CHECK(!GVAR(active))

private _radars = HASH_GET(GVAR(radars),"objects");
_radars select {alive _x;};
HASH_SET(GVAR(radars),"objects",_radars);
CHECK(_radars isEqualTo [])

private _possibleTargets = allPlayers select {
    (alive _x)&&
    {!(vehicle _x == _x)}&&
    {!((vehicle _x)isKindOf "ParachuteBase")}&&
    {(vehicle _x)isKindOf "Plane"}&&
    {isTouchingGround (vehicle _x)}
};
_possibleTargets append (allUnitsUAV select {
    (alive _x)&&
    (_x isKindOf "Plane")&&
    (side _x == GVARMAIN(playerside))
    });

private _targets = [];
{
    private _radarpos = (getPosASL _x);
    private _radar = _x;
    _radarpos set [2,(_radarpos select 2)+2];
    {
        if (
                (((getPos _x) distance _radarpos) < 5000)&&
                {(!(lineintersects[_radarpos,(getPosASL _x),_radar,_x]))}
            ) then {
            _targets pushBack _x;
        };
    } forEach _possibleTargets;
} forEach _allRadars;

HASH_SET(GVAR(radars),"targets",_targets);
