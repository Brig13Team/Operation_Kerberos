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
#define DEBUG_MODE_OFF
#include "script_component.hpp"

If !(GVAR(active)) exitWith {[] spawn FUNC(terminate);};
If !(GVAR(handleID)<0) exitWith {
    DEC(GVAR(handleID));
};
GVAR(handleID) = 3;


// get the groups to track
private _groupsToTrack = [] call FUNC(getGroups);

// delete the old groups
private _groupsToDelete = (GVAR(lastGroupsToTrack) - _groupsToTrack);
GVAR(lastGroupsToTrack) = _groupsToTrack;
{
    private _groupHash = _x getVariable QGVAR(groupHash);
    If (isNil "_groupHash") exitWith {
        [] call FUNC(restart);
        TRACE("restart");
        _groupsToTrack = [] call FUNC(getGroups);
        GVAR(lastGroupsToTrack) = _groupsToTrack;
    };
    [_grouphash] call FUNC(deleteMarker);
    GVAR(grouphashes) - [_groupHash];
    HASH_DELETE(_groupHash);
} forEach _groupsToDelete;
TRACEV_2(_groupsToDelete,_groupsToTrack);
{
    private _curGroup = _x;

    // check for grouphash
    private _groupHash = _curGroup getVariable [QGVAR(groupHash),locationNull];
    TRACEV_2(_groupHash,_curGroup);
    If (isNull _groupHash) then {
        _groupHash = [_curGroup] call FUNC(initGroup);
        TRACEV_2(_curGroup,_groupHash);
    };

    // update the group
    If (alive (leader _curGroup)) then {
        HASH_GET(_groupHash,"positions") pushBack (getPos (leader _curGroup));
        private _symbol = [_curGroup] call FUNC(getSymbol);
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
    private _positions = HASH_GET(_groupHash,"positions");
    TRACEV_3(_groupHash,_curGroup,_positions);
    If ((count _positions)>((GVAR(delayAmount) max 0)+1)) then {
        [_curGroup,false] call FUNC(update);
    }else{
        [_curGroup,true] call FUNC(update);
    };

} forEach _groupsToTrack;

GVAR(handleID) = -1;
