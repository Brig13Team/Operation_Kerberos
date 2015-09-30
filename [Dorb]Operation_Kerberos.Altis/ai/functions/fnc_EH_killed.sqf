
////// WIP //////////

/*
	Author: Dorbedo
	
	Description:
		pirmary to register the dead to the HQ
	
	Parameter(s):
		0:OBJECT	- killed unit
		1:OBJECT	- Killer

	Returns:
		none
*/
#include "script_component.hpp"
_this spawn {
	SCRIPT(EH_killed);
	_this params["_unit","_killer"];
	CHECK(isPlayer _unit)
	CHECK((side _unit)==civilian)

	// register the dead unit into the raster
	[(getPosAGL _unit)] call FUNC(HQ_registerDead);

	// check if other teammember know who killed the Unit

	_otherUnits = (getPosAGL _unit) nearEntities ["Man",30];

	_messagingUnits = [];
	{
		if ((_x knowsAbout _killer)>0.5) then {
			_messagingUnits pushBack [(_x knowsAbout _killer),_x];
		};
	}count (_otherUnits);

	// spawn a send_msg with the enemypos to the HQ
	_messagingUnits sort false;

	uiSleep 10;

	{
		If ((!isNull _x)&&{alive _x}) exitWith {
			If ((_x knowsAbout _killer)>2) then {
				/// call support
			}else{
				/// call recon
			};
		};
	}forEach _messagingUnits;

};