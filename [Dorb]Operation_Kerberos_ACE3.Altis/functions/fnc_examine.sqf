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

/// TODO: ACE - captured unit = civillian??


ISNILS(DORB_EXAMINE,0);
ISNILS(DORB_EXAMINE_TARGETARRAY,[]);
ISNILS(DORB_EXAMINE_REVEALEDID,[]);
ISNILS(DORB_EXAMINE_MARK,[]);
private["_option","_paramter"];
_option = [_this, 0, "",[""]] call BIS_fnc_Param;
_paramter = [_this, 1, [],[[]]] call BIS_fnc_Param;

switch (_option) do {
	case "init": 	{
						DORB_EXAMINE=0;
						{deleteMarker _x;}forEach DORB_EXAMINE_MARK;
						DORB_EXAMINE_MARK = [];
						DORB_EXAMINE_REVEALEDID = [];
						DORB_EXAMINE_TARGETARRAY = _paramter;
						
						DORB_EXAMINE_TARGETARRAY = DORB_EXAMINE_TARGETARRAY call BIS_fnc_arrayShuffle;
						
						
					};
	case "check": 	{
						Private["_position_rescue","_list"];
						_position_rescue = getMarkerPos "rescue_marker";
						_list = _position_rescue nearEntities ["Man", 10];
						{					
							If ((side _x == dorb_side)||(captive _x)) then {
								
								//If ((captive _x)&&(!(_x isKindOf "rhs_infantry_msv_base"))) exitWith {};
								If ((typeOf _x in dorb_pow)||(isPlayer _x))exitWith{};
								deleteVehicle _x;
								[-1,{_this spawn FM(disp_message)},["STR_DORB_EXAMINE","STR_DORB_EXAMINE_DESC"]] FMP;
								["reveal"] call FM(examine);
							};
						}forEach _list;
					};
	case "reveal" : {
						Private["_modus","_genauigkeit","_pos","_marker","_a"];
						_modus = [_paramter,0,"all",[""]] call BIS_fnc_Param;
						_genauigkeit = [_paramter,1,50,[0]] call BIS_fnc_Param;
						
						
						switch (_modus) do {
							case "all" : {
								for "_i" from 0 to ((count DORB_EXAMINE_TARGETARRAY)-1) do {
									_pos = [getPos(DORB_EXAMINE_TARGETARRAY select _i), (_genauigkeit - 2)max 5,0] call FM(random_pos);
									_marker = createMarker [format["EXAMINE_Mark_%1",((count DORB_EXAMINE_MARK)+1)],_pos];
									_marker setMarkerShape "Ellipse";
									_marker setMarkerColor "ColorRed";
									_marker setMarkerBrush "Border";
									_marker setMarkerSize [_genauigkeit,_genauigkeit];
									DORB_EXAMINE_MARK pushBack _marker;
								};
							};
							case "single_rnd" : {
								//// Random Target including revealed ones
								_a = floor(random(count(DORB_EXAMINE_TARGETARRAY)));
								DORB_EXAMINE_REVEALEDID pushBack _a;
								_pos = [getPos(DORB_EXAMINE_TARGETARRAY select _a), (_genauigkeit - 2)max 5,0] call FM(random_pos);
								_marker = createMarker [format["EXAMINE_Mark_%1",((count DORB_EXAMINE_MARK)+1)],_pos];
								_marker setMarkerShape "Ellipse";
								_marker setMarkerColor "ColorRed";
								_marker setMarkerBrush "Border";
								_marker setMarkerSize [_genauigkeit,_genauigkeit];
								DORB_EXAMINE_MARK pushBack _marker;
							};
							case "single" : {
								//// Random Target excluding revealed ones
								for "_i" from 0 to ((count DORB_EXAMINE_TARGETARRAY)-1) do {
									If (!(_i in DORB_EXAMINE_TARGETARRAY)) exitwith {
										DORB_EXAMINE_REVEALEDID pushBack _i;
										_pos = [getPos(DORB_EXAMINE_TARGETARRAY select _i), (_genauigkeit - 2)max 5,0] call FM(random_pos);
										_marker = createMarker [format["EXAMINE_Mark_%1",((count DORB_EXAMINE_MARK)+1)],_pos];
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
						
						for "_i" from 0 to ((count DORB_EXAMINE_TARGETARRAY)-1) do {
							_pos = [getPos(DORB_EXAMINE_TARGETARRAY SELRND), 300,0] call FM(random_pos);
							_marker = createMarker [format["EXAMINE_Mark_%1",((count DORB_EXAMINE_MARK)+1)],_pos];
							_marker setMarkerShape "Ellipse";
							_marker setMarkerColor "ColorRed";
							_marker setMarkerBrush "Border";
							_marker setMarkerSize [_genauigkeit_falsch,_genauigkeit_falsch];
							DORB_EXAMINE_MARK pushBack _marker;
						};
						
						for "_i" from 0 to _info_echt do {
							["reveal",["Single",_genauigkeit_echt]] call FM(examine);
						};
					};
	case "destroy": {
						{deleteMarker _x;} forEach DORB_EXAMINE_MARK;
						DORB_EXAMINE_MARK=[];
						DORB_EXAMINE_TARGETARRAY=[];
					};
};
