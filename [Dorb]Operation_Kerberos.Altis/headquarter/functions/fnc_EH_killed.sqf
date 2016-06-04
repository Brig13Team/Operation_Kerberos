/*
    Author: Dorbedo
    
    
    Description:
        pirmary to register the dead to the HQ
    
    Parameter(s):
        0:OBJECT    - killed unit
        1:OBJECT    - Killer

    Returns:
        none
*/
#include "script_component.hpp"
_this spawn {
    SCRIPTIN(EH_killed,spawn);
    _this params["_unit","_killer"];
    CHECK(isPlayer _unit)
    CHECK((side _unit)==civilian)

    
    // if unit is the last one, 
    if (count (units group _unit))<2 then {
        private _group = group _unit;
        [_group] call FUNC(attackpos_reduce);
        private _curPOI = selectRandom GVAR(POI);
        private _curPos = [_curPOI,800,0] call EFUNC(common,pos_random);
        _group setVariable [QGVAR(target),_curPos];
        _group setVariable [QGVAR(state),"defend"];
        [_group] spawn FUNC(state_change);
    };
    
    // check if other units know who killed the Unit
    _otherUnits = (getPos _unit) nearEntities ["Man",30];

    _messagingUnits = [];
    {
        if ((_x knowsAbout _killer)>0.5) then {
            _messagingUnits pushBack [(_x knowsAbout _killer),_x];
        };
    }count (_otherUnits);

    CHECK(_messagingUnits isEqualTo [])
    // spawn a send_msg with the enemypos to the HQ
    _messagingUnits sort false;

    uiSleep 5;

    {
        If ((!isNull _x)&&{alive _x}) exitWith {
            If ((_x knowsAbout _killer)>2) then {
                /// call support
                [_killer,_x] call FUNC(killed);
            }else{
                /// call recon
                [_killer,_x] call FUNC(recon);
            };
        };
    }forEach _messagingUnits;

};