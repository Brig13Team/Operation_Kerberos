/*
    Author: Dorbedo

    Description:
    moves group to HC

    Parameter(s):
        
        0 : Group

*/
#include "script_component.hpp"
SCRIPT(movetoHC);
/// CurrentHC erstellen, falls nicht vorhanden - Nur am Anfang interessant
if ((isnil "currentHC")&&(!(isnil "HC1"))) then {
    currentHC = HC1;
};

///  Ist ein HC-Object plaziert?

If (isNil "currentHC") exitWith {ERROR("Kein HC vorhanden");};

/// gehört das HC-Object dem Server (kein client connected)
If ((owner currentHC) == 0) exitWith {ERROR("HC disconnected");};


[] call FUNC(headless_determine);
Private["_HCid","_geklappt"];
params[["_group",grpNull,[grpNull]]];
_HCid = owner currentHC;
/// Leere Gruppe irgnorieren
If ((units _group)isEqualTo []) exitWith {deleteGroup _x;};
/// Check ob geklappt - falls nicht: Error
_geklappt = false;
_geklappt = _group setGroupOwner _HCid;

CHECK(_geklappt)
ERROR("Gruppenbesitzerwechsel fehlgeschlagen");