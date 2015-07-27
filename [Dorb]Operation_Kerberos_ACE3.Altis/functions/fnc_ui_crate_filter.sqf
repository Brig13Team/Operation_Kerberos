/*
    Author: Dorbedo

    Description:
        Lists the filtered Items

    Parameter:
        0 : SCALAR  - ButtonID

*/
#include "script_component.hpp"
PARAMS_1(_buttonid);
private["_sel","_items","_mag","_daten","_cleanupCurrent","_getAnzahl","_getConfig","_ctrlList"];
CHECK(_buttonid<1 || _buttonid>20)
_sel = [];
_items = [];
_mag = [];
_daten = [];
_cleanupCurrent={
    {
        private["_selection","_selection_value"];
        _selection = DORB_CRATE_CURRENT select _x;
        _selection_value = DORB_CRATE_CURRENT select (_x+1);
        for [{_i = (count _selection_value)},{_i > 0},{_i = _i - 1}] do {
            If ((_selection_value select _i)<1) then {
                _selection deleteAt _i;
                _selection_value deleteAt _i;
            };
        };
        DORB_CRATE_CURRENT set [_x,_selection];
        DORB_CRATE_CURRENT set [(_x+1),_selection_value];
    }forEach [0,2];
};

If (_buttonid<2) then {
    []call(_cleanupCurrent);
    _daten = GETMVAR(DORB_CRATE_CURRENT,[]);
    _items = _daten select 0;
    _mag = _daten select 2;
}else{
    _daten = GETMVAR(DORB_CRATE_ITEMS,[]);
    _items = (_daten select (_buttonid - 2)) select 0;
    _mag = (_daten select (_buttonid - 2)) select 1;
};
CHECK(_daten isEqualTo [])
_getAnzahl = {
    PARAMS_1(_ziel);
    private["_return"];
    _return=0;
    if (_ziel in (DORB_CRATE_CURRENT select 0)) then {
        private["_id"];
        _id=(DORB_CRATE_CURRENT select 0) find _ziel;
        _return=(DORB_CRATE_CURRENT select 1)select _id;
    };
    if (_ziel in (DORB_CRATE_CURRENT select 2)) then {
        private["_id"];
        _id=(DORB_CRATE_CURRENT select 2) find _ziel;
        _return=(DORB_CRATE_CURRENT select 3)select _id;
    };
    _return
};
_getConfig = {
    PARAMS_1(_cfg);
    private["_return"];
    _return = [];
    _return=[_cfg,[]]call BIS_fnc_configPath;
    _return select 1
};

for "_i" from 0 to ((count _items) -1) do {
    _sel pushBack [[[(_items select _i)]call FM(ui_crate_getMod),"",gettext ((_items select _i)>>"displayName"),""],[[_items select _i]call(_getAnzahl)],([(_items select _i),[]]call BIS_fnc_configPath)],
};
for "_i" from 0 to ((count _mag) -1) do {
    _sel pushBack [[[(_mag select _i)]call FM(ui_crate_getMod),"",gettext ((_mag select _i)>>"displayName"),""] ,[[_mag select _i]call(_getAnzahl)] ,([(_mag select _i),[]]call BIS_fnc_configPath) ],
};

lnbClear 600201;
lnbAddArray [600201,_sel];
disableSerialization;
_ctrlList = findDisplay 600200 displayCtrl 600201;
for "_i" from 0 to ((lnbSize _ctrlList) select 0) do {
    _ctrlList lnbSetText [ [_i, 3],format["%1",(_ctrlList lnbValue [_i,0])]];
    _ctrlList lnbSetPicture [ [_i, 1],gettext(configfile>>(_ctrlList lnbData [_i,1])>>(_ctrlList lnbData [_i,2])>>"picture")];
    _ctrlList lnbSetPictureColor [[_i, 1],[1, 1, 1, 1] ];
};