/*
    Author: Dorbedo, iJesuz

    Description:


*/
#include "script_component.hpp"
CHECK(!hasInterface)

// Initialization Stuff
[] call FUNC(obj_initACEAction_intel);
[] call FUNC(obj_initACEAction_device);
[] call FUNC(obj_initACEAction_upload);

/*
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
*/

[QGVAR(effectDownload_Client),LINKFUNC(obj_effectDownloadClient)] call CBA_fnc_addEventHandler;
[QFUNC(obj___message),LINKFUNC(obj___message)] call CBA_fnc_addEventHandler;
