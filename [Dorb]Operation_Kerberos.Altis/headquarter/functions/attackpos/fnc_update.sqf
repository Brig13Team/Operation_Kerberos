/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates an attacklocation with the current values. Evaluates, if there is still
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_attackLoc",locationNull,[locationNull]],["_dzValue",-1,[0]]];
CHECK((isNull _attackLoc)||{!(IS_HASH(_attackLoc))})

private _enemygroups = [];
private _enemyType = [0,0,0];
private _enemyValue = [0,0,0];
private _enemyThreat = [0,0,0];

{
    private _grouphash = _x;
    private _currentGroup = HASH_GET_DEF(_grouphash,"group",grpNull);
    If !(isNull _currentGroup) then {
        private _groupIsInside =
            0<{
                ((getPos _x) in _attackLoc)&&
                {(GVARMAIN(side) knowsAbout _x)>1}
            }count (units _currentGroup);

        If (_groupIsInside) then {
            _enemygroups pushBackUnique _currentGroup;


            private _currentType = HASH_GET(_grouphash,"type");
            private _currentValue = HASH_GET(_grouphash,"value");
            private _currentThreat = HASH_GET(_grouphash,"threat");

            _enemyType set [_currentType,(_enemyType select _currentType) + 1];
            _enemyValue set [_currentType,(_enemyValue select _currentType) + _currentValue];
            _enemyThreat = [
                (_enemyThreat select 0) max (_currentThreat select 0),
                (_enemyThreat select 1) max (_currentThreat select 1),
                (_enemyThreat select 2) max (_currentThreat select 2)
            ];

        };
    };
} count HASH_GET_DEF(GVAR(groups),"playergroups",[]);

If (_enemygroups isEqualTo []) exitWith {[_attackLoc] call FUNC(attackpos_delete);};

If (_dzValue < 0) then {
    private _key = [getPos _attackLoc] call FUNC(dzConvert);
    private _dzHash = HASH_GET(GVAR(dangerzones),_key);
    If (!isNil "_dzHash") then {
        _dzValue = DZVALUEMOD(HASH_GET_DEF(_dzHash,"enemystrength",0));
    }else{
        _dzValue = 0;
    };
};

private _valueMax = (_enemyValue select 0) + (_enemyValue select 1) + (_enemyValue select 2);
if (_valueMax < (0.8 *_dzValue)) then {
    _enemyValue = [
        If ((_enemyValue select 0) == 0) then {
            0
        }else{
            ((_enemyValue select 0)/_valueMax) * _dzValue + (_enemyValue select 0)
        },
        If ((_enemyValue select 1) == 0) then {
            0
        }else{
            ((_enemyValue select 1)/_valueMax) * _dzValue + (_enemyValue select 1)
        },
        If ((_enemyValue select 2) == 0) then {
            0
        }else{
            ((_enemyValue select 2)/_valueMax) * _dzValue + (_enemyValue select 2)
        }
    ];
};

HASH_SET(_attackLoc,"enemygroups",_enemygroups);
HASH_SET(_attackLoc,"enemytype",_enemyType);
HASH_SET(_attackLoc,"enemyvalue",_enemyValue);
HASH_SET(_attackLoc,"enemythreat",_enemyThreat);

/*

_this params [["_attackLoc",locationNull,[locationNull]],["_dzValue",-1,[0]]];
CHECK((isNull _attackLoc)||{!(IS_HASH(_attackLoc))})

private _enemygroups = HASH_GET(_attackLoc,"enemygroups");
private _groupsToRemove = [];

private _enemyType = [0,0,0];
private _enemyValue = [0,0,0];
private _enemyThreat = [0,0,0];

{
    private _currentGroup = _x;
    If ((isNull _currentGroup)||{1>({(getPos _x) in _attackLoc}count (units _currentGroup))}) then {
        _groupsToRemove pushBack _currentGroup;
    }else{
        private _grouphash = _currentGroup getVariable QGVAR(grouphash);

        private _currentType = HASH_GET(_grouphash,"type");
        private _currentValue = HASH_GET(_grouphash,"value");
        private _currentThreat = HASH_GET(_grouphash,"threat");

        _enemyType set [_currentType,(_enemyType select _currentType) + 1];
        _enemyValue set [_currentType,(_enemyValue select _currentType) + _currentValue];
        _enemyThreat = [
            (_enemyThreat select 0) max (_currentThreat select 0),
            (_enemyThreat select 1) max (_currentThreat select 1),
            (_enemyThreat select 2) max (_currentThreat select 2)
        ];
    };
} forEach _enemygroups;

{
    _enemygroups = _enemygroups - [_x];
} forEach _groupsToRemove;

If (_enemygroups isEqualTo []) exitWith {[_attackLoc] call FUNC(attackpos_delete);};

If (_dzValue < 0) then {
    private _key = [getPos _attackLoc] call FUNC(dzConvert);
    private _dzHash = HASH_GET(GVAR(dangerzones),_key);
    If (!isNil "_dzHash") then {
        _dzValue = HASH_GET_DEF(_dzHash,"enemystrength",0);
    };
};

private _valueMax = (_enemyValue select 0) + (_enemyValue select 1) + (_enemyValue select 2);
if (_valueMax < (0.8 *_dzValue)) then {
    _enemyValue = [
        If ((_enemyValue select 0) == 0) then {
            0
        }else{
            ((_enemyValue select 0)/_valueMax) * _dzValue + (_enemyValue select 0)
        },
        If ((_enemyValue select 1) == 0) then {
            0
        }else{
            ((_enemyValue select 1)/_valueMax) * _dzValue + (_enemyValue select 1)
        },
        If ((_enemyValue select 2) == 0) then {
            0
        }else{
            ((_enemyValue select 2)/_valueMax) * _dzValue + (_enemyValue select 2)
        }
    ];
};

HASH_SET(_attackLoc,"enemygroups",_enemygroups);
HASH_SET(_attackLoc,"enemytype",_enemyType);
HASH_SET(_attackLoc,"enemyvalue",_enemyValue);
HASH_SET(_attackLoc,"enemythreat",_enemyThreat);
*/
