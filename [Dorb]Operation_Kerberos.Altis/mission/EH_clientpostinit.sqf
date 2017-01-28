/*
    Author: Dorbedo, iJesuz

    Description:


*/
#include "script_component.hpp"

// Initialization Stuff
[
    "Land_File1_F",
    "Land_File2_F",
    "Land_FilePhotos_F",
    "Land_Laptop_F",
    "Land_Laptop_unfolded_F",
    "Land_SatellitePhone_F",
    "Land_MobilePhone_smart_F"
] call FUNC(objects_initACEAction_Intel);

[
    "rhs_typhoon_vdv",
    "Land_Device_assembled_F"
] call FUNC(objects_initACEAction_Device);


// Mission Events
[QGVAR(earthquake),LINKFUNC(onEarthquake)] call CBA_fnc_addEventHandler;

[QGVAR(sandstorm),LINKFUNC(device_effect_sandstorm_init)] call CBA_fnc_remoteEvent;

[QGVAR(suitcase_handle),
    {
        _this params ["_suitcase"];
        [LINKFUNC(objects_case_handler), 1, [_suitcase]] call CBA_fnc_addPerFrameHandler;
    }
] call CBA_fnc_addEventHandler;
