/*
    Author: Dorbedo

    Description:
    boxes - mass handling

*/
#include "script_component.hpp"
_this params ["_mode","_param"];
switch (_mode) do {
    case "check" : {
        _param params ["_config","_amount"];
        private _mass_new = ["getmass",[_config,_amount]] call FUNC(mass);
        private _mass_current = ["currentmass"] call FUNC(mass);
        private _mass_max = (GVAR(crate_boxes) select 2) select GVAR(current_boxid);
        (!((_mass_current+_mass_new)<_mass_max));
    };
    case "currentmass" : {
        private _mass_current = 0;
        for "_i" from 0 to ((count (GVAR(current) select 0))-1) do {
            private _mass = ["getmass",((GVAR(current) select 0)select _i)] call FUNC(mass);
            _mass = _mass * ((GVAR(current) select 1)select _i);
            _mass_current = _mass_current + _mass;
        };
        for "_i" from 0 to ((count (GVAR(current) select 2))-1) do {
            private _mass = ["getmass",((GVAR(current) select 2)select _i)] call FUNC(mass);
            _mass = _mass * ((GVAR(current) select 3)select _i);
            _mass_current = _mass_current + _mass;
        };
        _mass_current
    };
    case "getmass" : {
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
        private _ctrl = findDisplay 600200 displayCtrl 600204;
        private _mass_current = ["currentmass"] call FUNC(mass);
        private _mass_max = (GVAR(crate_boxes) select 2) select GVAR(current_boxid);
        private _status=(_mass_current / _mass_max) min 1;
        _ctrl progressSetPosition _status;
    };
    case "changebox" : {
        private _mass_current = ["currentmass"] call FUNC(mass);
        private _mass_max = (GVAR(crate_boxes) select 2) select GVAR(current_boxid);
        private _values=[];
        If (_mass_current > _mass_max) then {
            If (count(GVAR(current) select 2)>0) then {
                _values = GVAR(current) select 3;
                _values set [((count _values)-1),((_values select((count _values)-1))-1)];
                If ((_values select((count _values)-1))<1) then {
                    ["cleanupcurrent"] call FUNC(mass);
                };
            }else{
                _values=GVAR(current) select 1;
                _values set [((count _values)-1),((_values select((count _values)-1))-1)];
                If ((_values select((count _values)-1))<1) then {
                    ["cleanupcurrent"] call FUNC(mass);
                };
            };
            _mass_current = ["currentmass"] call FUNC(mass);
            _mass_max = (GVAR(crate_boxes) select 2) select GVAR(current_boxid);
            If (_mass_current > _mass_max) then {
                ["changebox"] call FUNC(mass);
            };
            [1]call FUNC(filter);
        };
        ["displaymass"] call FUNC(mass);
    };
    case "cleanupcurrent" : {
        {
            private _selection = GVAR(current) select _x;
            private _selection_value = GVAR(current) select (_x+1);
            for [{_i = (count _selection_value)},{_i > -1},{_i = _i - 1}] do {
                If ((_selection_value select _i)<1) then {
                    _selection deleteAt _i;
                    _selection_value deleteAt _i;
                };
            };
            GVAR(current) set [_x,_selection];
            GVAR(current) set [(_x+1),_selection_value];
        }forEach [0,2];
    };
};