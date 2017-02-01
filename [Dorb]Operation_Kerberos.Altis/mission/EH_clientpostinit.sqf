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
    "Land_SatellitePhone_F",
    "Land_MobilePhone_smart_F"
] call FUNC(obj_initACEAction_secureIntel);

[
    "rhs_typhoon_vdv",
    "Land_Device_assembled_F",
    "Land_Device_disassembled_F",
    "Land_Device_slingloadable_F"
] call FUNC(obj_initACEAction_Device);

[
    "Land_Suitcase_F"
] call FUNC(obj_initACEAction_case);

[
    "Land_Laptop_F",
    "Land_Laptop_device_F",
    "Land_Laptop_unfolded_F",
    "Land_Laptop_unfolded_scripted_F"
] call FUNC(obj_initACEAction_Laptop);

[
    "Land_DataTerminal_01_F"
] call FUNC(obj_initACEAction_DataTerminal);
