/*
	Author: Dorbedo

	Description:
		adds Medical Supplys to a unit
*/
#include "script_component.hpp"
SCRIPT(addAceMedical);
If (!(isClass(configFile >> "CfgPatches" >> "ace_medical"))) exitWith {};
Private["_vehicle"];
params[["_vehicle",objNull,[objNull]]];
If ((isNull _vehicle)||(isNil "ace_medical_level")) exitWith {};

If (ace_medical_level<2) then {
	_vehicle addItemCargoGlobal ["ACE_fieldDressing"	, 150];
	_vehicle addItemCargoGlobal ["ACE_bloodIV"			, 30];
	_vehicle addItemCargoGlobal ["ACE_epinephrine"		, 80];
	_vehicle addItemCargoGlobal ["ACE_morphine"			, 100];
}else{
	If (_vehicle isKindOf "Air") then {
		_vehicle addItemCargoGlobal ["ACE_atropine"			, 20];
		_vehicle addItemCargoGlobal ["ACE_adenosine"		, 20];
		_vehicle addItemCargoGlobal ["ACE_epinephrine"		, 30];
		_vehicle addItemCargoGlobal ["ACE_morphine"			, 30];

		_vehicle addItemCargoGlobal ["ACE_tourniquet"		, 20];
		_vehicle addItemCargoGlobal ["ACE_fieldDressing"	, 50];
		_vehicle addItemCargoGlobal ["ACE_elasticBandage"	, 50];
		_vehicle addItemCargoGlobal ["ACE_quikclot"			, 50];
		_vehicle addItemCargoGlobal ["ACE_packingBandage"	, 50];

		_vehicle addItemCargoGlobal ["ACE_personalAidKit"	, 2];
		_vehicle addItemCargoGlobal ["ACE_surgicalKit"		, 8];
		_vehicle addItemCargoGlobal ["ACE_bodyBag"			, 8];

		_vehicle addItemCargoGlobal ["ACE_bloodIV"			, 4];
		_vehicle addItemCargoGlobal ["ACE_bloodIV_500"		, 8];
		_vehicle addItemCargoGlobal ["ACE_bloodIV_250"		, 12];
		_vehicle addItemCargoGlobal ["ACE_plasmaIV"			, 6];
		_vehicle addItemCargoGlobal ["ACE_plasmaIV_500"		, 10];
		_vehicle addItemCargoGlobal ["ACE_plasmaIV_250"		, 16];
		_vehicle addItemCargoGlobal ["ACE_salineIV"			, 10];
		_vehicle addItemCargoGlobal ["ACE_salineIV_500"		, 16];
		_vehicle addItemCargoGlobal ["ACE_salineIV_250"		, 22];
	}else{
		_vehicle addItemCargoGlobal ["ACE_atropine"			, 30];
		_vehicle addItemCargoGlobal ["ACE_adenosine"		, 40];
		_vehicle addItemCargoGlobal ["ACE_epinephrine"		, 40];
		_vehicle addItemCargoGlobal ["ACE_morphine"			, 40];

		_vehicle addItemCargoGlobal ["ACE_tourniquet"		, 30];
		_vehicle addItemCargoGlobal ["ACE_fieldDressing"	, 80];
		_vehicle addItemCargoGlobal ["ACE_elasticBandage"	, 80];
		_vehicle addItemCargoGlobal ["ACE_quikclot"			, 80];
		_vehicle addItemCargoGlobal ["ACE_packingBandage"	, 80];

		_vehicle addItemCargoGlobal ["ACE_personalAidKit"	, 10];
		_vehicle addItemCargoGlobal ["ACE_surgicalKit"		, 20];
		_vehicle addItemCargoGlobal ["ACE_bodyBag"			, 50];

		_vehicle addItemCargoGlobal ["ACE_bloodIV"			, 10];
		_vehicle addItemCargoGlobal ["ACE_bloodIV_500"		, 16];
		_vehicle addItemCargoGlobal ["ACE_bloodIV_250"		, 22];
		_vehicle addItemCargoGlobal ["ACE_plasmaIV"			, 14];
		_vehicle addItemCargoGlobal ["ACE_plasmaIV_500"		, 28];
		_vehicle addItemCargoGlobal ["ACE_plasmaIV_250"		, 36];
		_vehicle addItemCargoGlobal ["ACE_salineIV"			, 16];
		_vehicle addItemCargoGlobal ["ACE_salineIV_500"		, 30];
		_vehicle addItemCargoGlobal ["ACE_salineIV_250"		, 40];
	};
};
true
