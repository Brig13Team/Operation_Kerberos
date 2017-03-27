/*
 * Author: iJesuz
 *
 * Description:
 *   mission hold per frame handler
 *
 * Parameter:
 *   0 : ARRAY  - args
 *        0 : ARRAY  - position
 *        1 : NUMBER - radius
 *        2 : NUMBER - multiplier
 *        3 : NUMBER - max tickets
 *        4 : HASH   - mission
 *   1 : NUMBER - pfh id
 *
 * Returns:
 *   -
 */
#include "script_component.hpp"

_this params ["_args", "_id"];
_args params ["_position", "_radius", "_multiplier", "_max", "_mission"];

private _tickets = HASH_GET(_mission, "obj_counter");
if (_tickets > _max) exitWith {
   [_id] call CBA_fnc_removePerFrameHandler;

   [QFUNC(obj___message), ["COUNTER", "hold", "green"]] call CBA_fnc_globalEvent;
};

private _players = { (_x distance2D _position) < _radius } count allPlayers;
private _increase = 0;

if (_players == 0 && { _tickets > 0 }) exitWith {
   // position lost ...
   [_id] call CBA_fnc_removePerFrameHandler;
   HASH_SET(_mission, "trigger_failed", true);

   [QFUNC(obj___message), ["TRIGGER_FAILED", "hold", "red"]] call CBA_fnc_globalEvent;
};
if (_players > 0) then {
   // position is hold
   _increase = 1 + (_players - 1)*_multiplier;
   HASH_SET(_mission, "obj_counter", _tickets + _increase);
};

TRACEV_3(_tickets,_increase,_max);
