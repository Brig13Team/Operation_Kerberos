/*
    Author: Dorbedo

    Description:
        Opens the arsenal

*/
#include "script_component.hpp"

If (GVAR(fullArsenal)) then {
    ["Open",true] spawn BIS_fnc_arsenal;
}else{
    private _boxes = (missionnamespace getvariable [QGVAR(arsenal_boxes),[]]);
    If (_boxes isEqualTo []) exitWith {};
    ["Open",[nil,selectRandom (_boxes),player]] call bis_fnc_arsenal;
};
