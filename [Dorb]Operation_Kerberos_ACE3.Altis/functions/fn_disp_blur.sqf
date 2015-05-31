/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"

CHECK(isDedicated)

private ["_id", "_show"];
_id = [_this, 0, "", [""]] call BIS_fnc_Param;
_show = [_this, 1, false, [false]] call BIS_fnc_Param;

if (isnil "DORB_DISP_BLUR_ARR") then {
	DORB_DISP_BLUR_ARR = [];
};

if (_show) then {
	DORB_DISP_BLUR_ARR pushback _id;
	// show blur
	if (isnil 'DORB_DISP_BLUR') then {
		DORB_DISP_BLUR = ppEffectCreate ["DynamicBlur", 102];
		DORB_DISP_BLUR ppEffectAdjust [0.9];
		DORB_DISP_BLUR ppEffectEnable true;
		DORB_DISP_BLUR ppEffectCommit 0;
	};
} else {
	DORB_DISP_BLUR_ARR = DORB_DISP_BLUR_ARR - [_id];
	if (DORB_DISP_BLUR_ARR isEqualTo []) then {
		// hide blur
		if (!isnil 'DORB_DISP_BLUR') then {
			ppEffectDestroy DORB_DISP_BLUR;
			DORB_DISP_BLUR = nil;
		};
	};
};