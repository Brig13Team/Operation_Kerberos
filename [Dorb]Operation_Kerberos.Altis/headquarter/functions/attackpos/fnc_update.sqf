/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates an attacklocation with the current values. Evaluates, if there is still
 *
 *  Parameter(s):
 *      0 : LOCATION - The attackposition
 *      1 : SCALAR - the dz value
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_attackLoc",locationNull,[locationNull]],["_dzValue",-1,[0]]];
TRACEV_2(_attackLoc,_dzValue);
CHECK((isNull _attackLoc))

private _enemygroups = [];
private _enemyValue = [0];
private _enemyStrenght = [[0,0,0]];
private _enemyDefence = [[0,0,0]];
private _enemyType = [0,0,0];

{
    private _grouphash = _x;
    private _currentGroup = HASH_GET_DEF(_grouphash,"group",grpNull);
    If !(isNull _currentGroup) then {
        private _groupIsInside =
            0<{
                ((getPos _x) in _attackLoc)
                &&{(GVARMAIN(side) knowsAbout _x)>1.4}
            }count (units _currentGroup);

        If (_groupIsInside) then {
            _enemygroups pushBackUnique _currentGroup;

            _enemyValue pushBack HASH_GET(_grouphash,"value");
            _enemyStrenght pushBack HASH_GET(_grouphash,"strenght");
            _enemyDefence pushBack HASH_GET(_grouphash,"defence");
            _enemyType set [HASH_GET(_grouphash,"type"),1];
        };
    };
} count HASH_GET_DEF(GVAR(groups),"playergroups",[]);

private _enemyValue = [_enemyValue] call EFUNC(common,arraySum);
private _enemyStrenght = [_enemyStrenght] call EFUNC(common,arraysGetMax);
private _enemyDefence = [_enemyDefence] call EFUNC(common,arraysGetMax);

If (_enemygroups isEqualTo []) exitWith {
    TRACE("Deleting Attackpos");
    [_attackLoc] call FUNC(attackpos_delete);
};

If (_dzValue < 0) then {
    private _key = [getPos _attackLoc] call FUNC(dzConvert);
    private _dzHash = HASH_GET(GVAR(dangerzones),_key);
    If (!isNil "_dzHash") then {
        _dzValue = DZVALUEMOD(HASH_GET_DEF(_dzHash,"enemystrength",0));
    }else{
        _dzValue = 0;
    };
};

private _enemyValue = _enemyValue + _dzValue * ([] call FUNC(getDZCoeff));

TRACEV_8(_attackLoc,locationPosition _attackLoc,_dzValue,_enemygroups,_enemyValue,_enemyStrenght,_enemyDefence,_enemyType);
HASH_SET(_attackLoc,"enemygroups",_enemygroups);
HASH_SET(_attackLoc,"enemyvalue",_enemyValue);
HASH_SET(_attackLoc,"enemystrenght",_enemyStrenght);
HASH_SET(_attackLoc,"enemydefence",_enemyDefence);
HASH_SET(_attackLoc,"enemytype",_enemyType);
