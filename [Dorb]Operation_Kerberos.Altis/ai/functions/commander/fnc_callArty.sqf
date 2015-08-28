/*
	Author: Dorbedo
	
	Description:
		AI-Commander HQ
	
	Parameter(s):
		0 : OBJECT	- HQ
	
*/
#define DEBUG_ENABLED_TEST
#include "script_component.hpp"
SCRIPT(spawn_commander_callArty);
params["_attack_pos",["_count",3,[0]]];
private["_artilleries","_shell","_rand"];
_artilleries = GETVAR(GVAR(commander_logic),GVAR(commander_artillerie),[]);

If (_count < 0) then {
	private["_nearUnits","_nearEnemy","_nearFriendly","_enemy"];
	_shell = "";
	// Get Units near Target
	_nearUnits = _attack_pos nearEntities ["Man", 70];   //// artillery is placed around AO -> scatter around 100m
	_nearEnemy = {((side _x == EGVAR(main,playerside))&&(!(vehicle _x isKindOf "Air")))} count _nearUnits;
	_nearFriendly = {((side _x == dorb_side)&&(!(vehicle _x isKindOf "Air")))} count _nearUnits;
	
	// Choose Ammunition
	_enemy = ObjNull;
	{If ((side _x == EGVAR(main,playerside))&&((vehicle _x ) isKindOf "LandVehicle")) exitWith {_enemy = _x;};}forEach (_attack_pos nearEntities ["Man", 20]);
	If (!isNull _enemy) then {
		/// AttackVehicle
		_rand = floor(random 3);
		switch (_rand) do {
			case 0 : {_count = 1;_shell = "6Rnd_155mm_Mo_AT_mine";};
			case 1 : {_count = 1;_shell = "2Rnd_155mm_Mo_guided";};
			default 	{_count = 3;_shell = "";};
		};
	}else{
		/// AttackVehicle
		If ((_nearEnemy > 4)&&(_nearFriendly<2)) then {
			_rand = floor(random 3);
			switch (_rand) do {
				case 0 : {_count = 1;_shell = "6Rnd_155mm_Mo_mine";};
				case 1 : {_count = 1;_shell = "2Rnd_155mm_Mo_Cluster";};
				default 	{_count = 3;_shell = "";};
			};
		}else{
			default 	{_count = 3;_shell = "";};
		};
	};
		
	// Fire
	{
		if (!(_shell in getArtilleryAmmo [_x])) then {_shell_cur = ((getArtilleryAmmo [_x])select 0);};
		if (alive _x) then {_x commandArtilleryFire [_attack_pos,_shell_cur,_count];};
		_x setAmmo 1;
	} forEach _artilleries;
}else{
	{
		if (alive _x) then {_x commandArtilleryFire [_attack_pos,((getArtilleryAmmo [_x])select 0),_count];};
		_x setAmmo 1;
	} forEach _artilleries;
};