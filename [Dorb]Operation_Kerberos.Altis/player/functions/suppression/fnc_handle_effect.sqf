/*
    Author: Dorbedo
    
    Description:
        suppression fired EH
    
    Parameter(s):
    

    Return
        none
*/
#include "script_component.hpp"
SCRIPT(handle_effect);


if ((GVAR(suppression_threshold) >= SUPPRESSION_BORDER)&&(alive player)&&(GVAR(suppression_active))) then {
    GVAR(suppression_isSurpressed) = true;
    _workValue = (GVAR(suppression_threshold) - SUPPRESSION_BORDER) / (SUPPRESSION_MAX - SUPPRESSION_BORDER);
    addCamShake 
    [
        (_workValue * 1),        // Power
        2 + (_workValue * 23),    // Frequency
        1.5                        // Duration
    ];
    GVAR(suppression_dynamic) ppEffectAdjust [(_workValue * 1.28)];
    GVAR(suppression_dynamic) ppEffectCommit 0.5;
    GVAR(suppression_color) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,(1 - (_workValue * 0.40))],[1,1,1,0]];
    GVAR(suppression_color) ppEffectCommit 0.5;
    GVAR(suppression_radial)  ppEffectAdjust [(_workValue * 0.011), (_workValue * 0.011), 0.2, 0.2];
    GVAR(suppression_radial)  ppEffectCommit 0.05;
} else {    
    GVAR(suppression_color) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
    GVAR(suppression_color) ppEffectCommit 0;
    GVAR(suppression_dynamic) ppEffectAdjust [0];
    GVAR(suppression_dynamic) ppEffectCommit 0.3;
    GVAR(suppression_radial)  ppEffectAdjust [0, 0, 0, 0];
    GVAR(suppression_radial)  ppEffectCommit 0;
    GVAR(suppression_isSuppressed) = false;
};


if (GVAR(suppression_threshold) > 0) then {
    private ["_shotAt","_subtract"];
    _shotAt     = false;    
    if ((time - GVAR(suppression_lastShotAt)) <= 1.75) then {_shotAt = true};
    
    _subtract = switch (true) do {
        case (_shotAt)                  : {0};
        case (GVAR(suppression_isSuppressed))  : {0.6};
        default                             {1};
    };
    GVAR(suppression_threshold) = GVAR(suppression_threshold) - _subtract;
    if (GVAR(suppression_threshold) < 0) then {GVAR(suppression_threshold) = 0};
};

