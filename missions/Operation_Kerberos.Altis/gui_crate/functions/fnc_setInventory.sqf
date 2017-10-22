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
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_ctrlBttn"];

private _display = ctrlParent _ctrlBttn;
private _ctrlBoxes = _display displayCtrl IDC_GUI_CRATE_BOXLIST;

private _curBoxSelectVal = _ctrlBoxes lbValue (lbCurSel _ctrlBoxes);
private _curBoxSelectData = _ctrlBoxes lbData (lbCurSel _ctrlBoxes);

// new box needs to be spawned, but the space is taken
If ((_curBoxSelectVal isEqualTo 0)&&{!([] call FUNC(checkPosEmpty))}) exitWith {
    [LSTRING(ERRORMSG),LSTRING(NOTEMPTY),"red"] call EFUNC(gui,message);
};

private _curBox = objNull;
If (_curBoxSelectVal isEqualTo 0) then {
    _curBox = createVehicle [_curBoxSelectData, ASLtoAGL GVAR(curPos),[],0,"NONE"];
    _curBox setPosASL GVAR(curPos);
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

private _Combocontrol = _display displayCtrl IDC_GUI_CRATE_BOXLIST;
TRACEV_4(_Combocontrol,(lbCurSel _Combocontrol),(_Combocontrol lbValue (lbCurSel _Combocontrol)),(_Combocontrol lbData (lbCurSel _Combocontrol)));
private _containersize = if ((_Combocontrol lbValue (lbCurSel _Combocontrol)) isEqualTo 0) then {
    [(_Combocontrol lbData (lbCurSel _Combocontrol))] call FUNC(getContainerSize);
} else {
    [(_Combocontrol lbData (lbCurSel _Combocontrol)) call BIS_fnc_objectFromNetId] call FUNC(getContainerSize);
};


{
    private _curCfgString = _x;
    private _curCfgArray = [_curCfgString,[]] call BIS_fnc_configPath;
    TRACEV_1(_curCfgArray);
    private _amount = [_curCfgString] call FUNC(getCurAmount);
    // check if the item can be added
    private _MassChange = [_curCfgString,_amount] call FUNC(getMass);
    TRACEV_3(_amount,_masschange,_containersize);
    If ((_MassChange > _containersize)&&{_amount > 1}) then {
        // reduce the amount
        _MassChange = [_curCfgString,1] call FUNC(getMass);
        private _newAmount = 0;
        while {_newAmount < _amount} do {
            _containersize = _containersize - _massChange;
            If (_containersize < 0) exitWith {
                _amount = _newAmount;
            };
            _newAmount = _newAmount + 1;
        };
    } else {
        _containersize = _containersize - _MassChange;
    };

    If ((_curCfgArray select 1) == "CfgVehicles") then {
        [_curBox,(_curCfgArray select 2),_amount] call CBA_fnc_addBackpackCargo;
    } else {
        TRACEV_4(_curBox,_curCfgArray,(([(_curCfgArray select 2)] call ace_common_fnc_getItemType) select 0),_amount);
        switch (([(_curCfgArray select 2)] call ace_common_fnc_getItemType) select 0) do {
            case "weapon" : {
                [_curBox,(_curCfgArray select 2),_amount] call CBA_fnc_addWeaponCargo;
            };
            case "magazine" : {
                [_curBox,(_curCfgArray select 2),_amount] call CBA_fnc_addMagazineCargo;
            };
            default {
                [_curBox,(_curCfgArray select 2),_amount] call CBA_fnc_addItemCargo;
            };
        };
    };
    If (_containersize < 0) exitWith {
        [LSTRING(ERRORMSG),LSTRING(OVERLOAD),"red"] call EFUNC(gui,message);
        TRACE("Container is full");
    };
} forEach HASH_KEYS(GVAR(curinventory));

[QEGVAR(gui_arsenal,cleanCargo),_curBox] call CBA_fnc_localEvent;

_display closeDisplay 0;
[] call EFUNC(gui_main,close);
