/*
    Author: Dorbedo

    Description:
        handles AI HQ

    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
CHECK(!GVAR(active))

CHECK(!isNull(GVAR(handle)))

/// spawn to move it in the ingame sheduler
GVAR(handle) = [] spawn {
    SCRIPTIN(handle,spawn);

    /// check dangerzones for new Zones to attack
    private _attackPosToCreate = [];
    {
        _x params ["_value","_key"];
        private _position = [_key] call FUNC(dzconvert);
        private _curAttackPos = [_position] call FUNC(attackpos_atPosition);
        If (isNull _curAttackPos) then {
            _attackPosToCreate pushBack [_position];
        };
    } forEach ([] call FUNC(dzfindPeaks));

    /// create new attacklocaltions
    private _size = (HASH_GET(GVAR(dangerzones),"gridsize")) * 2;
    {
        /// should be chaned in a later Version
        private _curPos = _x;
        private _curAttackLoc = [_position] call FUNC(attackpos_create);
        private _players = allPlayers select {(_x distance _curPos)<_size};
        private _groups = [];
        {_groups pushBackUnique (group _x);} forEach _players;
        {[_curAttackLoc,_x] call FUNC(attackpos_add);} forEach _groups;
    } forEach _attackPosToCreate;

    /// check for
    [] call FUNC(ressources_supply);

    /// check the attackpositions
    private _newAttackPos = [] call FUNC(attackpos_check);

    /// groups balancing
    [] call FUNC(balanceGroups);


    {
        [_x] call FUNC(strategy__choose);
    } forEach _newAttackPos;


    /// POI

    [] call FUNC(checkPOI);

    /// Move defending Units of already destroyed POI to other POI
    {
        private _group = _x;
        private _grouphash = _group getVariable QGVAR(grouphash);
        If ((HASH_GET_DEF(_grouphash,"state",""))in["idle"]) then {
            private _allPOI = (HASH_GET(GVAR(POI),"Locations")) select {HASH_GET_DEF(_x,"isActive",false)};
            CHECK(_allPOI isEqualTo [])
            [_group,"defend",(selectRandom _allPOI)] call FUNC(state_set);
        };
    } forEach (HASH_GET(GVAR(groups),"defenceGroups"));

    /// get the availlible groups
    private _waitingGroups = [];
    {
        If (side _x != GVARMAIN(playerside)) then {
            // bored
            if ((_x getVariable [QGVAR(state),""]) isEqualTo "wait") then {
                _waitingGroups pushBack _x;
            };
            // Veteran
            if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
                _waitingGroups pushBack _x;
            };
        };
    }forEach allGroups;


};
