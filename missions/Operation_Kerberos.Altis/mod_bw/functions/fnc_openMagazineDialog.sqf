#include "..\script_component.hpp"

params [["_vehicle", objNull, [objNull]], ["_turret", [0], [[]]]];

If ((!alive _vehicle) || {!(createDialog "BWA3_MagazineDialog")}) exitWith {};

disableSerialization;

private _dialog = findDisplay IDD_BWA3_MAGAZINEDIALOG;
private _ctrlTable = _dialog displayCtrl IDC_BWA3_MAGAZINEDIALOG_CONTROLSTABLE;

_dialog setVariable ["BWA3_comp_ace_magazineDialog_vehicle", _vehicle];
_dialog setVariable ["BWA3_comp_ace_magazineDialog_turret", _turret];

(ctAddHeader _ctrlTable) params ["_headerindex", "_headercontrols"];
_headercontrols params ["_background", "_headertext"];
_background ctrlSetBackgroundColor [
    (profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13]),
    (profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54]),
    (profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21]),
    0.5
];
_headertext ctrlsetText getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");

private _hash = [] call CBA_fnc_hashCreate;
_dialog setVariable ["BWA3_comp_ace_magazineDialog_hash", _hash];
private _MaxMagazineAmount = _vehicle getVariable ["BWA3_maxMagazineLoad", count (getArray((_this call CBA_fnc_getTurret) >> "magazines"))];
_dialog setVariable ["BWA3_comp_ace_magazineDialog_MaxMagazineAmount", _MaxMagazineAmount];
private _Weapons = _vehicle weaponsTurret _turret;
private _curMagazinesTurret = (((magazinesAllTurrets _vehicle) select {((_x select 1) isEqualTo _turret) && ((_x select 2) > 0)})) apply {_x select 0};

{
    private _possibleMagazines = getArray(configFile >> "CfgWeapons" >> _x >> "magazines");
    _possibleMagazines = _possibleMagazines select {
        (_x isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"]) ||
        {getNumber(configFile >> "CfgMagazines" >> _x >> "scope") isEqualTo 1}
    };

    {
        private _curMag = _x;
        [_hash, _curMag, [({_x == _curMag} count _curMagazinesTurret) min _MaxMagazineAmount]] call CBA_fnc_hashSet;
        nil
    } count _possibleMagazines;
    nil
} count (_vehicle weaponsTurret _turret);

#define UPDATE_VALUES private _curMagazinesAmout = ((ctrlParent _ctrl) getVariable "BWA3_comp_ace_magazineDialog_MaxMagazineAmount") - _value; \
{ \
    ([_hash, _x] call CBA_fnc_hashGet) params ["_curAmount", "_ctrlSlider", "_ctrlEdit"]; \
    If ((_curMagazinesAmout - _curAmount) <= 0) then { \
        _curAmount = _curMagazinesAmout; \
        _ctrlSlider sliderSetPosition _curAmount; \
        _ctrlEdit ctrlsetText str _curAmount; \
        [_hash, _x, [_curAmount, _ctrlSlider, _ctrlEdit]] call CBA_fnc_hashSet; \
    }; \
    _curMagazinesAmout = _curMagazinesAmout - _curAmount; \
    nil \
} count (([_hash] call CBA_fnc_hashKeys) - [_curMagazine]); \
[_hash, _curMagazine, [_value, _ctrlSlider, _ctrlEdit]] call CBA_fnc_hashSet

#define GET_VALUES private _curMagazine = _ctrl getVariable "BWA3_comp_ace_magazineDialog_magazineClass"; \
private _hash = (ctrlParent _ctrl) getVariable "BWA3_comp_ace_magazineDialog_hash"; \
([_hash, _curMagazine] call CBA_fnc_hashGet) params ["_curAmount", "_ctrlSlider", "_ctrlEdit"]

{
    private _curMagazine = _x;
    ([_hash, _curMagazine] call CBA_fnc_hashGet) params ["_curMagazineAmount"];

    (ctAddRow _ctrlTable) params ["_index","_controls"];
    _controls params ["_background","_ctrlText","_ctrlSlider","_ctrlEdit"];
    _ctrlText ctrlsetText getText(configFile >> "CfgMagazines" >> _curMagazine >> "displayNameShort");

    _ctrlSlider sliderSetRange [0, _MaxMagazineAmount];
    _ctrlSlider sliderSetPosition _curMagazineAmount;
    _ctrlSlider setVariable ["BWA3_comp_ace_magazineDialog_magazineClass", _curMagazine];

    _ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
        params ["_ctrl", "_value"];
        GET_VALUES;
        _value = round _value;
        _ctrlEdit ctrlSetText (str _value);
        UPDATE_VALUES;
    }];

    _ctrlEdit ctrlSetText str _curMagazineAmount;
    _ctrlEdit setVariable ["BWA3_comp_ace_magazineDialog_magazineClass", _curMagazine];
    _ctrlEdit ctrlAddEventHandler ["KeyUp", {
        params ["_ctrl"];
        GET_VALUES;
        private _value = parseNumber ctrlText _ctrlEdit;
        _ctrlSlider sliderSetPosition (round _value);
        UPDATE_VALUES;
    }];
    _ctrlEdit ctrlAddEventHandler ["KillFocus", {
        params ["_ctrl"];
        GET_VALUES;
        private _value = sliderPosition _ctrlSlider;
        _value = round _value;
        _ctrlEdit ctrlSetText (str _value);
        UPDATE_VALUES;
    }];

    [_hash, _curMagazine, [_curMagazineAmount, _ctrlSlider, _ctrlEdit]] call CBA_fnc_hashSet;
    nil
} count ([_hash] call CBA_fnc_hashKeys);

_dialog displayAddEventHandler ["Unload", {
    params ["_dialog","_exitCode"];
    if !(_exitCode isEqualTo 1) exitWith {};

    private _vehicle = _dialog getVariable "BWA3_comp_ace_magazineDialog_vehicle";
    private _turret = _dialog getVariable "BWA3_comp_ace_magazineDialog_turret";
    private _hash = _dialog getVariable "BWA3_comp_ace_magazineDialog_hash";

    private _magazines = [];
    {
        private _curMagazine = _x;
        ([_hash, _curMagazine] call CBA_fnc_hashGet) params ["_amount"];

        // make sure to remove magazines before adding magazines
        private _curAmount = {(_x select 0) isEqualTo _curMagazine} count ((magazinesAllTurrets _vehicle) select {((_x select 1) isEqualTo _turret) && ((_x select 2) > 0)});
        If (_curAmount < _amount) then {
            _magazines pushBack [_curMagazine, _amount];
        };
        If (_curAmount > _amount) then {
            _magazines = [[_curMagazine, _amount]] + _magazines;
        };
        nil;
    } count ([_hash] call CBA_fnc_hashKeys);

    [BWA3_fnc_loadMagazines, [_vehicle, _turret, _magazines]] call CBA_fnc_execNextFrame;
}];
