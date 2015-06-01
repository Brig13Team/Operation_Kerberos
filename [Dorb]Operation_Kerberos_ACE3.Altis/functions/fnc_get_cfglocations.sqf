/*
	Author: Dorbedo
	
	Description:
		AO orte + Sortierung
	
*/
#include "script_component.hpp"

private ["_loc_civ","_loc_ind","_loc_mil","_loc_water","_loc_sonst","_cfgOrte","_mil","_ind","_i","_pow","_quar"];

_loc_water=[];
_loc_civ=[];
_loc_ind=[];
_loc_mil=[];
_loc_sonst=[];
_cfgOrte=[];

_mil=0;
_ind=0;
_pow=0;
_quar=0;

_cfgOrte = configFile >> "CfgWorlds" >> worldName >> "Names";

for "_i" from 0 to ((count _cfgOrte)-1) do {
	_ort 		= _cfgOrte select _i;
	_name 		= getText(_ort >> "name");
	_position	= getArray(_ort >> "position");
	_typ		= getText(_ort >> "type");	
	If (_position distance (getmarkerpos "Respawn_West") > 2500) then {
		If ((_typ in ["NameCityCapital","NameCity","NameVillage"])and(_name != "Sagonisi")) exitWith {
			_loc_civ pushBack [_name,_position];
		};
		If ((surfaceIsWater _position)and(_name != "Edessa")) exitWith {
			_loc_water pushBack [_name,_position];
		};
		If (_name in ["MILITARY","Militär","military"]) exitWith {
			INC(_mil);
			_loc_mil pushBack [FORMAT_2("%1 %2",_name,_mil),_position];
		};
		If (_name in ["FACTORY","Fabrik","factory"]) exitWith {
			INC(_ind);
			_loc_ind pushBack [FORMAT_2("%1 %2",_name,_ind),_position];
		};
		If (_name in ["QUARRY","Steinbruch","quarry"]) exitWith {
			INC(_quar);
			_loc_ind pushBack [FORMAT_2("%1 %2",_name,_quar),_position];
		};
		If (_name in ["POWER PLANT","Kraftwerk","power plant"]) exitWith {
			INC(_pow);
			_loc_ind pushBack [FORMAT_2("%1 %2",_name,_pow),_position];
		};
		If (!(_name in ["Fournos","Monisi","Pyrgi","Atsalis","Bomos","Savri","Makrynisi","Sagonisi"]) and (_name != "")) exitWith {
			_loc_sonst pushBack [_name,_position];
		};
	};
};

If (dorb_debug_loc) then {
	{
		_mrkr = createMarker [_x select 0, _x select 1];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorCIV";
		_mrkr setMarkerType "mil_flag";
		_mrkr setMarkerText (_x select 0);
	}forEach _loc_civ;
	{
		_mrkr = createMarker [_x select 0, _x select 1];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorBlue";
		_mrkr setMarkerType "mil_flag";
		_mrkr setMarkerText (_x select 0);
	}forEach _loc_water;
	{
		_mrkr = createMarker [_x select 0, _x select 1];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorYellow";
		_mrkr setMarkerType "mil_flag";
		_mrkr setMarkerText (_x select 0);
	}forEach _loc_ind;
	{
		_mrkr = createMarker [_x select 0, _x select 1];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorOrange";
		_mrkr setMarkerType "mil_flag";
		_mrkr setMarkerText (_x select 0);
	}forEach _loc_mil;
	{
		_mrkr = createMarker [_x select 0, _x select 1];
		_mrkr setMarkerShape "ICON";
		_mrkr setMarkerColor "ColorRed";
		_mrkr setMarkerType "mil_flag";
		_mrkr setMarkerText (_x select 0);
	}forEach _loc_sonst;
};

[_loc_civ,_loc_ind,_loc_mil,_loc_water,_loc_sonst]