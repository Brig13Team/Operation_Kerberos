/**
 *  Author: Dorbedo
 *
 *  Description:
 *      handles when a ai unit gets killed
 *      add a value to the dangerzone
 *
 *  Parameter(s):
 *      0 : OBJECT - Unit which got killed
 *      1 : OBJECT - Killer
 *      2 : OBJECT - Unit who pulled the Trigger
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_OFF
#include "script_component.hpp"

_this params ["_killedUnit","_killer","_instigator"];

private _key = [(getPos _killer)] call FUNC(dzconvert);
CHECK(_key isEqualTo "") // not in the area

/*
// register the enemy
//private _StrengthValue = ([_killer] call FUNC(strengthPlayer));
private _killergroup = [_killer] call CBA_fnc_getGroup;
private _StrengthValue = 0;

private _grouphash = _killergroup getVariable QGVAR(grouphash);
If (!isNil "_grouphash") then {
    _StrengthValue = HASH_GET_DEF(_grouphash,"value",0);
};
*/
private _StrengthValue = ([typeOf _killedUnit] call FUNC(getCost))* (missionNamespace getVariable [QGVAR(UnitKilledCoeff),1]);
//TRACEV_3(_StrengthValue,_killergroup,_grouphash);
private _keyX = parsenumber ((_key splitString "_") select 0);
private _keyY = parsenumber ((_key splitString "_") select 1);
private _gridsize = HASH_GET(GVAR(dangerzones),"gridsize");
private _distance = HASH_GET(GVAR(dangerzones),"distance");

private _maxKey = _distance * 2;
TRACEV_4(_StrengthValue,_keyX,_keyY,_maxKey);
{
    _x params ["_tempkeyX","_tempkeyY","_value"];
    //TRACEV_4(_tempkeyX,_tempkeyY,_value,_maxKey);
    If ((_tempkeyX>=0)&&(_tempkeyX<_maxKey)&&(_tempkeyY>=0)&&(_tempkeyY<_maxKey)) then {
        private _tempkey = format ["%1_%2",_tempkeyX,_tempkeyY];
        private _zoneHash = HASH_GET(GVAR(dangerzones),_tempkey);
        If (isNil "_zoneHash") then {
            _zoneHash = HASH_CREATE;
            HASH_SET(GVAR(dangerzones),_tempkey,_zoneHash);
        };
        private _strengthEnemy = HASH_GET_DEF(_zoneHash,"enemystrength",0);
        _strengthEnemy = (_strengthEnemy + _value);
        HASH_SET(_zoneHash,"enemystrength",_strengthEnemy);
    };
} forEach [
    [_keyX, _keyY, _StrengthValue],
    [_keyX - _gridsize, _keyY - _gridsize, _StrengthValue * HQ_DANGERMOD ],
    [_keyX - _gridsize, _keyY + _gridsize, _StrengthValue * HQ_DANGERMOD ],
    [_keyX + _gridsize, _keyY + _gridsize, _StrengthValue * HQ_DANGERMOD ],
    [_keyX + _gridsize, _keyY - _gridsize, _StrengthValue * HQ_DANGERMOD ]
];
