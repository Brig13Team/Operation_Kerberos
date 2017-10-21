/**
 * Author: Dorbedo
 * the filter perFrameHandler
 *
 * Arguments:
 * 0: <ANY> Parameter
 * 1: <STRING> Handle-ID
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_params","_handler"];
_params params [["_display",displayNull,[displayNull]],"_ctrlTextNames","_ctrlEditNames"];

If (isNull _display) exitWith {
    GVAR(FilterHandleID) = nil;
    [_handler] call CBA_fnc_removePerFrameHandler;
};

private _nameText = toLower (ctrlText _ctrlEditNames);

// update the "watersign"
If (count _nameText >0) then {
    _ctrlTextNames ctrlSetTextColor [1,1,1,0];
    _ctrlTextNames ctrlCommit 0;
} else {
    _ctrlTextNames ctrlSetTextColor [1,1,1,1];
    _ctrlTextNames ctrlCommit 0;
};

If (_nameText isEqualTo GVAR(filterName)) exitWith {};

GVAR(filterName) = _nameText;

[_ctrlEditNames,GVAR(curItemListID)] call FUNC(filterList);
