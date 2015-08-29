/*
    Author: Dorbedo

    Description:
        Sets teleport buttons

*/
#include "script_component.hpp"
SCRIPT(ui_teleport_onLoad);
CHECK(!hasInterface)
Private["_teleporter","_ctrl"];
disableSerialization;
_teleporter = [
    /// ["",""],      /// Beispiel zum Ausschalten von einem Teleport
    [localize "STR_DORB_TELEPORT_BASE"          ,"closeDialog 600300;player setposatl (getMarkerPos DORB_RESPAWNMARKER)"],
    [localize "STR_DORB_TELEPORT_VEHICLES"      ,"closeDialog 600300;player setposatl (getMarkerPos 'teleport_fahrzeuge')"],
    [localize "STR_DORB_TELEPORT_AIR"           ,"closeDialog 600300;player setposatl (getMarkerPos 'teleport_luftwaffe')"],
    [localize "STR_DORB_TELEPORT_SHOOTINGRANGE" ,"closeDialog 600300;player setposatl (getMarkerPos 'teleport_schiessstand')"],
    [localize "STR_DORB_TELEPORT_MARINE"        ,"closeDialog 600300;player setposatl (getMarkerPos 'teleport_hafen')"],
    [localize "STR_DORB_TELEPORT_LOGISTIC"      ,"closeDialog 600300;player setposatl (getMarkerPos 'teleport_logistik')"],
    [localize "STR_DORB_TELEPORT_LEAD"          ,"closeDialog 600300;[ObjNull,player] call dorb_fnc_ui_teleporter_lead"]
];

for "_i" from 0 to 6 do {
    _ctrl = (findDisplay 600300 displayCtrl (600301 + _i));
    if (((_teleporter select _i)select 0) isEqualTo "") then {
        _ctrl ctrlSetText "";
        _ctrl ctrlShow false;
        _ctrl ctrlSetEventHandler ["ButtonClick",""];
        _ctrl ctrlSetTooltip "";
    }else{
        _ctrl ctrlSetText ((_teleporter select _i)select 0);
        _ctrl ctrlShow true;
        _ctrl buttonSetAction format["%1",((_teleporter select _i)select 1)];
        _ctrl ctrlSetTooltip "";
    };
};