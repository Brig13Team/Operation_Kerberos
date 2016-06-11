/*
    Author: Dorbedo

    Description:
        Sets teleport buttons

*/
#include "script_component.hpp"
SCRIPT(onLoad);
CHECK(!hasInterface)
Private["_teleporter","_ctrl"];
disableSerialization;

#define TELEPORTER_FNC_ATL(TARGET,HEIGHT) QUOTE(closeDialog 600300;private _target = getMarkerPos TARGET; _target set [ARR_2(2,HEIGHT)];player setposatl _target;)
#define TELEPORTER_FNC_ASL(TARGET,HEIGHT) QUOTE(closeDialog 600300;private _target = getMarkerPos TARGET; _target set [ARR_2(2,HEIGHT)];player setposasl _target;)


_teleporter = [
    /// ["",""],      /// Beispiel zum Ausschalten von einem Teleport
    [localize LSTRING(TELEPORT_BASE),TELEPORTER_FNC_ATL(GVARMAIN(RESPAWNMARKER),0.5)],
    [localize LSTRING(TELEPORT_VEHICLES),TELEPORTER_FNC_ATL('teleport_fahrzeuge',0.5)],
    [localize LSTRING(TELEPORT_AIR),TELEPORTER_FNC_ATL('teleport_luftwaffe',0)],
    [localize LSTRING(TELEPORT_SHOOTINGRANGE),TELEPORTER_FNC_ASL('teleport_schiessstand',0.5)],
    [localize LSTRING(TELEPORT_MARINE),TELEPORTER_FNC_ATL('teleport_hafen',0)],
    [localize LSTRING(TELEPORT_LOGISTIC),TELEPORTER_FNC_ATL('teleport_logistik',0)],
    [localize LSTRING(TELEPORT_LEAD),QUOTE(closeDialog 600300;[ARR_2(ObjNull,player)] call FUNC(teleport_lead))]
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