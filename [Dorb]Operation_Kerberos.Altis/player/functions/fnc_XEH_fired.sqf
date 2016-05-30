_this spawn {
	scriptname "dorb\player\XEH_fired";
	if((getposatl (_this select 0) distance2D (getMarkerPos "respawn_west")) >51) exitwith {};
	(_this select 5) setPos [0,0,0];
    deleteVehicle (_this select 5);
	[localize "STR_DORB_PLAYER_BASE_FIRE",localize "STR_DORB_PLAYER_BASE",true] call BIS_fnc_guiMessage;
};