/*
    Author: iJesuz, Dorbedo

    Description:
        Choose mission

    Parameter(s):
        0 : CONFIG  - MissionConfigClass which contains the mission classes
        1 : STRING  - mission name to be skipted

    Return:
        [STRING,ARRAY]

*/
#include "script_component.hpp"


_this params [["_cfg", (missionConfigFile >> "missions_config" >> "main"), [missionConfigFile]], ["_oldMission", "", [""]]];

private _mission = [];

for "_i" from 0 to (count _cfg) - 1 do
{
    private _name = configName (_cfg select _i);
    if (!(_name isEqualTo _oldMission)) then {
        _mission pushBack [_name, getNumber ((_cfg select _i) >> "probability")];
    };
};
TRACEV_2(_mission,count _cfg);
([_mission,1] call EFUNC(common,sel_array_weighted)) select 0
