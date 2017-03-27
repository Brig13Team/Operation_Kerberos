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
#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

_this params [["_type","",[""]],"_ctrl"];

switch _type do {
    case "ammunitiondata" : {};
    case "orderlist": {
        //_ctrl setVariable [QGVAR(orders),((vehicle player) getVariable [QGVAR(orders),[]]) + ((vehicle player) getVariable [QGVAR(localorders),[]])];
    };
    case "artillerydata" : {

        {
            _ctrl lnbAddRow [localize _x,""];
        } forEach [
            LSTRING(artData_X),
            LSTRING(artData_Y),
            LSTRING(artData_Alt),
            LSTRING(artData_Pitch),
            LSTRING(artData_Bank),
            LSTRING(artData_Temp),
            LSTRING(artData_PRES),
            LSTRING(artData_Humid)
        ];

    };
    case "display" : {
        If (isNil QGVAR(handleDisplay)) then {
            GVAR(handleDisplay) = [LINKFUNC(handleDisplay),1,[_ctrl]] call CBA_fnc_addPerFrameHandler;
        };
        GVAR(curArtillery) = vehicle player;

        private _ctrlGrp = _ctrl displayCtrl IDC_ARTILLERY_PARAMS;
        private _ctrlAmmo = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_AMMO;
        private _allMags = [GVAR(curArtillery)] call FUNC(getArtilleryAmmo);
        {
            private _name = getText(configfile >> "CfgMagazines" >> _x >> "displayNameShort");
            private _index = _ctrlAmmo lbAdd _name;
            _ctrlAmmo lbSetData [_index, _x];
        } forEach _allMags;
        _ctrlAmmo setVariable ["values",_allMags];
        _ctrlAmmo lbSetCurSel 0;

        private _ctrlCharge = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_PARAMS_CHARGE;
        private _allCharges = [typeOf GVAR(curArtillery)] call FUNC(getChargeFromArtillery);
        {
            private _name = localize format[LSTRING(CHARGE_%1),_x];
            private _index = _ctrlCharge lbAdd _name;
            _ctrlCharge lbSetValue [_index, _x];
        } forEach _allCharges;
        _ctrlCharge setVariable ["values",_allCharges];
        TRACEV_1(_allCharges);
        _ctrlCharge lbSetCurSel 0;

        [] call FUNC(showFuze);
    };
    case "useCurrent" : {
        [
            {
                _this params ["_ctrl"];
                _ctrl cbSetChecked ((GVAR(curArtillery) getVariable [QGVAR(location_usecurrent),true]));
                [_ctrl] call FUNC(onCheckedChangedLoc);
            },
            [_ctrl]
        ] call CBA_fnc_execNextFrame;
    };
    case "network" : {
        _ctrl cbSetChecked ((vehicle player) getVariable [QGVAR(networkConnected),false]);
    };
    case "networkID" : {
        _ctrl ctrlSetText ((vehicle player) getVariable [QGVAR(networkID),"XX-0000"]);
    };
};
