/*
	Author: Dorbedo
	
	Description:
	
	
*/
#include "script_component.hpp"
SCRIPT(disp_blur);
CHECK(isDedicated)
params[["_id","",[""]],["_show",false,[true]]];

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