/*
    Author: Dorbedo

    Description:
        creates a attackPosition

    Parameter(s):
        0: Position or Group <ARRAY/GROUP>

    Returns:
        <LOCATION>
*/
#include "script_component.hpp"
_this params [["_position",[],[[],grpNull],[2,3]]];
private _group = grpNull;
If (IS_GROUP(_position)) then {
    If (isNull _position) then {
        _position = [];
    }else{
        _group = _position;
        _position = getPos (leader _group);
    };
};
CHECK(_position isEqualTo [])
private _attackLoc = [_position] call FUNC(attackpos_atPosition);
If (isNull _attackLoc) then {
    _attackLoc = HASH_CREATE;
    HASH_GET(GVAR(attackpos),"Locations") pushBack _attackLoc;
    //private _size = (HASH_GET(GVAR(dangerzones),"gridsize")) * 1.414;
    private _size = (HASH_GET(GVAR(dangerzones),"gridsize")) * 2;
    _attackLoc setPosition _position;
    _attackLoc setSize [_size,_size];
    _attackLoc setRectangular true;
    HASH_SET(_attackLoc,"isPOI",false);
};

If !(isNull _group) then {
    [_attackLoc,_group] call FUNC(attackpos_add);
}else{
    HASH_SET(_attackLoc,"enemygroups",[]);
    HASH_SET(_attackLoc,"enemytype",[0,0,0]);
    HASH_SET(_attackLoc,"enemyvalue",[0,0,0]);
    HASH_SET(_attackLoc,"enemythreat",[0,0,0]);
};
_attackLoc;
