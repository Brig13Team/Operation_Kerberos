/*
    Author: iJesuz

    Description:
        Mission "Hostage"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]
<
    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _hostages = getArray(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "hostages");
private _hostages_count = getArray(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "hostages_count");
private _hostages_min = _objs_count select 0;
private _hostages_max = _objs_count select 1;
private _hostages_average = (floor random (_objs_max - _objs_min + 1)) + _objs_min;

// spawn object(s)
private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "location" >> "distance");
private _buildings = [_position, _radius] call EFUNC(common,get_buildings);
// private _hostage_array = [];
for "_i" from 1 to _hostages_average do {
    private _temp = selectRandom _objs;
    private _pos  = selectRandom (selectRandom _buildings);
    private _obj = [_temp,_pos] call EFUNC(spawn,temp_spawner);
    // _hostage_array pushBack _obj;

    #ifdef DEBUG_MODE_FULL
        private _marker = createMarker [format ["DEBUG_INTEL_MARKER_%1",_i],_pos];
        _marker setMarkerType "hd_dot";
    #endif

    _obj setVariable [QGVAR(ISTARGET),true];
    _obj setVariable [QGVAR(ISHOSTAGE),true];
    removeAllAssignedItems _obj;
    removeAllWeapons _obj;
    removeBackpack _obj;
    [_hostage,true] call ace_captives_fnc_setHandcuffed;
};

// TODO: spawn defence units
/*
    ...
*/

// Init for Conditional Function
GVAR(rescued_hostages) = 0;
GVAR(killed_hostages) = 0;

["dorb_mission_fnc_mainmission_hostage_cond",[_hostage_average]]
