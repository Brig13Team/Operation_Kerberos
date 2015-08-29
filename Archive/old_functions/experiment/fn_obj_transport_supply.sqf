/*
	Author: Dorbedo

	Description:
	Creates Mission "Rescue".
	
	Requirements:
		SHK_Taskmaster

	Parameter(s):
		0 :	ARRAY - Position
		1 :	ARRAY - Trigger Area [A,B,Winkel,BOOL]
		2 : STRING - Aufgabenname für Taskmaster
		3 : STRING - Name des Missionsortes
		4 : ARRAY - Namen der Geiseln

	Returns:
	Trigger - Serverside with Rescue
*/
if (!isServer) exitWith {};

private["_position","_task","_ort","_position_rescue","_pow"];

_position=_this select 0;
_task=_this select 1;
_start = _this select 2;
_ende = _this select 3;
_ort = _this select 4;


_aufgabenname = format ["Liefern Sie Versorgungsgüter nach %1.",_ort];
_beschreibung = format ["Bringen sie die Versorgungsgüter sicher nach %1. Achtung, es wurden verstärkt Feindpatroullien gesichtet.",_ort];

[_task,_aufgabenname,_beschreibung,true,[],"created",_position] call SHK_Taskmaster_add;

_vehicle = createVehicle ["B_Truck_01_box_F", _start, [], 0, "FLY"];

aufgabenstatus=true;

waitUntil{
	(((_vehicle distance _ende < 20)and(alive _vehicle)and(!(player in vehicle)))or !(alive _vehicle))
};

If (alive _vehicle) then {
[_task,"succeeded"] call SHK_Taskmaster_upd;

}else{
[_task,"failed"] call SHK_Taskmaster_upd;
};

deleteVehicle _vehicle;