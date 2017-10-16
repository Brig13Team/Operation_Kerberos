/**
 * Author: Dorbedo
 * sets the inventory
 *
 * Arguments:
 * 0: <CONTROL> the Button
 *
 * Return Value:
 * Nothing
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_ctrlBttn"];

private _display = ctrlParent _ctrlBttn;
private _ctrlBoxes = _display displayCtrl IDC_GUI_CRATE_BOXLIST;

private _curBoxSelectVal = _ctrlBoxes lbValue (lbCurSel _ctrlBoxes);
private _curBoxSelectData = _ctrlBoxes lbData (lbCurSel _ctrlBoxes);

// new box needs to be spawned, but the space is taken
If ((_curBoxSelectVal isEqualTo 0)&&{!(call FUNC(checkPosEmpty))}) exitWith {
    [LSTRING(ERRORMSG),LSTRING(NOTEMPTY),"red"] call EFUNC(gui,message);
};

private _curBox = objNull;
If (_curBoxSelectVal isEqualTo 0) then {
    _curBox = createVehicle [_curBoxSelectData, ASLtoAGL GVAR(curPos),[],0,"NONE"];
    _curBox setDir GVAR(curDir);
} else {
    _curBox = _curBoxSelectData call BIS_fnc_objectFromNetId;
};

If (isNull _curBox) exitWith {
    [LSTRING(ERRORMSG),LSTRING(NOBOX),"red"] call EFUNC(gui,message);
};

clearBackpackCargoGlobal _curBox;
clearWeaponCargoGlobal _curBox;
clearMagazineCargoGlobal _curBox;
clearItemCargoGlobal _curBox;

{
    private _curCfgString = _x;
    private _curCfgArray = [_curCfgString,[]] call BIS_fnc_configPath;
    TRACEV_1(_curCfgArray);
    If ((_curCfgArray select 1) == "CfgVehicles") then {
        [_curBox,_curCfgArray select 2,[_curCfgString] call FUNC(getCurAmount)] call CBA_fnc_addBackpackCargo;
    } else {
        TRACEV_1((([_curCfgArray select 2] call ace_common_fnc_getItemType) select 0));
        switch (([_curCfgArray select 2] call ace_common_fnc_getItemType) select 0) do {
            case "weapon" : {
                [_curBox,_curCfgArray select 2,[_curCfgString] call FUNC(getCurAmount)] call CBA_fnc_addWeaponCargo;
            };
            case "magazine" : {
                [_curBox,_curCfgArray select 2,[_curCfgString] call FUNC(getCurAmount)] call CBA_fnc_addMagazineCargo;
            };
            default {
                [_curBox,_curCfgArray select 2,[_curCfgString] call FUNC(getCurAmount)] call CBA_fnc_addItemCargo;
            };
        };
    };
} forEach HASH_KEYS(GVAR(curinventory));


_display closeDisplay 0;
[] call EFUNC(gui_main,close);
