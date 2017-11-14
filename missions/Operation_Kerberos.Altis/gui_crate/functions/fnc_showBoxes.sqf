/**
 * Author: Dorbedo
 * displays the possible boxes
 *
 * Arguments:
 * 0: <ARRAY> position
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_display"];

private _nearObjects = nearestObjects [ASLToAGL GVAR(curPos), ["AllVehicles","ReammoBox_F"], CHECK_RADIUS_MIN];
TRACEV_2(GVAR(curPos),_nearObjects);
// filter the Objects

//TODO


// create the list
private _list = [];
{
    _list pushBack [
        format [localize LSTRING(NEWBOX),[_x,"displayName",""] call EFUNC(common,getCfgVehicles)],
        _x,
        0
    ];
    nil
} count DEFAULT_BOXES;

{
    _list pushBack [
        [typeOf _x,"displayName",""] call EFUNC(common,getCfgVehicles),
        _x call BIS_fnc_netId,
        1
    ];
    nil
} count _nearObjects;

TRACEV_1(_list);

private _ctrlLb = (_display) displayCtrl IDC_GUI_CRATE_BOXLIST;
{
    _x params ["_text","_data","_value"];
    TRACEV_3(_text,_data,_value);
    private _index = _ctrlLb lbAdd _text;
    _ctrlLb lbSetData [_index,_data];
    _ctrlLb lbSetValue [_index,_value];
} forEach _list;

_ctrlLb lbSetCurSel 0;
[_ctrlLb,0] call FUNC(onBoxSelect);
