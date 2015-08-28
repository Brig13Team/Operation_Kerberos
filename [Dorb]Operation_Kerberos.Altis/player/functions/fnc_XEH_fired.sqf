_this spawn {
	scriptname "dorb\player\XEH_fired";
	if((getposatl (_this select 0) distance2D getposatl base) >51) exitwith {};
	deleteVehicle (_this select 5);
	[localize "STR_DORB_BASE_FIRE",localize "STR_DORB_BASE",true] call BIS_fnc_guiMessage;
};