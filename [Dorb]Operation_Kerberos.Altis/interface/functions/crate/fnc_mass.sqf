/*
    Author: Dorbedo

    Description:
    boxes - mass handling

*/
#include "script_component.hpp"
SCRIPT(mass);
_this params ["_mode","_param"];
switch (_mode) do {
    case "check" : {
        private["_config","_mass_new","_mass_current","_mass_max"];
        _param params ["_config","_amount"];
        _mass_new = ["getmass",[_config,_amount]] call FUNC(crate_mass);
        _mass_current = ["currentmass"] call FUNC(crate_mass);
        _mass_max = (GVAR(crate_boxes) select 2) select GVAR(crate_current_boxid);
        _return=!((_mass_current+_mass_new)<_mass_max);
        _return
    };
    case "currentmass" : {
        private["_mass_current","_mass"];
        _mass_current = 0;
        for "_i" from 0 to ((count (GVAR(crate_current) select 0))-1) do {
            _mass = ["getmass",((GVAR(crate_current) select 0)select _i)] call FUNC(crate_mass);
            _mass = _mass * ((GVAR(crate_current) select 1)select _i);
            _mass_current = _mass_current + _mass;
        };
        for "_i" from 0 to ((count (GVAR(crate_current) select 2))-1) do {
            _mass = ["getmass",((GVAR(crate_current) select 2)select _i)] call FUNC(crate_mass);
            _mass = _mass * ((GVAR(crate_current) select 3)select _i);
            _mass_current = _mass_current + _mass;
        };
        _mass_current
    };
    case "getmass" : {
        private["_mass"];
		_param params ["_config","_amount"];
		If (isNil "_amount") then {_amount = 1;};
        _mass = getnumber (_config>>"mass");
        If (_mass == 0) then {
            _mass = getnumber (_config>>"ItemInfo">>"mass");
            If (_mass == 0) then {
                _mass = getnumber (_config>>"WeaponSlotsInfo">>"mass");
            };
        };
        (_mass * _amount)
    };
    case "displaymass" : {
        private["_ctrl","_mass_current","_mass_max","_status"];
        _ctrl = findDisplay 600200 displayCtrl 600204;
        _mass_current = ["currentmass"] call FUNC(crate_mass);
        _mass_max = (GVAR(crate_boxes) select 2) select GVAR(crate_current_boxid);
        _status=(_mass_current / _mass_max) min 1;
        _ctrl progressSetPosition _status;
    };
    case "changebox" : {
        private["_mass_current","_mass_max","_values"];
        _mass_current = ["currentmass"] call FUNC(crate_mass);
        _mass_max = (GVAR(crate_boxes) select 2) select GVAR(crate_current_boxid);
        _values=[];
        If (_mass_current > _mass_max) then {
            If (count(GVAR(crate_current) select 2)>0) then {
                _values = GVAR(crate_current) select 3;
                _values set [((count _values)-1),((_values select((count _values)-1))-1)];
                If ((_values select((count _values)-1))<1) then {
                    ["cleanupcurrent"] call FUNC(crate_mass);
                };
            }else{
                _values=GVAR(crate_current) select 1;
                _values set [((count _values)-1),((_values select((count _values)-1))-1)];
                If ((_values select((count _values)-1))<1) then {
                    ["cleanupcurrent"] call FUNC(crate_mass);
                };
            };
            _mass_current = ["currentmass"] call FUNC(crate_mass);
            _mass_max = (GVAR(crate_boxes) select 2) select GVAR(crate_current_boxid);
            If (_mass_current > _mass_max) then {
                ["changebox"] call FUNC(crate_mass);
            };
            [1]call FUNC(crate_filter);
        };
        ["displaymass"] call FUNC(crate_mass);
    };
    case "cleanupcurrent" : {
        {
            private["_selection","_selection_value"];
            _selection = GVAR(crate_current) select _x;
            _selection_value = GVAR(crate_current) select (_x+1);
            for [{_i = (count _selection_value)},{_i > -1},{_i = _i - 1}] do {
                If ((_selection_value select _i)<1) then {
                    _selection deleteAt _i;
                    _selection_value deleteAt _i;
                };
            };
            GVAR(crate_current) set [_x,_selection];
            GVAR(crate_current) set [(_x+1),_selection_value];
        }forEach [0,2];
    };
};