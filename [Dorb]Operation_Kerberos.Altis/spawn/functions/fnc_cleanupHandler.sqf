/*
 *  Author: Dorbedo
 *
 *  Description:
 *      This is the cleanup-Handler, who collects and deletes stuff
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (GVAR(cleanup_objectsToCheck) isEqualTo []) then {
    GVAR(cleanup_objectsToCheck) = (allMissionObjects "WeaponHolder")
            + (allMissionObjects "GroundWeaponHolder")
            + (allMissionObjects "WeaponHolderSimulated")
            + (allMissionObjects "CraterLong_small")
            + (allMissionObjects "CraterLong")
            + allDead
            + (allGroups select {(units _x) isEqualTo []})
            + GVAR(cleanUpDump);
}else{
    // cycle through objects and check, if they are allowed to be deleted
    private _time = diag_tickTime + 1/4;
    while { (diag_ticktime < _time) } do {
        private _curObj = (GVAR(cleanup_objectsToCheck)) deleteAt 0;
        If ((_curObj getVariable [QGVARMAIN(canDelete),false])&&{!(_curObj getVariable [QGVAR(inDelete),false])}) then {
            _curObj setVariable [QGVAR(inDelete),true];
            GVAR(cleanup_Dump_int) pushBack [_curObj,CBA_missiontime + GVAR(cleanUp_waittime)];
        };
    };
};


// deleteStuff
private _time = diag_tickTime + 1/4;
while { (diag_ticktime < _time) && {!(GVAR(cleanup_Dump_int) isEqualTo [])} do {
    (GVAR(cleanup_Dump_int) select 0) params ["_thing","_time"];
    If !((isNull _thing)||{_time > CBA_missiontime}) exitWith {};
    GVAR(deleteDump) deleteAt 0;
    [_thing] call EFUNC(common,delete);
};
