/*
    Author: Dorbedo

    Description:
    boxes - mass handling

*/
#include "script_component.hpp"
PARAMS_2(_mode,_param);
switch (_mode) do {
    case "check" : {
        private["_config","_mass_new","_mass_current","_mass_max"];
        _config = _param;
        _mass_new = ["getmass",_config] call FM(ui_crate_mass);
        _mass_current = ["currentmass"] call FM(ui_crate_mass);
        _mass_max = (DORB_CRATE_BOXES select 2) select DORB_CRATE_CURRENT_BOXID;
        _return=!((_mass_current+_mass_new)<_mass_max);
        _return
    };
    case "currentmass" : {
        private["_mass_current","_mass"];
        _mass_current = 0;
        for "_i" from 0 to ((count (DORB_CRATE_CURRENT select 0))-1) do {
            _mass = ["getmass",((DORB_CRATE_CURRENT select 0)select _i)] call FM(ui_crate_mass);
            _mass = _mass * ((DORB_CRATE_CURRENT select 1)select _i);
            _mass_current = _mass_current + _mass;
        };
        for "_i" from 0 to ((count (DORB_CRATE_CURRENT select 2))-1) do {
            _mass = ["getmass",((DORB_CRATE_CURRENT select 2)select _i)] call FM(ui_crate_mass);
            _mass = _mass * ((DORB_CRATE_CURRENT select 3)select _i);
            _mass_current = _mass_current + _mass;
        };
        _mass_current
    };
    case "getmass" : {
        private["_mass"];
        _mass = getnumber (_param>>"mass");
        If (_mass == 0) then {
            _mass = getnumber (_param>>"ItemInfo">>"mass");
            If (_mass == 0) then {
                _mass = getnumber (_param>>"WeaponSlotsInfo">>"mass");
            };
        };
        _mass
    };
    case "displaymass" : {
        private["_ctrl","_mass_current","_mass_max","_status"];
        _ctrl = findDisplay 600200 displayCtrl 600204;
        _mass_current = ["currentmass"] call FM(ui_crate_mass);
        _mass_max = (DORB_CRATE_BOXES select 2) select DORB_CRATE_CURRENT_BOXID;
        _status=(_mass_current / _mass_max) min 1;
        _ctrl progressSetPosition _status;
    };
    case "changebox" : {
        private["_mass_current","_mass_max","_values"];
        _mass_current = ["currentmass"] call FM(ui_crate_mass);
        _mass_max = (DORB_CRATE_BOXES select 2) select DORB_CRATE_CURRENT_BOXID;
        _values=[];
        If (_mass_current > _mass_max) then {
            If (count(DORB_CRATE_CURRENT select 2)>0) then {
                _values = DORB_CRATE_CURRENT select 3;
                _values set [((count _values)-1),((_values select((count _values)-1))-1)];
                If ((_values select((count _values)-1))<1) then {
                    ["cleanupcurrent"] call FM(ui_crate_mass);
                };
            }else{
                _values=DORB_CRATE_CURRENT select 1;
                _values set [((count _values)-1),((_values select((count _values)-1))-1)];
                If ((_values select((count _values)-1))<1) then {
                    ["cleanupcurrent"] call FM(ui_crate_mass);
                };
            };
            _mass_current = ["currentmass"] call FM(ui_crate_mass);
            _mass_max = (DORB_CRATE_BOXES select 2) select DORB_CRATE_CURRENT_BOXID;
            If (_mass_current > _mass_max) then {
                ["changebox"] call FM(ui_crate_mass);
            };
            [1]call FM(ui_crate_filter);
        };
        ["displaymass"] call FM(ui_crate_mass);
    };
    case "cleanupcurrent" : {
        {
            private["_selection","_selection_value"];
            _selection = DORB_CRATE_CURRENT select _x;
            _selection_value = DORB_CRATE_CURRENT select (_x+1);
            for [{_i = (count _selection_value)},{_i > -1},{_i = _i - 1}] do {
                If ((_selection_value select _i)<1) then {
                    _selection deleteAt _i;
                    _selection_value deleteAt _i;
                };
            };
            DORB_CRATE_CURRENT set [_x,_selection];
            DORB_CRATE_CURRENT set [(_x+1),_selection_value];
        }forEach [0,2];
    };
};