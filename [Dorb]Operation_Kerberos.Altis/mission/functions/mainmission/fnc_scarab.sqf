    /*
    Author: Dorbedo

    Description:
        Creates Mission "SCARAB".

    Parameter(s):
        0 :    ARRAY - Position

    Returns:
    BOOL
*/
#include "script_component.hpp"
_this params [["_position",[],[[]],[2,3]]];
TRACEV_1(_position);
CHECK(_position isEqualTo [])
/********************
    create Target
********************/
private ["_targets","_spawnposition","_rand","_einheit","_unit"];
_targets=[];
_spawnposition=[];
_rand = ((floor(random 2)) + 2);
for "_i" from 1 to _rand do{
    _einheit = "rhs_9k79";
    _spawnposition = [_position,25,200,15,0.15] call EFUNC(common,pos_flatempty);
    If (_spawnposition isEqualTo []) then {
        _spawnposition = [_position,25,200,15,0.22] call EFUNC(common,pos_flatempty);
    };
    If (_spawnposition isEqualTo []) then {
        _spawnposition = [_position,200,0] call EFUNC(common,pos_random);
        _spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];
        if !(_spawnposition isEqualTo []) then {
            _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
            uisleep 1;
            _unit setVectorUp [0,0,1];
            _unit lock 3;
            SETPVAR(_unit,ACE_vehicleLock_lockpickStrength,-1);
            createVehicleCrew _unit;
            _unit engineOn false;
            _targets pushBack _unit;
        };
    }else{
        _unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
        uisleep 1;
        _unit setVectorUp [0,0,1];
        _unit lock 3;
        createVehicleCrew _unit;
        SETPVAR(_unit,ACE_vehicleLock_lockpickStrength,-1);
        _unit engineOn false;
        _targets pushBack _unit;
    };    
};
/********************
    firedriection
********************/
private ["_mapSize","_dir"];
_mapSize = getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize");
_dir = [(_targets select 0),[(_mapSize/2),(_mapSize/2),0]] call BIS_fnc_relativeDirTo;

if ((_dir >=45)    &&(_dir < 225)) then {
    If (_dir < 135) then {
        _dir = [(_targets select 0),[_mapSize,(_mapSize/2),0]] call BIS_fnc_relativeDirTo;
    }else{
        _dir = [(_targets select 0),[(_mapSize/2),0,0]] call BIS_fnc_relativeDirTo;
    };
}else{
    If (_dir < 315) then {
        _dir = [(_targets select 0),[0,(_mapSize/2),0]] call BIS_fnc_relativeDirTo;
    }else{
        _dir = [(_targets select 0),[(_mapSize/2),_mapSize,0]] call BIS_fnc_relativeDirTo;
    };
};
/********************
    edit crew
********************/
private ["_crew"];
{
    _x setDir (_dir + 180);
    _crew = crew _x;
    {
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "MOVE";
        _x disableAI "ANIM";
        _x disableAI "FSM";
        _x disableAI "AIMINGERROR";
        _x disableAI "SUPPRESSION";
    }forEach _crew;
    #ifdef DEBUG_MODE_FULL
        [getPos _x,"SCARAB","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif
} forEach _targets;

/********************
    fix for strange
    spawned units
    and Nuke-EH
********************/

uisleep 30;
{
    if (alive _x) then {
        _x addEventHandler ["Killed", {[(getPos (_this select 0))] call FUNC(mainmission_Scarab_explode);}]
    }else{
        _x = objNull;
    };
}forEach _targets;
_targets = _targets - [objNull];

/********************
    timer
********************/
GVAR(endzeit) = CBA_missionTime + (60 * /*time in minutes*/ 80);
publicVariable QGVAR(endzeit);
GVAR(scarab_waiting) = true;

[
    QUOTE(params['_targets'];If (CBA_missionTime>GVAR(endzeit)) exitWith {{If (alive _x) then {[_x] spawn FUNC(mainmission_scarab_launch);};}forEach _targets;uisleep 30;true};if ((({!(alive _x)} count _targets) > 0)||((({(alive gunner _x)} count _targets)) <= 0))then{true}else{false};),
    [_targets],
    QUOTE(If (CBA_missionTime>GVAR(endzeit)) exitWith {false};    If !((({(alive gunner _x)} count (_this select 0))) > 0) exitWith {false};true),
    QUOTE(GVAR(endzeit) = 0;publicVariable 'GVAR(endzeit)';),
    QUOTE(GVAR(endzeit) = 0;publicVariable 'GVAR(endzeit)';),
    [_targets],
    QUOTE(If ((GVAR(endzeit) < (CBA_missionTime + 300))&&(GVAR(scarab_waiting))) then {GVAR(scarab_waiting)=false;{[ARR_2(_x,1)] spawn rhs_fnc_ss21_AI_prepare;}forEach (_this select 0);};),
    [_targets]
]