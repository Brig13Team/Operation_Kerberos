/*
	Author: Dorbedo
	
	Description:
		Teleports Caller to his Squadleader
	
*/
#include "script_component.hpp"
d_log("leadport")
PARAMS_2(_host,_caller);

private["_position","_platzanzahl","_nearestEnemy"];

_position = [];

//if (not alive _host) exitWith {_host removeaction (_this select 2);};

if (leader _caller == _caller) exitWith {[localize "STR_DORB_TELEPORT",[localize "STR_DORB_TELEPORT_LEAD_FAIL",localize "STR_DORB_TELEPORT_LEAD_ISLEADER"]] FCALL(disp_info);};


if ((vehicle _caller) == _caller) then {
	_nearestEnemy = _caller findNearestEnemy (leader _caller);
	if (((leader _caller) distance _nearestEnemy)<350) then {
		[localize "STR_DORB_TELEPORT",[localize "STR_DORB_TELEPORT_LEAD_FAIL",localize "STR_DORB_TELEPORT_LEAD_NEARENEMY"]] FCALL(disp_info);
	}else{
		/// In Fahrzeug
		If ((vehicle (leader _caller)) != (leader _caller)) then {
			_platzanzahl = (vehicle (leader _caller)) emptyPositions "cargo";
			If (_platzanzahl<1) then {
				[localize "STR_DORB_TELEPORT",[localize "STR_DORB_TELEPORT_LEAD_FAIL",localize "STR_DORB_TELEPORT_LEAD_NOPLACE"]] FCALL(disp_info);
			}else{
				_caller moveInCargo (vehicle (leader _caller));
			};
		}else{		
			_position = (getPos (leader _caller)) findEmptyPosition [1,15,"B_crew_F"];
			if (count _position > 1) then {
				_caller setPos _position;
			};
		};
	};
};

false