/*
 *  Author: iJesuz
 *
 *  Description:
 *      - choose random weighted main mission
 *      - if first parameter is a string then a side mission
 *        is choosen for the given main mission
 *
 *  Parameter(s):
 *      0 : STRING  - (optional) mission name
 *
 *  Returns:
 *      STRING
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_name", "", [""]]];

private "_mainOrSide";
if (_name isEqualTo "") then {
    _mainOrSide = "main";
} else {
    _mainOrSide = "side";
};
/*
private _classes = "true" configClasses (ConfigFile >> "CfgKerberos" >> "mission" >> _mainOrSide)
                        select { !(([configName _x, 0, 2] call CBA_fnc_substr) isEqualTo "__") AND !((configName _x) isEqualTo "rtb") } // non playable missions
                        select { if !(isText(_x >> "condition")) then { true } else { [] call compile getText(_x >> "condition") } };
*/
private _classes = configProperties [
    (ConfigFile >> "CfgKerberos" >> "mission" >> _mainOrSide),
    "(!(((configName _x) select [0,2]) isEqualTo '__'))",
    true
];

_classes = _classes select {
    if !(isText(_x >> "condition")) then { true } else { [] call compile getText(_x >> "condition") }
};
TRACEV_3(_classes,_mainOrSide,_name);
if (_mainOrSide isEqualTo "side") then {
    private _types = getArray(ConfigFile >> "CfgKerberos" >> "mission" >> "main" >> _name >> "side" >> "types") apply { ConfigFile >> "CfgKerberos" >> "mission" >> "side" >> _x };
    _classes = _classes select { count ([_x,false] call BIS_fnc_returnParents arrayIntersect _types) > 0 };
};

if (_classes isEqualTo []) exitWith { "" };

configName ([_classes, _classes apply { getNumber(_x >> "probability") }] call BIS_fnc_selectRandomWeighted)
