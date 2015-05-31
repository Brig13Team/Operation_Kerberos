/*
	Author: Dorbedo
	
	Description:
		Gefangene verhören

*/
#include "script_component.hpp"

/// TODO: ACE - captured unit = civillian??


ISNILS(DORB_EXAMINE,false);
ISNILS(DORB_EXAMINE_MARK,[]);

_target = [_this, 0, [],[[]]] call BIS_fnc_Param;
_option = [_this, 1, "",[""]] call BIS_fnc_Param;


switch (_option) do {
	case "init": 	{
						
						DORB_EXAMINE=false;
						{deleteMarker _x}forEach DORB_EXAMINE_MARK;
						DORB_EXAMINE_MARK=[];
						LOG("Examine Init");
					};

	case "check": 	{
						CHECK(DORB_EXAMINE)
						_position_rescue = getMarkerPos "rescue_marker";
						_list = _position_rescue nearEntities ["Man", 10];
						{					
							If ((side _x == dorb_side)||(captive _x)) then {
//							If (side _x == dorb_side) then {
								//if ((vehicle _x)!=_x) then {moveOut _x;}; //
								If ((captive _x)&&(!(_x isKindOf "rhs_infantry_msv_base"))) exitWith {};
								deleteVehicle _x;
								[-1,{_this FSPAWN(disp_message)},[localize "STR_DORB_EXAMINE",localize "STR_DORB_EXAMINE_DESC"]] FMP;
								DORB_EXAMINE=true;
								LOG(FORMAT_1("EXAMINE WIRD DURCHGEFÜHRT\nTARGETS=%1",_target));
								for "_i" from 0 to ((count _target)-1) do {
									_pos = [getPos(_target select _i), 40,0] FCALL(random_pos);
									_marker = createMarker [format["EXAMINE_Mark_%1",_i],_pos];
									_marker setMarkerShape "Ellipse";
									_marker setMarkerColor "ColorRed";
									_marker setMarkerBrush "Border";
									_marker setMarkerSize [50,50];
									//DORB_EXAMINE_MARK pushBack format["EXAMINE_Mark_%1",_i];
									DORB_EXAMINE_MARK pushBack _marker;
								};
								LOG(FORMAT_3("Gegner=%1 \n Anzahl=%2 \n Ziele=%3",_x,count _target,_target));
							};
						}forEach _list;
					};
	case "destroy": {
						{deleteMarker _x} forEach DORB_EXAMINE_MARK;
						DORB_EXAMINE_MARK=[];
						LOG("Examine Destroy");
					};
};
