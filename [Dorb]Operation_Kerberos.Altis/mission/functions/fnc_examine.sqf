/*
	Author: Dorbedo
	
	Description:
		Erschafft genauere Informationen für Missionsziele
			- Gefangene verhören
			- Nebenmissionen
		
	Parameter:
		0 : STRING		- Modus
		
		(init)
		1 : ARRAY		- Array mit Missionszielen (Objeke oder Positionen)
		
		(check)
			none
		
		(reveal)
		1 : ARRAY		- Array mit parametern
			0 : STRING	- Modus
			1 : SCALAR	- Genauigkeit der Informationen
		
		(random)
		1 : ARRAY		- Array mit parametern
			0 : SCALAR	- Anzahl echte Informationen
			1 : SCALAR	- Anzahl falsche Informationen
			2 : SCALAR	- Genauigkeit echter Informationen (Radius des Kreises)
			3 : SCALAR	- Genauigkeit falscher Informationen (Radius des Kreises)
		(destroy)
			none
		
	Return
		nothing
*/
#include "script_component.hpp"
SCRIPT(examine);
/// TODO: ACE - captured unit = civillian??


ISNILS(GVAR(examine_targetarray),[]);
ISNILS(GVAR(examine_revealed),[]);
ISNILS(GVAR(markerdump),[]);
params[["_option","",[""]],["_paramter",[],[[]]]];

switch (_option) do {
	case "init": 	{
						GVAR(examine_revealed) = [];
						GVAR(examine_targetarray) = _paramter;
						
						GVAR(examine_targetarray) = GVAR(examine_targetarray) call BIS_fnc_arrayShuffle;
						
						
					};
	case "check": 	{
						Private["_position_rescue","_list"];
						_position_rescue = getMarkerPos "rescue_marker";
						_list = _position_rescue nearEntities ["Man", 10];
						{					
							If ((!(GETVAR(_x,GVAR(istarget),false))) && {(side _x == dorb_side)||(captive _x)}) then {
								
								//If ((captive _x)&&(!(_x isKindOf "rhs_infantry_msv_base"))) exitWith {};
								If ((typeOf _x in dorb_pow)||(isPlayer _x))exitWith{};
								deleteVehicle _x;
								[-1,{_this spawn EFUNC(interface,disp_message)},["STR_DORB_EXAMINE","STR_DORB_EXAMINE_DESC"]] FMP;
								["reveal"] call FUNC(examine);
							};
						}forEach _list;
					};
	case "reveal" : {
						Private["_modus","_genauigkeit","_pos","_marker","_a"];
						_modus = [_paramter,0,"all",[""]] call BIS_fnc_Param;
						_genauigkeit = [_paramter,1,50,[0]] call BIS_fnc_Param;
						
						
						switch (_modus) do {
							case "all" : {
								for "_i" from 0 to ((count GVAR(examine_targetarray))-1) do {
									_pos = [getPos(GVAR(examine_targetarray) select _i), (_genauigkeit - 2)max 5,0] call EFUNC(common,random_pos);
									_marker = createMarker [format["EXAMINE_Mark_%1",((count GVAR(markerdump))+1)],_pos];
									_marker setMarkerShape "Ellipse";
									_marker setMarkerColor "ColorRed";
									_marker setMarkerBrush "Border";
									_marker setMarkerSize [_genauigkeit,_genauigkeit];
									GVAR(markerdump) pushBack _marker;
								};
							};
							case "single_rnd" : {
								//// Random Target including revealed ones
								_a = floor(random(count(GVAR(examine_targetarray))));
								GVAR(examine_revealed) pushBack _a;
								_pos = [getPos(GVAR(examine_targetarray) select _a), (_genauigkeit - 2)max 5,0] call EFUNC(common,random_pos);
								_marker = createMarker [format["EXAMINE_Mark_%1",((count GVAR(markerdump))+1)],_pos];
								_marker setMarkerShape "Ellipse";
								_marker setMarkerColor "ColorRed";
								_marker setMarkerBrush "Border";
								_marker setMarkerSize [_genauigkeit,_genauigkeit];
								GVAR(markerdump) pushBack _marker;
							};
							case "single" : {
								//// Random Target excluding revealed ones
								for "_i" from 0 to ((count GVAR(examine_targetarray))-1) do {
									If (!(_i in GVAR(examine_targetarray))) exitwith {
										GVAR(examine_revealed) pushBack _i;
										_pos = [getPos(GVAR(examine_targetarray) select _i), (_genauigkeit - 2)max 5,0] call EFUNC(common,random_pos);
										_marker = createMarker [format["EXAMINE_Mark_%1",((count GVAR(markerdump))+1)],_pos];
										_marker setMarkerShape "Ellipse";
										_marker setMarkerColor "ColorRed";
										_marker setMarkerBrush "Border";
										_marker setMarkerSize [_genauigkeit,_genauigkeit];
									};
								};
							};
						};
					};
	case "random" ; {
						Private["_info_echt","_info_falsch","_genauigkeit_echt","_genauigkeit_falsch","_pos","_marker"];
						_info_echt = [_paramter,0,0,[0]] call BIS_fnc_Param;
						_info_falsch = [_paramter,1,0,[0]] call BIS_fnc_Param;
						_genauigkeit_echt = [_paramter,2,50,[0]] call BIS_fnc_Param;
						_genauigkeit_falsch = [_paramter,3,50,[0]] call BIS_fnc_Param;
						
						for "_i" from 0 to ((count GVAR(examine_targetarray))-1) do {
							_pos = [getPos(GVAR(examine_targetarray) SELRND), 300,0] call EFUNC(common,random_pos);
							_marker = createMarker [format["EXAMINE_Mark_%1",((count GVAR(markerdump))+1)],_pos];
							_marker setMarkerShape "Ellipse";
							_marker setMarkerColor "ColorRed";
							_marker setMarkerBrush "Border";
							_marker setMarkerSize [_genauigkeit_falsch,_genauigkeit_falsch];
							GVAR(markerdump) pushBack _marker;
						};
						
						for "_i" from 0 to _info_echt do {
							["reveal",["Single",_genauigkeit_echt]] call FUNC(examine);
						};
					};
	case "destroy": {
						/// Obsolet
						GVAR(examine_targetarray)=[];
					};
};
