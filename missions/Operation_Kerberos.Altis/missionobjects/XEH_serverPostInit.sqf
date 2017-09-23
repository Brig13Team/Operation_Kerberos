/**
 * Author: Dorbedo
 * postInit Server
 *
 */

#include "script_component.hpp"

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

[QEGVAR(mission,emp), LINKFUNC(spawnEMP)] call CBA_fnc_addEventHandler;
[QEGVAR(mission,effectDownload_Server), LINKFUNC(effectDownloadServer)] call CBA_fnc_addEventHandler;


call FUNC(initializeObjectsServer);
