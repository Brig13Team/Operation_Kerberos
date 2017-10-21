/*
 *  Author: Dorbedo
 *
 *  Description:
 *      opens the loadingScreen
 *
 *  Parameter(s):
 *      (optional)
 *      0 : STRING - Title of the loading Screen
 *
 *  Returns:
 *      STRING - ID
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If !(canSuspend) then {_this spawn FUNC(startLoadingScreen);};

disableSerialization;

params [["_title","",[""]]];

If (isNil QGVAR(loading)) then {
    GVAR(loading) = HASH_CREATE;
    GVAR(loadingID) = 0;
    GVAR(loadingtitle) = "";
};

If (_title isEqualTo "") then {
    _title = GVAR(loadingtitle);
}else{
    GVAR(loadingtitle) = _title;
};

if (isNull(findDisplay IDD_LOADING)) then {
    createDialog QAPP(loadingScreen);
    (findDisplay IDD_LOADING) displayAddEventHandler ["KeyDown", {
        _this params ["_disp","_key"];
        If (_key == 1) exitWith {
            // reload Loadingscreen, if the user trys to escape
            [] spawn {
                uisleep 0.1;
                private _id = [""] call FUNC(startLoadingScreen);
                [_id] call FUNC(endLoadingScreen);
            };
        };
    }];
};

((findDisplay IDD_LOADING) displayCtrl IDD_LOADING_DESCRIPTION) ctrlsetText _title;


GVAR(loadingID) = GVAR(loadingID) + 1;
private _newKey = str GVAR(loadingID);

If (HASH_HASKEY(GVAR(loading),_newkey)) exitWIth {_newKey};

HASH_SET(GVAR(loading),_newKey,0);

[] call FUNC(progressLoadingScreen);

_newKey;
