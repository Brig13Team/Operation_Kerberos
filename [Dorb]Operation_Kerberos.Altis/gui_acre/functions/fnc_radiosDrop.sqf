/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_ctrl","_PosX","_PosY","_sourceID","_valueArray"];

private _sourceCtrl = (uiNamespace getVariable QEGVAR(gui_Echidna,dialog)) displayCtrl _sourceID;
If (_ctrl isEqualTo _sourceCtrl) exitWith {};

(_valueArray select 0) params ["_text","_value","_data"];

TRACEV_3(_data,_valueArray,_this);

If (HASH_HASKEY(GVAR(radioTypeList),_data)) then {
    // add a new radio to the list
    TRACE("ADDING");
    private _localHash = [_data] call FUNC(setFilteredPresetChannel);
    GVAR(curSelIndex) = GVAR(tempRadioList) pushBack _localHash;
    [] call FUNC(radiosList);
}else{
    // remove a radio from the list
    TRACE("REMOVING");
    GVAR(tempRadioList) deleteAt _value;
    If ((GVAR(curSelIndex) > _value)||(_value == 0)) then {
        GVAR(curSelIndex) = GVAR(curSelIndex) - 1;
    };
    [] call FUNC(radiosList);
};
[GVAR(curSelIndex)] call FUNC(radiosProperties);
nil;
