/*
	Author: Dorbedo
	
	Description:
		Backpack on Chest
		handle
	
*/
#include "script_component.hpp"
SCRIPT(change);
private ["_backpack","_isHalo"];
player forceWalk true;
_backpack = (GETVAR(player,GVAR(backpack_pack),objNull));
If (isNull _backpack) exitwith {[_this select 1] call CBA_fnc_removePerFrameHandler;player forceWalk false;};

if ((player != (vehicle player))&&(!((GETVAR(player,GVAR(backpack_anim),""))isEqualTo(animationState player)))) exitwith {
	SETVAR(player,GVAR(backpack_anim),(animationState player));
	_isParachute = ((vehicle player) isKindOf "ParachuteBase");
	if (_isParachute) then {
		_backpack attachTo [(vehicle player),[-0.08,0.55,-0.42]];
		_backpack setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];
	} else {
		detach _backpack;
		_backpack setPos [random 50,random 50,(10000 + (random 50))];
	};
};


IF (!((GETVAR(player,GVAR(backpack_anim),""))isEqualTo(animationState player))) then {
	SETVAR(player,GVAR(backpack_anim),(animationState player));
	_isHalo = (("halofreefall" in ((animationState player) splitString "_"))||((stance player) isEqualTo "PRONE"));
	if ((_isHalo)) then {
		_backpack attachTo [player,[-0.1,-0.4,-0.75],"pelvis"];
		_backpack setVectorDirandup [[0,-1,0],[0,0,-1]];
	}else{
		_backpack attachTo [player,[-0.1,0.75,-0.4],"pelvis"];
		_backpack setVectorDirAndUp [[0,0,-1],[0,1,0]];
	};
};

true


/*

/// pelvis = Hüfte
/// spine3 = Rückrat 3
/// rightshoulder   leftshoulder



test=((player selectionPosition "rightshoulder") vectorFromTo (player selectionPosition "pelvis"))vectorAdd(((player selectionPosition "rightshoulder") vectorFromTo (player selectionPosition "pelvis"))vectorCrossProduct((player selectionPosition "leftshoulder") vectorFromTo (player selectionPosition "pelvis")));
test2=((player selectionPosition "spine3") vectorFromTo (player selectionPosition "pelvis"));
test3 setVectorDirAndUp [test,test2];


	test3 = createVehicle ["groundWeaponHolder", (getPos player) , [], 0, "can_collide"];
	test3 addBackpackCargoGlobal [(backpack player), 1];
	test3 attachTo [player,[-0.1,0.75,-0.4],"pelvis"];
	test3 setVectorDirAndUp [[0,0,-1],[0,1,0]];
	removebackpackglobal player;
	player forceWalk false;
	
*/