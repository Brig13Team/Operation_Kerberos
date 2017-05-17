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
            + (allMissionObjects "Ejection_Seat_Base_F")
            + allDead
            + (allGroups select {(count units _x) < 1});
}else{
    // cycle through objects and check, if they are allowed to be deleted
    private _time = diag_tickTime + 0.02;
    while { (diag_ticktime < _time)&&{!(GVAR(cleanup_objectsToCheck) isEqualTo [])} } do {
        private _curObj = (GVAR(cleanup_objectsToCheck)) deleteAt 0;
        If ((_curObj getVariable [QGVARMAIN(canDelete),true])&&{!(_curObj getVariable [QGVAR(inDelete),false])}) then {
            If ((!(IS_GROUP(_curObj)))||{((count units _curObj) < 1)}) then {
                _curObj setVariable [QGVAR(inDelete),true];
                GVAR(cleanup_Dump_int) pushBack [CBA_missiontime + GVAR(cleanUp_waittime),_curObj];
            };
        };
    };
};


// deleteStuff
private _time = diag_tickTime + 0.02;
while { (diag_ticktime < _time) && {!(GVAR(cleanup_Dump_int) isEqualTo [])} } do {
    (GVAR(cleanup_Dump_int) select 0) params ["_curtime","_thing"];
    If (!((isNull _thing)||{_curtime < CBA_missiontime})) exitWith {};
    GVAR(cleanup_Dump_int) deleteAt 0;
    If ((_thing isEqualType grpNull)&&{(local _thing)}) then {
        deleteGroup _thing;
    }else{
        [_thing] call EFUNC(common,delete);
    };
};
