
_unit = _this;

_unit respawnVehicle [30];
[[_unit]] call dorb_fnc_aftervehiclerespawn;
_unit addEventHandler ["Respawn", {[_this] call dorb_fnc_aftervehiclerespawn;}];
_unit addEventHandler ["Killed", {[_this] call dorb_fnc_onVehicleKilled;}];