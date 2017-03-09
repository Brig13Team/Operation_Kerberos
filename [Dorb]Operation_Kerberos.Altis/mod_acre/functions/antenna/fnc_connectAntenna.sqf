/*
 *  Author: Dorbedo
 *
 *  Description:
 *      connect an antenna to a radio
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


_this params [["_target",objNull,[objNull]],["_radioID","",[""]]];

_rxAntennas = [_radioID] call acre_sys_components_fnc_findAntenna;
arce_sys_radio_fnc_getRadioPos





private _connectorAttributes = [] call acre_sys_core_fnc_fastHashCreate;
_connectorAttributes setVariable ["worldObject",_logic];
[_radioID,0,"ACRE_120CM_VHF_TNC",_connectorAttributes,false] call acre_sys_components_fnc_attachSimpleComponent
