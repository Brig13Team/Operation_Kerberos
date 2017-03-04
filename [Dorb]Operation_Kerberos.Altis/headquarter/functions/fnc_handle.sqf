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
        If ((isNull _curAttackPos)&&{!(_position isEqualTo [0,0,0])}) then {
            _attackPosToCreate pushBack _position;
        };
        TRACEV_4(_position,_key,_curAttackPos,_value);
    } forEach ([] call FUNC(dzfindPeaks));
    TRACEV_1(_attackPosToCreate);

    /// create new attacklocaltions
    {
        [_x] call FUNC(attackpos_create);
    } forEach _attackPosToCreate;

    /// calling supplys -
    [] call FUNC(ressources_supply);

    /// check the attackpositions
    private _newAttackPos = [] call FUNC(attackpos_check);

    /// groups balancing
    [] call FUNC(balanceGroups);


    {
        TRACE(FORMAT_1("Choosing new strategie: %1",_x));
        [_x] call FUNC(strategy__choose);
    } forEach _newAttackPos;


    /// POI

    [] call FUNC(checkPOI);

    /// Move defending Units of already destroyed POI to other POI
    {
        private _grouphash = _x;
        private _group = HASH_GET(_grouphash,"group");
        If (isNil "_grouphash") then {WARNING("Grouphash is Nil");TRACEV_3(_x,_grouphash,_group);};
        If ((HASH_GET_DEF(_grouphash,"state","NOSTATE")) in ["idle"]) then {
            private _allPOI = (HASH_GET(GVAR(POI),"Locations")) select {HASH_GET_DEF(_x,"isActive",false)};
            CHECK(_allPOI isEqualTo [])
            TRACE("Moving defence groups to other POI");
            [_group,"defend",(selectRandom _allPOI)] call FUNC(state_set);
        };
    } forEach (HASH_GET(GVAR(groups),"defenceGroups"));

    /// get the availlible groups
    private _waitingGroups = [];
    {
        If (side _x != GVARMAIN(playerside)) then {
            private _grouphash = HASH_GET(_x,QGVAR(grouphash));
            If !(isNil "_grouphash") then {
                // bored
                if ((HASH_GET_DEF(_grouphash,QGVAR(state),"NOSTATE")) in ["wait"]) then {
                    _waitingGroups pushBack _x;
                };
                // Veteran
                if ((HASH_GET_DEF(_grouphash,QGVAR(state),"NOSTATE")) in ["idle"]) then {
                    _waitingGroups pushBack _x;
                };
            };
        };
    } forEach allGroups;


};
