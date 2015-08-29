/*
	Author: Dorbedo

	Description:
	moves group to HC

	Parameter(s):
		
		0 : Group

*/
#include "script_component.hpp"
CHECK(true)
SCRIPT(movetoHC);
/// CurrentHC erstellen, falls nicht vorhanden - Nur am Anfang interessant
if ((isnil "currentHC")&&(!(isnil "HC1"))) then {
	currentHC = HC1;
};

///  Ist ein HC-Object plaziert?

If (isNil "currentHC") exitWith {ERROR("Kein HC vorhanden");};

/// gehört das HC-Object dem Server (kein client connected)
If ((owner currentHC) == 0) exitWith {ERROR("HC disconnected");};


[] call FM(determineHC);
Private["_group","_HCid","_geklappt"];
_group = [_this,0,grpNull,[grpNull]] call BIS_fnc_Param;
_HCid = owner currentHC;
/// Leere Gruppe irgnorieren
CHECK((units _group)isEqualTo [])
/// Check ob geklappt - falls nicht: Error
_geklappt = false;
_geklappt = _group setGroupOwner _HCid;
sleep 2;

CHECK(_geklappt)
ERROR("Gruppenbesitzerwechsel fehlgeschlagen");