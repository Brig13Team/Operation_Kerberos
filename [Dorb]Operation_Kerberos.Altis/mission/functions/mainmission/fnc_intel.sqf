/*
    Author: iJesuz

    Description:
        Mission "Intel"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _objs = getArray(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objects");
private _objs_count = getArray(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objects_count");
private _objs_min = _objs_count select 0;
private _objs_max = _objs_count select 1;
private _objs_average = (floor random (_objs_max - 1)) + 1;

// spawn object(s)
private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "location" >> "distance");
private _buildings = [_position, _radius] call EFUNC(common,get_buildings);
private _intel = [];
for "_i" from 1 to _objs_average do {
    private _temp = selectRandom _objs;
    private _pos  = selectRandom (selectRandom _buildings);
    // Create Object
    private _obj = [_temp,_pos] call EFUNC(spawn,temp_spawner);
    _intel pushBack _obj;
    #ifdef DORB_DEBUG_FULL
        private _marker = createMarker [format ["DEBUG_INTEL_MARKER_%1",_i],_pos];
        _marker setMarkerType "hd_dot";
    #endif
};

// TODO: spawn defence units
/*
    ...
*/

// Init for Conditional Function
missionNamespace setVariable [QGVAR(found_intel),0,true];

["dorb_mission_fnc_mainmission_intel_cond",[_objs_average]]
