/*
	Author: Dorbedo
	
	Description:
		supression fired EH
	
	Parameter(s):
	

	Return
		none
*/
#include "script_component.hpp"
SCRIPT(init);
CHECK(!hasInterface)

//Variables
GVAR(suppression_threshold) = 0;
GVAR(suppression_lastShotAt) = 0;
GVAR(suppression_isSuppressed) = true;

GVAR(suppression_color) = ppEffectCreate ["colorCorrections", 1501];
GVAR(suppression_color) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
GVAR(suppression_color) ppEffectEnable true;
GVAR(suppression_color) ppEffectCommit 0;
GVAR(suppression_dynamic) = ppEffectCreate ["DynamicBlur", 800];
GVAR(suppression_dynamic) ppEffectAdjust [0];
GVAR(suppression_dynamic) ppEffectCommit 0.3;
GVAR(suppression_dynamic) ppEffectEnable true;
GVAR(suppression_radial) = ppEffectCreate ["RadialBlur", 1003]; 
GVAR(suppression_radial) ppEffectAdjust [0, 0, 0, 0];
GVAR(suppression_radial) ppEffectCommit 0;
GVAR(suppression_radial) ppEffectEnable true;

GVAR(suppression_handle_effect)=[{[] call FUNC(suppression_handle_effect);}, 0.5, [] ] call CBA_fnc_addPerFrameHandler;




