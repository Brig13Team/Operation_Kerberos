/**
 * Author: Dorbedo
 * spawns an offmap Air-support
 *
 * Arguments:
 * 0: <ARRAY> the target position
 * 1: <STRING> the type
 * 2: <CODE> callback
 *
 * Return Value:
 * <TYPENAME> return name
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [
    ["_target", [], [[], objNull], [2, 3]],
    ["_type","",[""]],
    ["_callback", {}, [{}]],
    ["_callbackParams", []]
];

if (isNil QGVARMAIN(side_type)) then {
    [] call FUNC(army_set);
};

switch (_type) do {
    case "plane_bomb" : {
        [_target,"cluster",_callback,_callbackParams] call FUNC(offmap_cas);
    };
    case "plane_missiles" : {
        [_target,"missiles",_callback,_callbackParams] call FUNC(offmap_cas);
    };
    case "plane_gunrun" : {
        [_target,"gattling",_callback,_callbackParams] call FUNC(offmap_cas);
    };
    case "airdrop" : {
        [_target,_callback,_callbackParams] call FUNC(offmap_airdrop);
    };
    case "dronestrike" : {
        [_target,_callback,_callbackParams] call FUNC(offmap_dronestrike);
    };
    case "tankdrop" : {
        [
            _target,
            ["ifv"] call FUNC(getUnit),
            _callback,
            _callbackParams
        ] call FUNC(offmap_vehicledrop);
    };
    case "airinterception" : {

    };
};
