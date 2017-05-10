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
TRACE("adding side");
/*
    //   _stateMachine   - the state machine
    //   _this           - the current list item
    //   _thisTransition - the current transition we're in
    //   _thisOrigin     - the state we're coming from
    //   _thisState      - same as _thisOrigin
    //   _thisTarget     - the state we're transitioning to
*/

_this params ["_mainmission"];

private _mainType = _mainmission getVariable "type";

private _min = getNumber (missionConfigFile >> "mission" >> "main" >> _mainType >> "side" >> "min");
private _max = getNumber (missionConfigFile >> "mission" >> "main" >> _mainType >> "side" >> "max");

private _amount = ceil (random(_max - _min)) + _min;

for "_i" from 1 to _amount do {
    private _hash = HASH_CREATE;
    private _type = [_mainType] call FUNC(spawn_chooseMission);
    TRACEV_2(_type,_mainType);
    _hash setVariable ["type",_type];
    _hash setVariable ["parent",_mission];
    _hash setVariable ["isMain",false];

    private _missionCfg = (missionConfigFile >> "mission" >> "side" >> _type);

    // select the location, if non is specified, take the main-location
    private _mainlocation = _mainmission getVariable "location";
    private _locationtypes = getArray(_missionCfg >> "location" >> "areas");
    private _location = [];
    // if there are locations specified, we choose from them
    If !(_locationtypes isEqualTo []) then {
        // get  the config values
        private _possibleLocations = [];
        {
            private _var = missionNamespace getVariable _x;
            If (!isNil "_var") then {
                _possibleLocations = _possibleLocations + _var;
            };
        } forEach _locationtypes;

        // we check the locations for min/max distance
        If !(_possibleLocations isEqualTo []) then {
            // check the min distance
            private _minDistance = getNumber(getArray(_missionCfg >> "location" >> "minDistance"));
            If (_minDistance > 0) then {
                _possibleLocations = _possibleLocations select {
                    ((_x select 1) distance2D (_mainlocation select 1))>_minDistance;
                };
            };
            // check the max distance
            private _maxDistance = getNumber(getArray(_missionCfg >> "location" >> "maxDistance"));
            If (_maxDistance > 0) then {
                _possibleLocations = _possibleLocations select {
                    ((_x select 1) distance2D (_mainlocation select 1))<_maxDistance;
                };
            };
            If !(_possibleLocations isEqualTo []) then {
                _location = selectRandom _possibleLocations;
            };
        };
    };
    // if the location is still not defined, we use the main
    If (_location isEqualTo []) then {
        _location = _mainlocation;
    };

    // the targetposition around the center
    private _radius = getNumber (_missionCfg >> "location" >> "radius");
    private _centerpos = [_location select 1, _radius] call EFUNC(common,pos_random);
    _hash setVariable ["location",_location];
    _hash setVariable ["centerpos",_centerpos];

    // showMarker flag
    private _showMarker = ((getNumber(_missionCfg >> "disableMarker")) == 0);
    _hash setVariable ["showmarker",_showMarker];

    // the conditiontype
    private _condition = getText(_missionCfg >> "conditiontype");
    _hash setVariable ["conditiontype",_condition];


    private _mainID = _mainmission getVariable "taskID";
    INC(GVAR(taskCounter));
    private _taskID = format[QGVAR(mission_%1_side),GVAR(taskcounter)];
    _hash setVariable ["taskID",[_taskID,_mainID]];

    // now add the mission to the machine
    GVAR(missions) pushBack _hash;
};
