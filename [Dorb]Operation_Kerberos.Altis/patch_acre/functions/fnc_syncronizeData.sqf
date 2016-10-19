/*
 * Author: Dorbedo
 * Checks if the radio is initialized correct and reinitializes
 *
 * Arguments:
 * 0: player to check
 *
 * Return Value:
 * none
 *
 *
 * Public: Yes
 */
 #include "script_component.hpp"


private _radioData = acre_sys_data_radioData call acre_sys_data_fnc_serialize;
private _idTable = acre_sys_server_masterIdTable call acre_sys_data_fnc_serialize;
private _jipData = [_radioData, _idTable];
diag_log text format["%1 ACRE Data Sync for all acre_players - %2KB", diag_tickTime, (count (toArray (str _jipData)))/1024];
ACREjipc = _jipData;

publicVariable "ACREjipc";
