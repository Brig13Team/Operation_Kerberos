/*
    Author: Dorbedo, iJesuz

    Description:


*/
#include "script_component.hpp"
CHECK(!hasInterface)

If (!((getMissionConfigValue ["isKerberos", 0]) > 0)) exitWith {};

// events
[QEGVAR(mission,earthquake),LINKFUNC(effectEarthquake)] call CBA_fnc_addEventHandler;
[QEGVAR(mission,effectDownload_Client),LINKFUNC(effectDownloadClient)] call CBA_fnc_addEventHandler;
[QEGVAR(mission,effectEMPLocal),LINKFUNC(effectEMP)] call CBA_fnc_localEvent;

[QEGVAR(mission,showCompositionDesigners),
    {
        _this params [["_authors",[],[[]]]];
        CHECK(_authors isEqualTo [])
        _authors = _authors - [""];
        private _authorsString = localize LSTRING(COMPOSITIONS) + "<br />";
        {
            _authorsString = _authorsString + format ["%1 ,",_x];
        } forEach _authors;
        _authorsString = _authorsString select [0,(count _authorsString) - 1];
        [LSTRING(COMPOSITIONS_TITLE),_authorsString,"green"] call EFUNC(gui,message);
    }
] call CBA_fnc_addEventHandler;

call FUNC(initializeObjectsClient);
