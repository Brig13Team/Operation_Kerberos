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
    _chosenArmy = ([_armys,1] call EFUNC(common,sel_Array_Weighted)) select 0;
};
[_chosenArmy] call EFUNC(spawn,army_set);
TRACEV_2(_armys,_chosenArmy);

// the location of the Mission
private _location = [_type] call FUNC(spawn_chooseLocation);
_mission setVariable ["location",_location];

// get the centerposition of the spawning
private _radius = getNumber (_missionCfg >> "location" >> "radius");

private _centerpos = [_location select 1, _radius] call EFUNC(common,pos_random);
_mission setVariable ["centerpos",_centerpos];
[QEGVAR(headquarter,registerCenterPos),[_centerpos]] call CBA_fnc_localEvent;
// showMarker flag
private _showMarker = ((getNumber(_missionCfg >> "disableMarker")) == 0);
_mission setVariable ["showmarker",_showMarker];

// the conditiontype
private _condition = getText(_missionCfg >> "conditiontype");
_mission setVariable ["conditiontype",_condition];

INC(GVAR(taskCounter));
private _taskID = format[QGVAR(mission_%1),GVAR(taskcounter)];
_mission setVariable ["taskID",_taskID];

// adding the events
private _events = (configProperties [_missionCfg,"isText _x"]) select {(configname _x) select [0,2] == "on"};
{
    private _value = getText _x;
    If !(isNil (missionNamespace getVariable _value)) then {
        _hash setVariable [configname _x,_value];
    }else{
        _hash setVariable [configname _x,compile _value];
    };
} forEach _events;

// now we check if we have already a new mainmission defined
If !(isNull (missionNamespace getVariable [QGVAR(forcedNextMain),locationNull])) then {
    // we transfer the variables of the forced next main onto the current hash and delete the main
    HASH_MERGE(_mission,GVAR(forcedNextMain));
    HASH_DELETE(GVAR(forcedNextMain));
};
