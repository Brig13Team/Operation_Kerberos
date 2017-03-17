/*
    Author: Dorbedo

    Description:
        Sets teleport buttons

*/
#define INCLUDE_GUI
#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
_this params ["_dialog"];

for "_i" from 0 to 6 do {
    Private _ctrl = _dialog displayCtrl (IDD_TELEPORT_BTTN1 + _i);
    private _key = format["button_%1",(1 + _i)];
    private _hash = HASH_GET(GVAR(teleporter),_key);
    private _name = HASH_GET(_hash,"name");
    if ((isNil "_name")||{_name isEqualTo ""}) then {
        _ctrl ctrlSetText "";
        _ctrl ctrlShow false;
        _ctrl ctrlSetEventHandler ["ButtonClick",""];
        _ctrl ctrlSetTooltip "";
    } else {
        _ctrl ctrlSetText _name;
        _ctrl ctrlShow true;
        _ctrl buttonSetAction format["['%1'] call %2;",_key,QFUNC(teleport)];
        _ctrl ctrlSetTooltip "";
    };
};
