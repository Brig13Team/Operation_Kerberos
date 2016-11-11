/*
    Author: Dorbedo

    Description:
        Increases or decreases the number of items
        called by listbutton (+/-)

    Parameter
        0:BOOL  - Modus

*/
#include "script_component.hpp"
_this params ["_mode"];
disableSerialization;
private _ctrlList = findDisplay 600200 displayCtrl 600201;
private _row = lnbCurSelRow _ctrlList;
/// get cfg
private _config = (configfile>>(_ctrlList lnbData [_row,1])>>(_ctrlList lnbData [_row,2]));
private _istMagazin = ((_ctrlList lnbData [_row,1]) isEqualTo "CfgMagazines");
//Masscheck
private _multi = missionNamespace getVariable [QGVAR(crate_multi),1];
If (_mode && (["check",[_config,_multi]]call FUNC(mass))) exitwith {};
private _id=0;
If (_istMagazin) then {_id = 2;};
Private["_anzahl","_items","_weaponid"];
If (_config in (GVAR(current) select _id)) then {
    //Anzahl modifizieren
    _weaponid = (GVAR(current) select _id) find _config;
    _anzahl = GVAR(current) select (_id+1);
    If (_mode) then {
        _anzahl set [_weaponid, ((_anzahl select _weaponid)+_multi)];
        _ctrlList lnbsetValue [[_row,0],((_ctrlList lnbValue [_row,0])+_multi)];
    }else{
        if ((_anzahl select _weaponid)>0) then {
            _anzahl set [_weaponid, (((_anzahl select _weaponid)-_multi)max 0)];
            _ctrlList lnbsetValue [[_row,0],(((_ctrlList lnbValue [_row,0])-_multi)max 0)];
        };
    };
}else{
    //Item aufnehmen
    if(!_mode) exitwith {};
    _items = (GVAR(current) select _id);
    _anzahl = (GVAR(current) select (_id+1));
    _items set [count _items, _config];
    _anzahl set [count _anzahl, 1];
    GVAR(current) set [_id,_items];
    GVAR(current) set [(_id+1),_anzahl];
    _ctrlList lnbsetValue [[_row,0],1];
};
_ctrlList lnbSetText [ [_row, 3],format["%1",(_ctrlList lnbValue [_row,0])]];
["displaymass",_config] call FUNC(mass);