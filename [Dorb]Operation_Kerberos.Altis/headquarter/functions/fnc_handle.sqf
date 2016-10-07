/*
    Author: Dorbedo

    Description:
        handles AI HQ

    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
CHECK(GETMVAR(GVAR(active),false))

CHECK((GETMVAR(GVAR(centerpos),[]) isEqualTo []))
CHECK(!isNull(GVAR(handle)))

/// spawn to move it in the ingame sheduler
GVAR(handle) = [] spawn {
    SCRIPTIN(handle,spawn);


    /// Update Waypoints
    private _deaktivatedWP = HASH_GET(GVAR(waypoints),"deaktivated");
    {
        If !(_x in _deaktivatedWP) then {
            [_x,-1] call FUNC(waypoints_update);
        };
    } forEach (HASH_KEYS(GVAR(waypoints)))















    /*
    /// backup -> get unregistered Groups

    {
        If ((side _x != GVARMAIN(playerside))&&{(_x getVariable [QGVAR(state),""]) isEqualTo ""}) then {
            _x setVariable [QGVAR(state),"idle"];
        };
    }forEach allGroups;
    */




    private _attackarray = [QGVAR(dangerzones)] call EFUNC(common,matrix_find_peaks);
    private _attackpositions = [];
    {
        _attackpositions pushBack [
                                ((GVAR(centerpos) select 0)-(GVAR(definitions) select 0) + ((_x select 1)*(GVAR(definitions) select 1))),
                                ((GVAR(centerpos) select 1)+(GVAR(definitions) select 1) - ((_x select 2)*(GVAR(definitions) select 1))),
                                0
                                ];
    }forEach _attackarray;


    //// create new Attackpositions

    {
        private _currentAttackPos = _x;
        private _found = false;
        {
            if (_currentAttackPos in _x) exitWith {_found = true;};
        }forEach GVAR(attackpos);
        If !(_found) then {
            GVAR(attackpos) pushBack ([_curentAttackPos,(GVAR(definitions) select 1)*1.2] call EFUNC(common,create_location));
        };
    }forEach _attackpositions;



    /// Update the enemyamount on each Attackpos
    {
        ([getPos _x] call FUNC(dangerzone_convert)) params ["_x_coord","_y_coord"];
        private _enemy = 0;
        {
            _enemy = _enemy + (_x call EFUNC(common,matrix_value_get));
        }forEach [
            [QGVAR(dangerzones),_x_coord,_y_coord],

            [QGVAR(dangerzones),_x_coord+1,_y_coord],
            [QGVAR(dangerzones),_x_coord-1,_y_coord],
            [QGVAR(dangerzones),_x_coord,_y_coord+1],
            [QGVAR(dangerzones),_x_coord,_y_coord-1],

            [QGVAR(dangerzones),_x_coord+1,_y_coord+1],
            [QGVAR(dangerzones),_x_coord-1,_y_coord-1],
            [QGVAR(dangerzones),_x_coord-1,_y_coord+1],
            [QGVAR(dangerzones),_x_coord+1,_y_coord-1],

            [QGVAR(dangerzones),_x_coord+2,_y_coord-2],
            [QGVAR(dangerzones),_x_coord+2,_y_coord+2],
            [QGVAR(dangerzones),_x_coord-2,_y_coord-2],
            [QGVAR(dangerzones),_x_coord-2,_y_coord+2],

            [QGVAR(dangerzones),_x_coord-1,_y_coord-2],
            [QGVAR(dangerzones),_x_coord-2,_y_coord-1],
            [QGVAR(dangerzones),_x_coord+1,_y_coord-2],
            [QGVAR(dangerzones),_x_coord+2,_y_coord-1],
            [QGVAR(dangerzones),_x_coord+1,_y_coord+2],
            [QGVAR(dangerzones),_x_coord+2,_y_coord+1],
            [QGVAR(dangerzones),_x_coord-1,_y_coord+2],
            [QGVAR(dangerzones),_x_coord-2,_y_coord+1],

            [QGVAR(dangerzones),_x_coord+2,_y_coord],
            [QGVAR(dangerzones),_x_coord-2,_y_coord],
            [QGVAR(dangerzones),_x_coord,_y_coord+2],
            [QGVAR(dangerzones),_x_coord,_y_coord-2]
        ];
        _x setImportance _enemy;
    } forEach GVAR(attackpos);


/*
    // Check Radars
    _aircontacts = [] call FUNC(check_radars);
    // Check Spotters
    _spotter_requests = [] call FUNC(check_spotter);
    // Check Requests
    _support_requests = GETMVAR(GVAR(support_requests),[]);
    SETMVAR(GVAR(support_requests),[]);
*/




    /// get the availlible groups
    private _waitingGroups = [];
    {
        If (side _x != GVARMAIN(playerside)) then {
            // bored
            if ((_x getVariable [QGVAR(state),""]) isEqualTo "wait") then {
                _waitingGroups pushBack _x;
            };
            // Veteran
            if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
                _waitingGroups pushBack _x;
            };
        };
    }forEach allGroups;

    private _missingstrenght = 0;
    /// move into battle
    TRACEV_2(GVAR(attackpos),_waitingGroups);
    [GVAR(attackpos),_waitingGroups] call FUNC(strategy__exec);
    /*
    {
        private _enemy = _x getVariable[QGVAR(enemy),0];
        private _troops = _x getVariable[QGVAR(troopsSend),0];

        If ((_enemy - _troops)>0) then {
            for "_i" from 0 to _troops do {
                private _curGroup = _waitingGroups deleteAt 0;
                private _strength = [_curGroup] call FUNC(strength);
                _curGroup setVariable [QGVAR(target),_x];
                _curGroup setVariable [QGVAR(strength),_x];
                _curGroup setVariable [QGVAR(state),"attack"];
                [_curGroup] spawn FUNC(state_change);

                _troops = _troops + (_strength select 1);
                _i = _i + (_strength select 1);
            };
        };
        _missingstrenght = _missingstrenght + ((_enemy - _troops) max 0);
        _x setVariable[QGVAR(troopsSend),_troops];
    }forEach GVAR(attackpos);
    */

    //// Let the rest do something too.
    {
        if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
            private _curPOI = selectRandom GVAR(POI);
            private _curPos = [_curPOI,800,0] call EFUNC(common,pos_random);
            _x setVariable [QGVAR(target),_curPos];
            _x setVariable [QGVAR(state),"wait"];
            [_x] spawn FUNC(state_change);
        };
    } forEach _waitingGroups;


    // remove groups from patroling when the shit hits the fan
    /*
    If (_missingstrenght > 0) then {
        _waitingGroups = [];
        {
            If (side _x != GVARMAIN(playerside)) then {
                if ((_x getVariable [QGVAR(state),""]) isEqualTo "idle") then {
                    _waitingGroups pushBack _x;
                };
            };
        }forEach allGroups;

        {
            if (_missingstrenght <= 0) exitWith {};
            private _strength = [_x] call FUNC(strength);
            private _curPOI = selectRandom GVAR(POI);
            private _curPos = [_curPOI,200,0] call EFUNC(common,pos_random);
            _x setVariable [QGVAR(target),_curPos];
            _x setVariable [QGVAR(state),"retreat"];
            [_x] spawn FUNC(state_change);
            _missingstrenght = _missingstrenght - _strength;
        } forEach _waitingGroups;
    };
    */





};