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

// spawn to move it in the ingame sheduler
GVAR(handle) = [] spawn {
    SCRIPTIN(handle,spawn);

    // check dangerzones for new Zones to attack
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

    // add the positions, where Player were spotted
    {
        If !(([_x] call FUNC(dzConvert))isEqualTo "") then {
            _attackPosToCreate pushBack _x;
        };
    } forEach ([] call FUNC(getKnownPlayerPos));

    #ifdef DEBUG_MODE_FULL
        If !(_attackPosToCreate isEqualTo []) then {
            TRACEV_1(_attackPosToCreate);
        };
    #endif

    // create new attacklocaltions
    {
        [_x] call FUNC(attackpos_create);
    } forEach _attackPosToCreate;

    // calling supplys -
    [] call FUNC(ressources_supply);

    // check the attackpositions
    private _newAttackPos = [] call FUNC(attackpos_check);

    // groups balancing
    [] call FUNC(balanceGroups);


    {
        TRACE(FORMAT_1("Choosing new strategie: %1",_x));
        [_x] call FUNC(strategy__choose);
    } forEach _newAttackPos;

    // POI
    [] call FUNC(checkPOI);

};
