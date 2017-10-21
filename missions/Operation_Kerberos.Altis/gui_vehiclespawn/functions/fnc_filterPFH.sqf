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
_params params [["_display",displayNull,[displayNull]],"_ctrlTextNames","_ctrlEditNames","_ctrlTextMod","_ctrlEditMod"];

If (isNull _display) exitWith {
    GVAR(FilterHandleID) = nil;
    [_handler] call CBA_fnc_removePerFrameHandler;
};

private _nameText = toLower (ctrlText _ctrlEditNames);
private _ModText = toLower (ctrlText _ctrlEditMod);

// update the "watersign"
If (count _nameText >0) then {
    _ctrlTextNames ctrlSetTextColor [1,1,1,0];
    _ctrlTextNames ctrlCommit 0;
} else {
    _ctrlTextNames ctrlSetTextColor [1,1,1,1];
    _ctrlTextNames ctrlCommit 0;
};
If (count _ModText >0) then {
    _ctrlTextMod ctrlSetTextColor [1,1,1,0];
    _ctrlTextMod ctrlCommit 0;
} else {
    _ctrlTextMod ctrlSetTextColor [1,1,1,1];
    _ctrlTextMod ctrlCommit 0;
};

private _updateFilter = false;

//If ((count _nameText)>3) then {
    If !(_nameText isEqualTo GVAR(filterName)) then {
        GVAR(filterName) = _nameText;
        _updateFilter = true;
    };
//} else {
//    GVAR(filterName) = "";
//};
//If ((count _ModText)>3) then {
    if !(_ModText isEqualTo GVAR(filterMod)) then {
        GVAR(filterMod) = _ModText;
        _updateFilter = true;
    };
//} else {
//    GVAR(filterMod) = "";
//};

If ((_ModText isEqualTo "")&&(_nameText isEqualTo "")) then {
    GVAR(filterName) = "";
    GVAR(filterMod) = "";
    GVAR(curVehListFiltered) = nil;
    [_display] call FUNC(showList);
    [] call FUNC(sortLnb);
}else{
    If (_updateFilter) then {
        [] call FUNC(filterVehList);
        [_display] call FUNC(showList);
        [] call FUNC(sortLnb);
    };
};
