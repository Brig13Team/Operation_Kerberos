/*
    Author: Dorbedo

    Description:
        postinit server
*/
#include "script_component.hpp"

CHECK(!isServer)

GVAR(postInit) = false;

/*
 * Curator
 *
*/
[
    QGVAR(curator),
    {
        _this params ["_targetPlayer","_doAssign"];
        If (_doAssign) then {
            If ((count allCurators)==0) exitWith {};
            private _unassignedCurator = {If (isNull(getAssignedCuratorUnit _x)) exitWith {_x};objNull;}forEach allCurators;
            If (isNull _unassignedCurator) then {
                _targetPlayer assignCurator (allCurators select 0);
            }else{
                _targetPlayer assignCurator _unassignedCurator;
            };
            LOG_2(_targetPlayer,_unassignedCurator);
        }else{
            unassignCurator (getAssignedCuratorLogic _targetPlayer);
        };
    }
] call CBA_fnc_addEventHandler;

GVAR(postInit) = true;
