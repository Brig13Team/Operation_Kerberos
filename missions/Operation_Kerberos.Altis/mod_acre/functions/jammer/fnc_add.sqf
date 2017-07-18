/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Adds a jammer to an object
 *
 *  Parameter(s):
 *      0 : OBJECT - The jammer Object
 *      1 : STRING - The acre Antenna
 *      2 : ARRAY - Anntenna direction array
 *      3 : ARRAY - Offsetposition of the antenna
 *      4 : SCALAR - the mW of the jammer
 *      5 : ARRAY - the jammed frequency range (empty array means full range)
 *
 *  Returns:
 *      none
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
    ["_f",[],[[]],[2]]  // jammed frequencies [min,max] - if not given, everything is jammed
];

// [cursorObject,"ACRE_120CM_VHF_TNC",[0,0,1],[0,0,2.5],20000,[0,500]] call dorb_mod_acre_fnc_jammer_add


If !(isClass(configFile >> "CfgAcreComponents" >> _antenna)) exitWith {
    ERROR(FORMAT_1("WRONG ANTENNA: %1",_antenna));
};
_object setVariable [QGVAR(isActive),true,true];
private _jammerID = (missionNamespace getVariable [QGVAR(jammerID),0]) + 1;
GVAR(jammerID) = _jammerID;
GVAR(jammer) pushBack [_object,_jammerID,_antenna,_antennaDir,_offset,_mW,_f];

publicVariable QGVAR(jammer);

If (isNil QGVAR(jammerHandle)) then {
    GVAR(jammerHandle) = [
        {
            GVAR(jammer) = GVAR(jammer) select {alive (_x select 0)};
            If (GVAR(jammer) isEqualTo []) then {
                GVAR(jammerHandle) = nil;
                GVAR(jammer) = [];
                publicVariable QGVAR(jammer);
                [_this select 1] call CBA_fnc_removePerFrameHandler;
            };
        },
        60
    ] call CBA_fnc_addPerFrameHandler;
};
