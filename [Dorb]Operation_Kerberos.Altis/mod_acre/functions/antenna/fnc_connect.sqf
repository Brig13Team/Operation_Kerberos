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

private _logic = [true] call CBA_fnc_createNamespace;
private _cfg = missionConfigFile >> "acre_antennaObjects" >> typeOf _target;
private _position = If (isText(_cfg >> "position")) then {
        _target selectionPosition getText(_cfg >> "position");
    }else{
        getArray(_cfg >> "position");
    };
private _condition = compile getText(_cfg >> "condition");

_logic attachTo [_target,_position];
_target setVariable [QGVAR(externalAntenna),_logic,true];
_target setVariable [QGVAR(externalAntenna_radioID),_radioID,true];

[
    LINKFUNC(antenna_handler),
    3,
    [_target,_radioID,_condition]
] call CBA_fnc_addPerFrameHandler;

// get the right connectorType of the antenna
private _radioConnectors = (getArray(configFile >> "CfgAcreComponents" >> ([_radioID] call acre_sys_radio_fnc_getRadioBaseClassname) >> "connectors"));
private _antennaConnectorID = {if (toLower(_x select 0) == "antenna") exitWith {_x select 1};-1;} forEach _radioConnectors;
CHECK(_antennaConnectorID < 0)

// get the connector Data
private _connectorData = ((acre_sys_data_radioData getVariable _radioID) getVariable "acre_radioConnectionData");
private _connector = {If ((_x select 1)==_antennaConnectorID) exitWith {_x};[];} forEach _connectorData;
CHECK(_connector isEqualTo [])

// add the new antenna
[_radioID,_antennaConnectorID,_connector select 0,_connectorAttributes setVariable ["worldObject",_logic],true] call acre_sys_components_fnc_attachSimpleComponent;
