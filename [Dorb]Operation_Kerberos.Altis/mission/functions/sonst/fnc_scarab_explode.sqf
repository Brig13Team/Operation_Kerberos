scriptname "dorb\mission\sonst_Scarab_explode";
private["_yield","_radius"];
params["_pos"];

_yield = getNumber(configFile >> "cfgAmmo" >> "RHS_9M79B" >> "yield");
_radius = 500;
[_pos,_yield,_radius] call RHS_fnc_ss21_nuke;