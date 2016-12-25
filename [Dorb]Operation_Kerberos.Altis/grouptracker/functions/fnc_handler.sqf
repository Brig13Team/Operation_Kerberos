/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the handler of the grouptracker
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If !(GVAR(active)) exitWith {[_this select 1] spawn FUNC(terminate);};
If !(GVAR(handleID)<0) exitWith {
    DEC(GVAR(handleID));
};
GVAR(handleID) = 3;


// get the groups to track
private _groupsToTrack = [] call FUNC(getGroups);
// delete the old groups
private _groupsToDelete = _groupsToTrack - GVAR(lastGroupsToTrack);
GVAR(lastGroupsToTrack) = _groupsToTrack;
{
    private _groupHash = _curGroup getVariable QGVAR(groupHash);
    [_grouphash] call FUNC(deleteMarker);
    HASH_DELETE(_groupHash);
} forEach _groupsToDelete;

private _delayAmount = ;

{
    private _curGroup = _x;
    // check for grouphash
    private _groupHash = _curGroup getVariable QGVAR(groupHash);
    If (isNil "_groupHash") then {
        [_curGroup] call FUNC(initGroup);
    };
    // update the group
    If (alive (leader _x)) then {
        HASH_GET(_groupHash,"positions") pushBack (getPos (leader _curGroup));
        private _symbol = [_curGroup] call FUNC(getSymbol)
        HASH_GET(_groupHash,"symbol") pushBack (_symbol);
        //HASH_GET(_groupHash,"color") pushBack ([_curGroup] call FUNC(getColor));
        HASH_GET(_groupHash,"size") pushBack ([_curGroup,_symbol] call FUNC(getSize));
    }else{
        HASH_GET(_groupHash,"positions") pushBack [0,0,0];
        HASH_GET(_groupHash,"symbol") pushBack "";
        //HASH_GET(_groupHash,"color") pushBack "";
        HASH_GET(_groupHash,"size") pushBack "";
    };
    // set the current properties
    private _positions = HASH_GET(_groupHash,_curGroup);
    If ((count _positions)>((GVAR(delayAmount) max 0)+1)) then {
        [_curGroup,false] call FUNC(update);
    }else{
        [_curGroup,true] call FUNC(update);
    };

} forEach _groupsToTrack;

GVAR(handleID) = -1;
