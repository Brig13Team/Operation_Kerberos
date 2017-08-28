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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

CHECK(!GVAR(active))

private _radars = HASH_GET(GVAR(radars),"objects");
_radars select {alive _x;};
HASH_SET(GVAR(radars),"objects",_radars);
CHECK(_radars isEqualTo [])

private _possibleTargets = allPlayers select {
    (alive _x)&&
    {side _x == GVARMAIN(playerside)}&&
    {!(vehicle _x == _x)}&&
    {!((vehicle _x)isKindOf "ParachuteBase")}&&
    {(vehicle _x)isKindOf "Plane"}&&
    {isTouchingGround (vehicle _x)}
};
_possibleTargets append (allUnitsUAV select {
    (alive _x)&&
    {_x isKindOf "Plane"}&&
    {side _x == GVARMAIN(playerside)}
    });
//TRACEV_1(_possibleTargets);
private _targets = [];
{
    private _radarpos = _x getVariable [QGVAR(radarpos),(getPosASL _x) vectorAdd [0,0,3]];
    {
        if (
                (((getPos _x) distance _radarpos) < 7000)&&
                {(!(terrainIntersectASL[_radarpos,(getPosASL _x)]))}
            ) then {
            _targets pushBackUnique _x;
        };
    } forEach _possibleTargets;
} forEach _radars;

{
    _x params ["_curTarget","_lastSeen"];
    If (
        ((side _curTarget) == GVARMAIN(playerside))&&
        {_curTarget isKindOf "Air"}&&
        {!isTouchingGround _curTarget}&&
        {_lastSeen < 30}
        ) then {
            _targets pushBackUnique _curTarget;
    };
} forEach (listRemoteTargets GVARMAIN(side));

HASH_SET(GVAR(radars),"targets",_targets);
