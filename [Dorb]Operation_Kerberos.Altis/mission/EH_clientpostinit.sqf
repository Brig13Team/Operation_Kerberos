/*
    Author: Dorbedo, iJesuz

    Description:


*/
#include "script_component.hpp"

// Initialization Stuff
["Land_File1_F", "Land_File2_F", "Land_FilePhotos_F", "Land_Laptop_F", "Land_Laptop_unfolded_F", "Land_SatellitePhone_F", "Land_MobilePhone_smart_F"] call FUNC(objects_intel_init);

// Information Events
[QGVAR(intel_found),{
    _this params ["_intel","_caller"];

    [localize "STR_DORB_MISSION_NEW_INTEL_FOUND_MSG_TITLE", format [localize "STR_DORB_MISSION_NEW_INTEL_FOUND_MSG",_caller]] call EFUNC(interface,message);
}] call CBA_fnc_addEventHandler;

[QGVAR(weaponcache_destroyed),{
    ["STR_DORB_MISSION_NEW_WEAPONCACHE_DESTROYED_MSG_TITLE", "STR_DORB_MISSION_NEW_WEAPONCACHE_DESTROYED_MSG"] call EFUNC(interface,message);
}] call CBA_fnc_addEventHandler;

// Mission Events
[QGVAR(earthquake),{
    if (!(vehicle player isKindof 'Air')) then {
        private _rand=(floor(random 4)+1);
        [_rand]spawn BIS_fnc_earthquake;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(sandstorm),
    {[] call FUNC(objects_device_effect_sandstorm_init);}
] call CBA_fnc_remoteEvent;

// Various Stuff
[QGVAR(killedMessage),
    {[localize LSTRING(KILL),[format [localize LSTRING(KILL_KILLED),_this select 0]],"data\icon\icon_target.paa",true] call EFUNC(interface,disp_info);}
] call CBA_fnc_addEventHandler;

[QGVAR(suitcase_handle),
    {
        params ["_suitcase"];
        [{_this call FUNC(objects_handle); }, 1, [_suitcase]] call CBA_fnc_addPerFrameHandler;
    }
] call CBA_fnc_addEventHandler;
