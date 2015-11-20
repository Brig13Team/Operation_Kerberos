/*
	Author: Dorbedo
	
	Description:
		supression fired EH
	
	Parameter(s):
	

	Return
		none
*/
#include "script_component.hpp"
SCRIPT(handle_effect);


if ((GVAR(supression_threshold) >= SUPRESSION_BORDER)&&(alive player)&&(GVAR(supression_active))) then {
	GVAR(supression_isSurpressed) = true;
	_workValue = (GVAR(supression_threshold) - SUPRESSION_BORDER) / (SUPRESSION_MAX - SUPRESSION_BORDER);
	addCamShake 
	[
		(_workValue * 1),		// Power
		2 + (_workValue * 23),	// Frequency
		1.5						// Duration
	];
	GVAR(suppression_dynamic) ppEffectAdjust [(_workValue * 1.28)];
	GVAR(suppression_dynamic) ppEffectCommit 0.5;
	GVAR(suppression_radial) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,(1 - (_workValue * 0.40))],[1,1,1,0]];
	GVAR(suppression_radial) ppEffectCommit 0.5;
	GVAR(suppression_color)  ppEffectAdjust [(_workValue * 0.011), (_workValue * 0.011), 0.2, 0.2];
	GVAR(suppression_color)  ppEffectCommit 0.05;
} else {	
	GVAR(suppression_radial) ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
	GVAR(suppression_radial) ppEffectCommit 0;
	GVAR(suppression_dynamic) ppEffectAdjust [0];
	GVAR(suppression_dynamic) ppEffectCommit 0.3;
	GVAR(suppression_color)  ppEffectAdjust [0, 0, 0, 0];
	GVAR(suppression_color)  ppEffectCommit 0;
	GVAR(supression_isSurpressed) = false;
};


if (GVAR(supression_threshold) > 0) then {
	private ["_shotAt","_subtract"];
	_shotAt 	= false;	
	if ((time - GVAR(supression_lastShotAt)) <= 1.75) then {_shotAt = true};
	
	_subtract = switch (true) do {
		case (_shotAt)  				: {0};
		case (GVAR(supression_isSurpressed))  : {0.6};
		default   						  {1};
	};
	GVAR(supression_threshold) = GVAR(supression_threshold) - _subtract;
	if (GVAR(supression_threshold) < 0) then {GVAR(supression_threshold) = 0};
};

