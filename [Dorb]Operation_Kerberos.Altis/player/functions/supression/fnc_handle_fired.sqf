/*
	Author: Dorbedo
	
	Description:
		supression fired EH
	
	Parameter(s):
	

	Return
		none
*/
#include "script_component.hpp"
SCRIPT(handle_fired);
(_this select 0) params ["_projectile","_hit"];
if !(alive _projectile) exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler;};
private "_detectionDistance";
_detectionDistance = (0.5*_hit + 7) min 28;
CHECK((player distance _projectile)> _detectionDistance)

private ["_value"];
_value = _hit/SUPRESSION_OVERHEAD
if (lineIntersects [getPosASL _projectile, eyepos player, player]) then {
	_detectionDistance = _detectionDistance * 0.65
};

if ((_projectile distance player) <= _detectionDistance) then {
	if (((_projectile distance player) <= 4.3)&&(((vehicle player) == player) || (isTurnedOut player))) then {
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
			uisleep 0.5;
			ppEffectDestroy [_cc,_rBlur];
		};
	};
	_value = (_hit/SUPRESSION_IMPACT);
};
if ((vehicle player == player) || (isTurnedOut player)) then {
	GVAR(supression_threshold) = GVAR(supression_threshold) + _value;
	if (GVAR(supression_threshold) >= SUPRESSION_BORDER) then {
		GVAR(supression_threshold) = GVAR(supression_threshold) min SUPRESSION_MAX;
		if !(GVAR(suppression_isSuppressed)) then {
			[L_fnc_suppress_pinnedDown, 0.5, [] ] call CBA_fnc_addPerFrameHandler;	
		};
	}; 
};
[_this select 1] call CBA_fnc_removePerFrameHandler

