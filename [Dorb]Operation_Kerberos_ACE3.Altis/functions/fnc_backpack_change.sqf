/*
	Author: Dorbedo
	
	Description:
		Backpack on Chest
		Init
	
	Parameter(s):
		0 : BOOL 	- Move to Chest
	
*/
#include "script_component.hpp"
SCRIPT(backpack_change);
params[["_movetoChest",false,[true]]];
CHECK((_movetoChest)&&((backpack player) isEqualTo ""))

If (_movetoChest) then {
	private ["_backpackarray","_backpack"];
	_backpackarray = [(backpack player),(backpackItems player)];
	SETVAR(player,DORB_BACKPACK,_backpackarray);
	_backpack = createVehicle ["groundWeaponHolder", (getPos player) , [], 0, "can_collide"];
	_backpack addBackpackCargoGlobal [(backpack player), 1];
	_backpack attachTo [player,[-0.1,0.75,-0.4],"pelvis"];
	_backpack setVectorDirAndUp [[0,0,-1],[0,1,0]];
	SETVAR(_backpack,DORB_ISTARGET,true);
	SETVAR(player,DORB_BACKPACK_PACK,_backpack);
	SETVAR(player,DORB_BACKPACK_ANIM,(animationState player));
	removebackpackglobal player;
	[{_this call dorb_fnc_backpack_handle} , 2, [] ] call CBA_fnc_addPerFrameHandler;
}else{
	private["_backpackarray","_backpack"];
	_backpackarray = GETVAR(player,DORB_BACKPACK,[]);
	If (!(_backpackarray isEqualTo [])) then {
		player addBackpackGlobal (_backpackarray select 0);
		{
			player addItemToBackpack _x;
		}forEach (_backpackarray select 1);
		SETVAR(player,DORB_BACKPACK,[]);
	};
	_backpack = GETVAR(player,DORB_BACKPACK_PACK,objNull);
	If (!(isNull _backpack)) then {
		clearBackpackCargoGlobal _backpack;
		detach _backpack;
		deleteVehicle _backpack;
		SETVAR(player,DORB_BACKPACK_PACK,objNull);
		player forceWalk false;
	};
};
