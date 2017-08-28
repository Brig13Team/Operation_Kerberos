/*
    Original Author: jonpas
    Author: Dorbedo

    Description:
        moves groups to HC

    Parameter(s):

        0 : Group

*/
#include "script_component.hpp"

If ((!(GVAR(HC_enabled)))||(GVAR(headlessClients) isEqualTo [])) exitWith {
    GVAR(istransfering) = false;
};

_this params [["_force",false,[false]]];
#ifdef DEBUG_MODE_FULL
    LOG_1(GVAR(headlessClients));
#endif

private _headlessOwnerIDs = [];
private _currentHC = -1;
private _headlessBalance = [];
{
    If (!local _x) then {
        _headlessOwnerIDs pushBack (owner _x);
        _headlessBalance pushBack 0;
        _currentHC = (count _headlessOwnerIDs) - 1;
    };
} forEach GVAR(headlessClients);

If (_currentHC < 0) exitWith {
    TRACE_1("No Valid HC to transfer to %1",_currentHC);
    GVAR(istransfering) = false;
};

private _loadBalance = ((count _headlessOwnerIDs) > 1);

{
    private _transfer = !((units _x) isEqualTo []);
    If (_transfer) then {
        {
            /// If forcing is enabled -> ignore the searching for owner
            if (_force && { (owner _x) in _headlessOwnerIDs }) exitWith {
                _transfer = false;
            };
            If (isPlayer _x) exitWith {
                _transfer = false;
            };
            If (_x getVariable [QGVAR(blacklist),false]) then {
                _transfer = false;
            };
            if (vehicle _x != _x && {(vehicle _x) getVariable [QGVAR(blacklist), false]}) exitWith {
                _transfer = false;
            };
        }forEach (units _x);
    };
    If (_transfer) then {
        private _currentID = _headlessOwnerIDs select _currentHC;
        private _transferred = _x setGroupOwner _currentID;
        If (_transferred) then {
            _headlessBalance set [_currentHC,(_headlessBalance select _currentHC)+1];
        };
        If (_loadBalance) then {
            _currentHC = If ((_currentHC + 1)>(count _headlessOwnerIDs -1)) then {0}else{_currentHC + 1};
        };
    };
} forEach allGroups;

#ifdef DEBUG_MODE_FULL
LOG_2(_headlessOwnerIDs,_headlessBalance);
#endif

GVAR(istransfering) = false;
