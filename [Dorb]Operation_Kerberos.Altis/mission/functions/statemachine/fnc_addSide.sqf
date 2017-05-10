/*
 *  Author: Dorbedo
 *
 *  Description:
 *      chooses the sidemissions
 *
 *  Parameter(s):
 *      0 : LOCATION - the mainmission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

/*
    //   _stateMachine   - the state machine
    //   _this           - the current list item
    //   _thisTransition - the current transition we're in
    //   _thisOrigin     - the state we're coming from
    //   _thisState      - same as _thisOrigin
    //   _thisTarget     - the state we're transitioning to
*/

_this params ["_mainmission"];

private _mainType = _mission getVariable "type";

private _min = getNumber (missionConfigFile >> "mission" >> "main" >> _mainType >> "side" >> "min");
private _max = getNumber (missionConfigFile >> "mission" >> "main" >> _mainType >> "side" >> "max");

private _amount = ceil (random(_max - _min)) + _min;

for "_i" from 1 to _amount do {
    private _hash = HASH_CREATE;
    private _type = [_mainType] call FUNC(spawn_chooseSide);
    _hash setVariable ["type",_type];
    _hash setVariable ["parent",_mission];
    _hash setVariable ["isMain",false];


    // the location TODO
    private _location = [_type] call FUNC(spawn_chooseLocation);
    _hash setVariable ["location",_location];

    GVAR(missions) pushBack _hash;
};
