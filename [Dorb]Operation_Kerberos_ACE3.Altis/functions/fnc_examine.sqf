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
		
		
		(destroy)

		
	Return
		nothing
*/
#include "script_component.hpp"

/// TODO: ACE - captured unit = civillian??


ISNILS(DORB_EXAMINE,0);
ISNILS(DORB_EXAMINE_TARGETARRAY,[]);
ISNILS(DORB_EXAMINE_MARK,[]);
private["_option","_paramter"];
_option = [_this, 0, "",[""]] call BIS_fnc_Param;
_paramter = [_this, 1, [],[[]]] call BIS_fnc_Param;

switch (_option) do {
	case "init": 	{
						DORB_EXAMINE=0;
						{deleteMarker _x}forEach DORB_EXAMINE_MARK;
						DORB_EXAMINE_MARK=[];
						
						DORB_EXAMINE_TARGETARRAY = _paramter;
						private["_positions"];
						
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
						Private["_modus","_genauigkeit","_pos","_marker"];
						_modus = [_paramter,0,"All",[""]] call BIS_fnc_Param;
						_genauigkeit = [_paramter,1,50,[0]] call BIS_fnc_Param;
						
						switch (_modus) do {
							case "All" : {
								for "_i" from 0 to ((count DORB_EXAMINE_TARGETARRAY)-1) do {
									_pos = [getPos(DORB_EXAMINE_TARGETARRAY select _i), (_genauigkeit - 2)max 5,0] call FM(random_pos);
									_marker = createMarker [format["EXAMINE_Mark_%1",_i],_pos];
									_marker setMarkerShape "Ellipse";
									_marker setMarkerColor "ColorRed";
									_marker setMarkerBrush "Border";
									_marker setMarkerSize [_genauigkeit,_genauigkeit];
									DORB_EXAMINE_MARK pushBack _marker;
								};
							};
							case "Single" : {
								//// TO DO
								["reveal",["All",_genauigkeit]] spawn FM(examine);
							};
						};
					};
	case "destroy": {
						{deleteMarker _x} forEach DORB_EXAMINE_MARK;
						DORB_EXAMINE_MARK=[];
						DORB_EXAMINE_TARGETARRAY=[];
						LOG("Examine Destroy");
					};
};
