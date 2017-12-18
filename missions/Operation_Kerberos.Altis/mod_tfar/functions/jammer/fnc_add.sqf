/**
 * Author: Dorbedo
 * adds a jammer to an object
 *
 * Arguments:
 * 0: <OBJECT> the jammer object
 * 1: <SCALAR> the range of the jammer
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!isServer) exitWith {
    [QGVAR(addJammer),_this] call CBA_fnc_serverEvent;
};

params [
    ["_object",objNull,[objNull]],
    ["_range",20000,[0]]
];

_object setVariable [QGVAR(isActive),true,true];
private _jammerID = (missionNamespace getVariable [QGVAR(jammerID),0]) + 1;
GVAR(jammerID) = _jammerID;
GVAR(jammer) pushBack [_object,_jammerID,_range];

publicVariable QGVAR(jammer);

If (isNil QGVAR(jammerHandle)) then {
    GVAR(jammerHandle) = [
        {
            private _jammer = GVAR(jammer) select {alive (_x select 0)};
            If (_jammer isEqualTo []) exitWith {
                GVAR(jammerHandle) = nil;
                GVAR(jammer) = [];
                publicVariable QGVAR(jammer);
                [_this select 1] call CBA_fnc_removePerFrameHandler;
            };
            If !(GVAR(jammer) isEqualTo _jammer) then {
                GVAR(jammer) = _jammer;
                publicVariable QGVAR(jammer);
            };
        },
        60
    ] call CBA_fnc_addPerFrameHandler;
};

[QGVAR(activateJammer)] call CBA_fnc_globalEvent;
