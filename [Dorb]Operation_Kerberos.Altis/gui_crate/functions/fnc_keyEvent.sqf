/*
    Author: Dorbedo

    Description:
        changes the multiplicator

    Parameter:
        0:CONFIG    - Item

*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_key","_pushed"];
TRACEV_2(_key,_pushed);

If (!_pushed) exitWith {
    //(findDisplay 600200) setVariable [QGVAR(crate_multi),1];
    missionNamespace setVariable [QGVAR(crate_multi),1];
};

//private _curMulti = (findDisplay 600200) getVariable [QGVAR(crate_multi),1];
private _curMulti = missionNamespace getVariable [QGVAR(crate_multi),1];
if (_curMulti >1) exitWith {};

switch (_key) do {
    case 42 : {_curMulti = 10;};
    case 56 : {_curMulti = 100;};
};
//(findDisplay 600200) setVariable [QGVAR(crate_multi),_curMulti];
missionNamespace setVariable [QGVAR(crate_multi),_curMulti];