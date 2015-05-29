/*
	Author: Dorbedo

	Description:
	moves group to HC

	Parameter(s):
		
		0 : Group

*/
#include "makros.hpp"

/// CurrentHC erstellen, falls nicht vorhanden - Nur am Anfang interessant
if ((isnil "currentHC")&&(!(isnil "HC1"))) then {
	//d_log("ERstelle HC")
	currentHC = HC1;
};

///  Ist ein HC-Object plaziert?
//If (isNull currentHC) exitWith {d_error(FORMAT_1("Kein HC - Abfrage = %1",currentHC))};

If (isNil "currentHC") exitWith {d_error("Kein HC - isNil")};

/// gehört das HC-Object dem Server (kein client connected)
If ((owner currentHC) == 0) exitWith {d_error(FORMAT_1("Kein HC: %1",(owner currentHC)))};


[] FCALL(determineHC);

_group = [_this,0,grpNull,[grpNull]] call BIS_fnc_Param;
_HCid = owner currentHC;
/// Leere Gruppe irgnorieren
CHECK((units _group)isEqualTo [])
/// Check ob geklappt - falls nicht: Error
_geklappt = false;
_geklappt = _group setGroupOwner _HCid;
sleep 2;
//d_log(FORMAT_1("Neuer Besitzer Soll=%1",_HCid))
//d_log(FORMAT_1("Neuer Besitzer IST =%1",groupOwner _group))

CHECK(_geklappt)
d_error("Gruppenbesitzerwechsel fehlgeschlagen")




//CHECK(!isServer and !isMultiplayer)

//CHECK(owner HC1 == 0)


//If (isNull HC1) exitWith {d_log("Kein HC - Abfrage 1")};




//CHECK(isNull _HCid)


