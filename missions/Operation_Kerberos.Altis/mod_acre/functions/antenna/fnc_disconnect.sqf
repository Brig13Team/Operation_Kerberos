/*
 *  Author: Dorbedo
 *
 *  Description:
 *      disconnects an external Antenna
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

_this params [["_target",objNull,[objNull]]];

TRACEV_1(_target);


private _radioID = _target getVariable [QGVAR(externalAntenna_radioID),""];
private _logic = _target getVariable [QGVAR(externalAntenna),objNull];
_target setVariable [QGVAR(externalAntenna),nil,true];

[_logic] call EFUNC(common,delete);


// get the right connectorType of the antenna
private _radioConnectors = (getArray(configFile >> "CfgAcreComponents" >> ([_radioID] call acre_sys_radio_fnc_getRadioBaseClassname) >> "connectors"));
private _antennaConnectorID = {if (toLower(_x select 0) == "antenna") exitWith {_x select 1};-1;} forEach _radioConnectors;
CHECK(_antennaConnectorID < 0)

// get the connector Data
private _connectorData = ((acre_sys_data_radioData getVariable _radioID) getVariable "acre_radioConnectionData");
private _connector = {If ((_x select 1)==_antennaConnectorID) exitWith {_x};[];} forEach _connectorData;
CHECK(_connector isEqualTo [])

// remove the external antenna
[_radioID,_antennaConnectorID,_connector select 0,_connectorAttributes setVariable ["worldObject",nil],true] call acre_sys_components_fnc_attachSimpleComponent;
