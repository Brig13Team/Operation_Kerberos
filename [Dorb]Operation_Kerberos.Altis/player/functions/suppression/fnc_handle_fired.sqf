/*
    Author: Dorbedo
    
    Description:
        suppression fired EH
    
    Parameter(s):
    

    Return
        none
*/
#include "script_component.hpp"
SCRIPT(handle_fired);
(_this select 0) params ["_projectile","_hit"];
LOG("HANDLE FIRED");
if !(alive _projectile) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;};
private "_detectionDistance";
_detectionDistance = (0.5*_hit + 7) min 28;
CHECK((player distance _projectile)> _detectionDistance)

private ["_value"];
_value = _hit/SUPPRESSION_OVERHEAD;
if (lineIntersects [getPosASL _projectile, eyepos player, player]) then {
    _detectionDistance = _detectionDistance * 0.65;
};

if ((_projectile distance player) <= _detectionDistance) then {
    if (((_projectile distance player) <= 4.3)&&(((vehicle player) == player) || (isTurnedOut player))) then {
        GVAR(suppression_lastShotAt) = time;
        [] spawn {
            _rBlur = ppEffectCreate ["RadialBlur", 1002]; 
            _rBlur ppEffectAdjust [0.015, 0.015, 0.2, 0.2];
            _rBlur ppEffectCommit 0;
            _rBlur ppEffectEnable true;
            _cc = ppEffectCreate ["colorCorrections", 1499];
            _cc ppEffectAdjust [1, 1, 0, [0,0,0,0.4], [1,1,1,1],[1,1,1,0]];
            _cc ppEffectEnable true;
            _cc ppEffectCommit 0;
            _rBlur ppEffectAdjust [0, 0, 0, 0];
            _rBlur ppEffectCommit 0.5;
            _cc ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
            _cc ppEffectCommit 0.25;
            if ((time - GVAR(suppression_lastShotAt)) >= 120) then {
                addCamShake [3,0.4, 80];
            };
            uisleep 0.5;
            ppEffectDestroy [_cc,_rBlur];
        };
    };
    _value = (_hit/SUPPRESSION_IMPACT);
};
if ((vehicle player == player) || (isTurnedOut player)) then {
    GVAR(suppression_threshold) = GVAR(suppression_threshold) + _value;
    if (GVAR(suppression_threshold) >= SUPPRESSION_BORDER) then {
        GVAR(suppression_threshold) = GVAR(suppression_threshold) min SUPPRESSION_MAX;
        if !(GVAR(suppression_isSuppressed)) then {
            [{[]call FUNC(suppression_handle_effect)}, 0.5, [] ] call CBA_fnc_addPerFrameHandler;    
        };
    }; 
};
[_this select 1] call CBA_fnc_removePerFrameHandler

