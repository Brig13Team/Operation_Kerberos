/*
*  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      chooses the maintask
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

_this params ["_mission"];

// choose the type of the mission
private _type = [] call FUNC(spawn_chooseMission);
_mission setVariable ["type",_type];
// get all important Variables and start the mission
private _missionCfg = (missionConfigFile >> "mission" >> "main" >> _type);

// get the army
private _armys = getArray (_missionCfg >> "defence" >> "armys");
private _chosenArmy = "";
If !(_armys isEqualTo []) then {
    private _chosenArmy = [_armys,1] call EFUNC(common,sel_array_weighted);
};
[_chosenArmy] call EFUNC(spawn,army_set);
// the location
private _location = [_type] call FUNC(spawn_chooseLocation);
_mission setVariable ["location",_location];

private _radius = getNumber (_missionCfg >> "location" >> "radius");
private _centerpos = [_location select 1, _radius] call EFUNC(common,pos_random);
_mission setVariable ["centerpos",_centerpos];

If !(isNull (missionNamespace getVariable [QGVAR(forcedNextMain),locationNull])) then {
    // we transfer the variables of the forced next main onto the current hash and delete the main
    HASH_MERGE(_mission,GVAR(forcedNextMain));
    HASH_DELETE(GVAR(forcedNextMain));
};
