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
[] call FUNC(obj_initACEAction_wreck);

// events
[QGVAR(effectDownload_Client),LINKFUNC(obj_effectDownloadClient)] call CBA_fnc_addEventHandler;
[QFUNC(obj___message),LINKFUNC(obj___message)] call CBA_fnc_addEventHandler;
