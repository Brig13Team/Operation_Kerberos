/*
	Author: Dorbedo

	Description:
	gets vehiclelist, creates dialog, spawns vehicles.

	Parameter(s):
		
		TO DO

*/
#include "script_component.hpp"

#define dlg_spawn_idd				471470
#define dlg_spawn_hintergrund_idd 	471471
#define dlg_spawn_liste_idc			471472

#define dlg_spawn_name_idc			471473
#define dlg_spawn_bild1_idc			471474
#define dlg_spawn_bild2_idc			471475
#define dlg_spawn_beschreibung_idc	471476
#define dlg_spawn_ok_idc			471477
#define dlg_spawn_close_idc			471478

d_log(FORMAT_1("Spawn - this=%1",_this))

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_paramarray = _this select 3;
_spawn = _paramarray select 0;
_dir = _paramarray select 1;
_spawnpos = getmarkerpos _spawn;
_check_radius = 10;//radius for vehicle spawn pad check and delete

_vehiclelist = GETVAR(_host,DORB_SPAWNLIST,[]);
//_vehiclelist = _host getVariable "DORB_SPAWNLIST";


[[_host,_caller],3]call dorb_fnc_debug;

CHECK((count _vehiclelist)<1)

//if (isnil "_vehiclelist") exitwith {hint "Fahrzeugliste nicht initialisiert";};


{if (count crew _x == 0) then {deletevehicle _x};} foreach (nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]);
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["allDead"], _check_radius];
{deleteVehicle _x;} forEach nearestObjects [_spawnpos,["Thing"], _check_radius];

disableSerialization;
createDialog "dlg_spawn";
sleep 0.1;
_ctrlList = findDisplay dlg_spawn_idd displayCtrl dlg_spawn_liste_idc;

private ["_index","_lstidx","_lstpos""_i"];

for "_i" from 0 to (count _vehiclelist)-1 do {
	_vehicle = _vehiclelist select _i;
	lbAdd [dlg_spawn_liste_idc,format["%1",_vehicle select 1]];
	lbSetPicture [dlg_spawn_liste_idc, _i, _vehicle select 2];
	lbSetValue [dlg_spawn_liste_idc, _i, _i];
};
lbSort (findDisplay dlg_spawn_idd displayCtrl dlg_spawn_liste_idc); 


_index = -1;
_i=(_index -9) max 0;
lbSetCurSel [dlg_spawn_liste_idc, _i];
lbSetCurSel [dlg_spawn_liste_idc, _index];

_ctrlbild2 = findDisplay dlg_spawn_idd displayCtrl dlg_spawn_bild2_idc;
_ctrlName = findDisplay dlg_spawn_idd displayCtrl dlg_spawn_name_idc;
_ctrlDesc = findDisplay dlg_spawn_idd displayCtrl dlg_spawn_beschreibung_idc;

_VEHidx = lbValue [dlg_spawn_liste_idc, _index];
_lstidx = _index;
_lstpos = -1;
dlg_spawn_ausgewaehlt = false;

		while {ctrlVisible dlg_spawn_liste_idc} do 
		{
			_index = lbCurSel dlg_spawn_liste_idc;
			_posidx = _index;
			
			if (dlg_spawn_ausgewaehlt) then {
				_VEHidx=lbValue [dlg_spawn_liste_idc, _index];
				closeDialog dlg_spawn_idd;
			};
			if (_posidx == -1) then {
				_posidx = _index;
			};
			if (_lstpos != _posidx) then {
				_lbidx = lbValue [dlg_spawn_liste_idc, _posidx];
				_wDName = (_vehiclelist select _lbidx) select 1;
				_wbild2 = (_vehiclelist select _lbidx) select 4;
				_wDesc = (_vehiclelist select _lbidx) select 3;
				_wbild2 = (_vehiclelist select _lbidx) select 4;
				_ctrlbild2 ctrlSetText _wbild2;
				_ctrlName ctrlSetText _wDName;
				_ctrlDesc ctrlSetStructuredText parseText (_wDesc);
				_lstpos=_posidx;
			};
			sleep 0.1;
		};
	if (_lstidx == _index) exitWith {};
	_VEHsel=(_vehiclelist select _VEHidx) select 0;

	if (isnil "dlg_spawn_auswahl") exitwith {_caller groupchat "Es wurde nichts geliefert.";};
	if (dlg_spawn_auswahl != "nein" && dlg_spawn_ausgewaehlt) then {
	_veh_name = getText (configFile >> "cfgVehicles" >> (_vehsel) >> "displayName");
	_padempty = nearestObjects [_spawnpos, ["LandVehicle","Air"], _check_radius];
	
	if (count _padempty > 0) exitwith {hint "Spawn ist nicht leer.";};
	
	_veh1 = createVehicle [_vehsel,_spawnpos, [], 0, "NONE"];
	_veh1 setdir _dir;
	
	if ((_veh1 isKindOf "SDV") or (_veh1 isKindOf "Ship")) then {
	_veh1 setPosASL [getPosASL _veh1 select 0, getPosASL _veh1 select 1, 0];
	} else {
	_veh1 setposatl [_spawnpos select 0, _spawnpos select 1, 0.2];
	_veh1 setVectorUP (surfaceNormal [(getPosatl _veh1) select 0,(getPosatl _veh1) select 1]);
	};
	
	if (_spawn=="drone_spawn") then {
		createVehicleCrew _veh1;
	};
	/*
	if ((_veh1 isKindOf "B_Truck_01_medical_F") or (_veh1 isKindOf "B_Slingload_01_Medevac_F")) then {
		_veh1 setvariable[QGVAR(isMedicalFacility), true, true];
	};
	*/
	
	hint format ["%1 geliefert", _veh_name];
} else {hint "Es wurde nichts geliefert.";};