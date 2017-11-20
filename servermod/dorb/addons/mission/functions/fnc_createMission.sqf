#include "script_component.hpp"
/**
 * Name: dorb_mission_fnc_createMission
 *
 * Author: Dorbedo
 * creates a Mission
 *
 * Arguments:
 * 0: <LOCATION> the mission
 *
 * Return Value:
 * Nothing
 *
 */

params ["_mission"];

private _allMissionsConfigs = configProperties [configfile >> "CfgKerberos" >> "missions", "!((configName _x) isEqualTo 'basemission')", true];

_allMissionsConfigs = _allMissionsConfigs select {
    If (getText(_x>>"condition") isEqualTo "") then {
        true
    } else {
        (call compile getText(_x>>"condition"))
    }
};

private _missionsWeighted = [];
{
    _missionsWeighted pushBack _x;
    _missionsWeighted pushBack (getNumber(_x>>"probability"));
    nil
} count _allMissionsConfigs;

private _type = configName (selectRandomWeighted _missionsWeighted);

_mission setVariable ["type",_type];
_mission setVariable ["missioncfg",_missionCfg];

private _armys = getArray (_missionCfg >> "armys");
private _chosenArmy = "";
If !(_armys isEqualTo []) then {
    _chosenArmy = ([_armys,1] call EFUNC(common,sel_Array_Weighted)) select 0;
};
[_chosenArmy] call EFUNC(spawn,army_set);

TRACEV_2(_armys,_chosenArmy);

// the location of the Mission
private _allLocationtypes = getArray (_missionCfg >> "position" >> "locationtypes");
private _location = [_allLocationtypes] call EFUNC(worlds,chooseLocation);
TRACEV_2(_allLocationtypes,_location);
_mission setVariable ["location",_location];

private _radius = getNumber (_missionCfg >> "position" >> "radius");
private _centerpos = [_location select 1, _radius] call EFUNC(common,pos_random);
_mission setVariable ["centerpos",_centerpos];

// the spawnfunction
private _spawnFunction = getText(_missionCfg >> "objective" >> "spawnfunction");
_mission setVariable ["spawnfunction",_spawnFunction];


// the delay of the task
private _taskdelay = getNumber(_missionCfg >> "task" >> "delay");
_mission setVariable ["taskdelay",_taskdelay];

INC(GVAR(taskCounter));
private _taskID = format[QGVAR(mission_%1),GVAR(taskcounter)];
_mission setVariable ["taskID",_taskID];

// the conditiontype
private _condition = getText(_missionCfg >> "condition" >> "conditiontype");
_mission setVariable ["conditiontype",_condition];

// adding the events
private _events = (configProperties [_missionCfg >> "condition","isText _x"]) select {(configname _x) select [0,2] == "on"};
{
    private _value = getText _x;
    If !(isNil {missionNamespace getVariable _value}) then {
        _mission setVariable [configname _x,_value];
    }else{
        _mission setVariable [configname _x,compile _value];
    };
} forEach _events;

// now we check if we have already a new mainmission defined if so, we merge
If !(isNull (missionNamespace getVariable [QGVAR(forcedNextMain),locationNull])) then {
    // we transfer the variables of the forced next main onto the current hash and delete the main
    HASH_MERGE(_mission,GVAR(forcedNextMain));
    HASH_DELETE(GVAR(forcedNextMain));
};
