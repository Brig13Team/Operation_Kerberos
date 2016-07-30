/*
    Author: Dorbedo

    Description:
        Sets teleport buttons

*/
#include "script_component.hpp"
CHECK(!hasInterface)
disableSerialization;
Private _teleporter = [
    /// ["",""],      /// Beispiel zum Ausschalten von einem Teleport
    [localize LSTRING(TELEPORT_BASE),QUOTE(closeDialog 600300;player setposatl (getMarkerPos GVARMAIN(RESPAWNMARKER)))],
    [localize LSTRING(TELEPORT_VEHICLES),"closeDialog 600300;player setposatl (getMarkerPos 'teleport_fahrzeuge')"],
    [localize LSTRING(TELEPORT_AIR),QUOTE(closeDialog 600300;If (missionNamespace getVariable [ARR_2('GVAR(teleport_airfield)',true)]) then {player setposatl (getMarkerPos 'teleport_luftwaffe');} else {};)],
    [localize LSTRING(TELEPORT_SHOOTINGRANGE),"closeDialog 600300;player setposatl (getMarkerPos 'teleport_schiessstand')"],
    [localize LSTRING(TELEPORT_MARINE),"closeDialog 600300;player setposatl (getMarkerPos 'teleport_hafen')"],
    [localize LSTRING(TELEPORT_LOGISTIC),"closeDialog 600300;player setposatl (getMarkerPos 'teleport_logistik')"],
    [localize LSTRING(TELEPORT_LEAD),QUOTE(closeDialog 600300;[ARR_2(ObjNull,player)] call FUNC(teleport_lead))]
];

for "_i" from 0 to 6 do {
    Private _ctrl = (findDisplay 600300) displayCtrl (600301 + _i);
    if ( ( (_teleporter select _i) select 0 ) isEqualTo "") then {
        _ctrl ctrlSetText "";
        _ctrl ctrlShow false;
        _ctrl ctrlSetEventHandler ["ButtonClick",""];
        _ctrl ctrlSetTooltip "";
    } else {
        _ctrl ctrlSetText (( _teleporter select _i ) select 0 );
        _ctrl ctrlShow true;
        _ctrl buttonSetAction format["%1",((_teleporter select _i)select 1)];
        _ctrl ctrlSetTooltip "";
    };
};