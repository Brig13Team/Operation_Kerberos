/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Updates the radioproperties
 *
 *  Parameter(s):
 *      0 : CONTROL - the combobox
 *      1 : SCALAR - the control
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
TRACE("PRESET CHANGED");
_this params ["_ctrl",["_index",-1,[0]]];
private _curChannel = HASH_GET_DEF(GVAR(tempPropertiesRadio),"channel",-2);
TRACEV_2(_index,_curChannel);
If ((_index < 0)||(_index isEqualTo _curChannel)) exitWith {};


private _radioType = toUpper(HASH_GET(GVAR(tempPropertiesRadio),"radioType"));
private _acrePresetHash = [_radioType,_index] call FUNC(setFilteredPresetChannel);
GVAR(tempRadioList) set [GVAR(curSelIndex),_acrePresetHash];

[GVAR(curSelIndex)] call FUNC(radiosProperties);
