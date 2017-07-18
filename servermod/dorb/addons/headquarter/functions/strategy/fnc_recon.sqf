/*
 *  Author: Dorbedo
 *
 *  Description:
 *      recon strategie
 *
 *  Parameter(s):
 *      0 : LOCATION - Attackposition
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


/*

    !!! OLD - needs rework


*/
_this params ["_currentLocation","_strategyHash"];
//TRACEV_2(_currentLocation,_strategyHash);
private _attackgroups = HASH_GET(GVAR(groups),"attackGroups");
private _availableGroups = [];

{
    private _grouphash = _x;
    private _group = _grouphash getVariable "group";
    If !(isNil "_grouphash") then {
        private _state = HASH_GET(_grouphash,"state");
        private _type = HASH_GET(_grouphash,"type");
        If ((_state in ["idle","wait"])&&(_type == 0)) then {
            _availableGroups pushBack _group;
        };
    }else{
        ERROR(FORMAT_2("Grouphash is nil: %1 group: %2",_grouphash,_group));
    };
} forEach _attackgroups;
//TRACEV_1(_availableGroups);
//_availableGroups = _availableGroups call BIS_fnc_arrayShuffle;
If (_availableGroups isEqualTo []) exitWith {
    HASH_DELETE(_strategyhash);
    [];
};
private _chosenOne = selectRandom _availableGroups;

private _statementFinish = QUOTE(this call FUNC(strategy__onFinishSAD););

[_chosenOne,"attack",_currentLocation,_statementFinish] call FUNC(state_set);

private _grouphash = _chosenOne getVariable QGVAR(grouphash);
HASH_SET(_groupHash,"strategy",_strategyHash);
//TRACEV_2(count (units _chosenOne),_chosenOne);
[count (units _chosenOne),_chosenOne];
