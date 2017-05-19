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
[
    "Land_DataTerminal_01_F"
] call FUNC(obj_initACEAction_DataTerminal);

// events
[QGVAR(effectDownload_Client),LINKFUNC(obj_effectDownloadClient)] call CBA_fnc_addEventHandler;
[QFUNC(obj___message),LINKFUNC(obj___message)] call CBA_fnc_addEventHandler;
[QGVAR(showCompositionDesigners),
    {
        _this params [["_authors",[],[[]]]];
        CHECK(_authors isEqualTo [])
        private _authorsString = LSTRING(COMPOSITIONS);
        {
            _authorsString + format ["%1 ,",_x];
        } forEach _authors;
        _authorsString = _authorsString select [0,(count _authorsString) - 1];
        [LSTING(COMPOSITIONS_TITLE),_authorsString,"green"] call EFUNC(gui,message);
    }
] call CBA_fnc_addEventHandler;
