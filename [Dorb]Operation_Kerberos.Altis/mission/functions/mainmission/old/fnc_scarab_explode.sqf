#include "script_component.hpp"
_this params["_pos"];
private _yield = getNumber(configFile >> "cfgAmmo" >> "RHS_9M79B" >> "yield");
private _radius = 500;
[_pos,_yield,_radius] call RHS_fnc_ss21_nuke;