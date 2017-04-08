/*
 *  Author: Dorbedo
 *
 *  Description:
 *      creates an attackposition
 *
 *  Parameter(s):
 *      0 : ARRAY - attackposition
 *
 *  Returns:
 *      LOCATION - the attacklocation wich was created
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_position",[],[[]],[2,3]]];

CHECK(_position isEqualTo [])

private _centerpos = HASH_GET(GVAR(dangerzones),"centerpos");
private _distance = HASH_GET(GVAR(dangerzones),"distance");
If ((_position distance2d _centerPos)>(_distance * 1.4)) exitWith {};

// check if there is already an attackposition if there is one, exit
private _attackLoc = [_position] call FUNC(attackpos_atPosition);
CHECK(!isNull _attackLoc)

_attackLoc = HASH_CREATE;
// add the hash to the dump to prevent the loosing because of the changed locationPosition
EGVAR(spawn,cleanUpDump) pushBack _attackLoc;
HASH_GET(GVAR(attackpos),"Locations") pushBack _attackLoc;

// cover all sorrounding Dangerzones
private _size = (HASH_GET(GVAR(dangerzones),"gridsize")) * 1.1;
_attackLoc setPosition _position;
_attackLoc setSize [_size,_size];
_attackLoc setRectangular true;
// prevent registration as POI
HASH_SET(_attackLoc,"isPOI",false);


#ifdef DEBUG_MODE_FULL
    [_position,"AttackPosition","ColorRed","mil_flag"] call EFUNC(common,debug_marker_create);
#endif

HASH_SET(_attackLoc,"strategies",[]);
HASH_SET(_attackLoc,"enemygroups",[]);
HASH_SET(_attackLoc,"enemytype",[ARR_3(0,0,0)]);
HASH_SET(_attackLoc,"enemyvalue",[ARR_3(0,0,0)]);
HASH_SET(_attackLoc,"enemythreat",[ARR_3(0,0,0)]);

// register the playergroups
// TODO - register only know groups and maybe spare the airunits
private _allGroups = [];
{
    If ((getPos _x) in _attackLoc) then {
        _allGroups pushBackUnique (group _x);
    };
    nil
} count allPlayers;
{
    [_attackLoc,_x] call FUNC(attackpos_add);
    nil
} count _allGroups;

_attackLoc;
