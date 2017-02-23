/*
 *  Author: [Name of Author(s)]
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


if (!isServer) exitWith {
    [QGVAR(addJammer),_this] call CBA_fnc_serverEvent;
};

_this params [
    ["_object",objNull,[objNull]],
    ["_antenna","ACRE_120CM_VHF_TNC",[""]],
    ["_antennaDir",[0,0,1],[[]],[3]],
    ["_offset",[0,0,2.5],[[]],[3]],
    ["_mW",20000,[0]],
    ["_f",[0,500],[[]],[2]]  // jammed frequencies [min,max] - if not given, everything is jammed
];

If !(isClass(configFile >> "CfgAcreComponents" >> _antenna)) exitWith {
    ERROR(FORMAT_1("WRONG ANTENNA: %1",_antenna));
};
_object setVariable [QGVAR(isActive),true,true];
private _jammerID = (missionNamespace getVariable [QGVAR(jammerID),0]) + 1;
GVAR(jammerID) = _jammerID;
GVAR(jammer) pushBack [_object,_jammerID,_antenna,_antennaDir,_offset,_mW,_f];

publicVariable QGVAR(jammer);
