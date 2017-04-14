/**
 *  Author: Dorbedo
 *
 *  Description:
 *      updates the strength of the playergroups
 *      gets the values over time to prevent smaller attacks if the units moved out of a vehicle
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

(_this select 0) params[["_fullCheck",false,[true]]];

private _allPlayerGroups = allGroups select {side _x == GVARMAIN(playerside)};
private _playergrouphashes = HASH_GET(GVAR(groups),"playergroups");
//TRACEV_3(_this,_allPlayerGroups,_playergrouphashes);
If !((count _allPlayerGroups)==(count _playergrouphashes)) then {
    _fullCheck = true;
};

If ((!(IS_ARRAY(GVAR(playergroups_new))))&&{GVAR(playergroups_new) < CBA_missiontime}) then {
    _fullCheck = true;
};

If (_fullCheck) then {
    GVAR(playergroups_new) = [];
    {
        private _group = _x;
        private _grouphash = _group getVariable QGVAR(grouphash);
        If (isNil "_grouphash") then {
            [_group] call FUNC(registerPlayerGroup);
        };
        GVAR(playergroups_new) pushBackUnique _grouphash;
        private _strengthArray = (_group call FUNC(strengthPlayer)) params ["_value","_strenght","_defence","_type"];

        private _temphistory = (HASH_GET(_grouphash,"valuehistory"));
        If (count _temphistory >= 10) then {_temphistory deleteAt 0;};
        _temphistory pushBack _value;
        HASH_SET(_grouphash,"valuehistory",_temphistory);
        private _GroupValue = round ([_temphistory] call EFUNC(common,arithmeticMean));
        HASH_SET(_grouphash,"value",_GroupValue);


        private _temphistory = (HASH_GET(_grouphash,"strenghthistory"));
        If (count _temphistory >= 10) then {_temphistory deleteAt 0;};
        _temphistory pushBack _strenght;
        HASH_SET(_grouphash,"strenghthistory",_temphistory);
        private _GroupStrenght = [_temphistory] call EFUNC(common,arraysGetMax);
        HASH_SET(_grouphash,"strenght",_GroupStrenght);

        private _temphistory = (HASH_GET(_grouphash,"defencehistory"));
        If (count _temphistory >= 10) then {_temphistory deleteAt 0;};
        _temphistory pushBack _defence;
        HASH_SET(_grouphash,"defencehistory",_temphistory);
        private _GroupDefence = [_temphistory] call EFUNC(common,arraysGetMax);
        HASH_SET(_grouphash,"defence",_GroupDefence);

        private _temphistory = (HASH_GET(_grouphash,"typehistory"));
        If (count _temphistory >= 10) then {_temphistory deleteAt 0;};
        _temphistory pushBack _type;
        HASH_SET(_grouphash,"typehistory",_temphistory);
        private _GroupType = selectMax _temphistory;
        HASH_SET(_grouphash,"type",_GroupType);

    } forEach _allPlayerGroups;

    HASH_SET(GVAR(groups),"playergroups",GVAR(playergroups_new));
    GVAR(playergroups_new) = CBA_missiontime + DEF_PLAYERGROUPCHECKINTERVALL;
};
