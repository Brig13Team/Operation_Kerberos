/*
    Author: iJesuz

    Description:
        Mission "Weaponcache"

    Parameter(s):
        0 : [STRING,ARRAY]  - Destination [Locationname, Position]

    Return:
        [CODE,ARRAY]    -   [Taskhandler conditional function, its arguments]
*/
#include "script_component.hpp"

_this params [["_destination",["",[0,0,0]],[["",[]]]]];

private _objs = getArray(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "objects");
private _objs_count = getArray(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "objects_count");
private _objs_min = _objs_count select 0;
private _objs_max = _objs_count select 1;
private _objs_average = (floor random (_objs_max - _objs_min + 1)) + _objs_min;

// spawn object(s)
private _position = _destination select 1;
private _radius = getNumber(missionConfigFile >> "missions_config" >> "main" >> "weaponcache" >> "location" >> "distance");
private _buildings = [_position, _radius] call EFUNC(common,get_buildings);
for "_i" from 1 to _objs_average do {
    private _temp = selectRandom _objs;
    private _pos  = selectRandom (selectRandom _buildings);
    private _obj = [_temp,_pos] call EFUNC(spawn,temp_spawner);

    #ifdef DEBUG_MODE_FULL
        private _marker = createMarker [format ["DEBUG_WEAPONCACHE_MARKER_%1",_i],_pos];
        _marker setMarkerType "hd_dot";
    #endif

    _obj addEventHandler ["Killed",{
            _this params ["_unit","_killer"];

            "Bo_Mk82" createVehicle (getPos _unit);
            [QGVAR(weaponcache_destroyed),[_unit]] call CBA_fnc_globalEvent;
    }]
};

// TODO: spawn defence units
/*
    ...
*/

// Init for Conditional Function
GVAR(destroyed_caches) = 0;

["dorb_mission_fnc_mainmission_weaponcache_cond",[_objs_average]]
