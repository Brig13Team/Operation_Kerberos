/*
	Author: Dorbedo
	
	Description:
		Teleports player to Destination choosen by dialog
	
*/
#include "script_component.hpp"

private ["_aktion", "_control","_num_schalter","_teleport_idd","_teleport_idc_btn1"];
_teleport_idd = 470470;
_teleport_idc_btn1 = 470471;
_aktion = _this select 0;
_control = _this select 1;
_num_schalter = 0.5 * (ctrlIDC _control - teleport_idc_btn1) + 1;
switch (_aktion) do	{
	case "enter": 	{	findDisplay teleport_idd displayCtrl (ctrlIDC _control+1) ctrlSetText format ["basis\dlg\img\btn%1_aktiv.paa", _num_schalter];};
	case "exit"	: 	{	findDisplay teleport_idd displayCtrl (ctrlIDC _control+1) ctrlSetText format ["basis\dlg\img\btn%1.paa", _num_schalter];};
	case "click":	{
						closeDialog 0;
						switch (_num_schalter) do {
							case 1:{player setposatl [getmarkerpos "Respawn_West" select 0,getmarkerpos "Respawn_West" select 1,0.2];};
							case 2:{player setposatl [getmarkerpos "teleport_fahrzeuge" select 0,getmarkerpos "teleport_fahrzeuge" select 1,0.2];};
							case 3:{player setposatl [getmarkerpos "teleport_luftwaffe" select 0,getmarkerpos "teleport_luftwaffe" select 1,0.2];};
							case 4:{player setposatl [getmarkerpos "teleport_drohnen" select 0,getmarkerpos "teleport_drohnen" select 1,0.2];};
							case 5:{player setposatl [getmarkerpos "teleport_hafen" select 0,getmarkerpos "teleport_hafen" select 1,2];};
							case 6:{player setposatl [getmarkerpos "teleport_logistik" select 0,getmarkerpos "teleport_logistik" select 1,0.2];};		
		};
	};
};