/*
	Author: Dorbedo
	
	Description:
		adds Arsenal to a unit
		can be called via unit-init
*/

scriptname "dorb\kerberos\addArsenal";
If (!(local _this)) exitWith {};

["AmmoboxInit",[_this,true,{true}]] call BIS_fnc_arsenal;