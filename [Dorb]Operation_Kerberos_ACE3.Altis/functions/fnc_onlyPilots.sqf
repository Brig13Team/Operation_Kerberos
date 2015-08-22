/*
	author: iJesuz, Dorbedo

	description:
		only pilots are allowed to fly (new extended eventhandler based version)

	parameter:
		0: GROUP - group of player
		1: ARRAY - position of player
		2: UNIT - player
		3: ARRAY - turret
*/
#include "script_component.hpp"

params["_group","_position","_unit","_turret"];

// schmeißt alle nicht Piloten aus Dreh- und Starrflüglern
if (((_turret isEqualTo [0]) || (_position == "driver")) && !((typeOf _unit) in ["B_Pilot_F","B_Helipilot_F"])) then {
	if ((_position == "driver") || {isNull driver (vehicle _unit)}) then { (vehicle _unit) engineOn false; };
	_unit action ["GetOut", vehicle _unit];
	if (isPlayer _unit) then { hint format[localize "STR_DORB_NURPILOTEN",name player]; };
};

#ifdef DORB_PILOT_WHITELIST_ENABLED
// entfernt Piloten, welche nicht gewhitelisted sind
if ( (IS_ATTACK_HELI(typeOf vehicle _unit) || IS_ATTACK_PLANE(typeOf vehicle _unit)) && {!(getPlayerUID _unit in (["_SP_AI_","_SP_PLAYER_"]))} && {!isNil "DORB_RESERVED_PILOT_SLOT"} ) then {
	if ((_position == "driver") || {isNull driver (vehicle _unit)}) then { (vehicle _unit) engineOn false; };
	_unit action ["GetOut", vehicle _unit];
	if (isPlayer _unit) then { hint format[localize "STR_DORB_NURPILOTEN",name player]; };
};
#endif
