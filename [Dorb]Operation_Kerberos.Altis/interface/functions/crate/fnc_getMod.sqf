/*
    Author: Dorbedo

    Description:
        returns the Mod

    Parameter:
        0:CONFIG    - Item

*/
#include "script_component.hpp"
SCRIPT(getMod);
PARAMS_1(_config);
private["_mod","_namearray"];
_mod="";
_namearray=(configname _config) splitString "_";
If ("ACE" in _namearray) then {_mod="ACE";};
If ("BWA3" in _namearray) then {_mod="BWA3";};
If ("tf" in _namearray) then {_mod="TFR";};
If (("rhs" in _namearray)||("rhsusf" in _namearray)) then {_mod="RHS";};
_mod

//// Zu träge
/*

PARAMS_1(_config);

_mod = "";


_configname = configname _config;

_configarray = [_config] call BIS_fnc_configPath;

_weapons=("CfgWeapons" in _configarray);
_blubb=("CfgVehicles" in _configarray);
_magazines=("CfgMagazines" in _configarray);

LOG_4(_configarray,_weapons,_blubb,_magazines);


_suchkriterium = "NichtsGefunden";
If ("CfgVehicles" in _configarray) then {_suchkriterium = "units";};
If ("CfgWeapons" in _configarray) then {_suchkriterium = "weapons";};
If ("CfgMagazines" in _configarray) then {_suchkriterium = "magazines";};
If ("CfgAmmo" in _configarray) then {_suchkriterium = "ammo";};

LOG_1(_suchkriterium);

//// Versuch mit der alten Überprüfung
If (_suchkriterium isEqualTo "NichtsGefunden") exitwith {
    _namearray=(configname _config) splitString "_";
    If ("ACE" in _namearray) then {_mod="ACE";};
    If ("BWA3" in _namearray) then {_mod="BWA3";};
    If ("tf" in _namearray) then {_mod="TFR";};
    If (("rhs" in _namearray)||("rhsusf" in _namearray)) then {_mod="RHS";};
    _mod
};
/////

_addon = "";
_cfgPatches = GETMVAR(GVAR(crate_patches),[]);

{
    _array=getarray(_x >> _suchkriterium);
    if({_configname == _x}count _array > 0) exitwith {_addon = configname _x;};
}foreach _cfgPatches;

LOG_1(_addon);
If (_addon == "") exitwith {""};

_namearray= _addon splitString "_";
_mod = _namearray select 0;

if (_mod in ["A3","A3Data"])exitwith {""};

_mod = toUpper _mod;
LOG_1(_mod);
_mod;

*/