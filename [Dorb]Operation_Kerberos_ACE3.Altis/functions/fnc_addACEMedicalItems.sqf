/*
	Author: Dorbedo
	
	Description:
		adds Medical Supplys to a unit
*/
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
	_vehicle addItemCargoGlobal ["ACE_atropine"			, 40];
	_vehicle addItemCargoGlobal ["ACE_fieldDressing"	, 120];
	_vehicle addItemCargoGlobal ["ACE_elasticBandage"	, 120];
	_vehicle addItemCargoGlobal ["ACE_quikclot"			, 150];
	_vehicle addItemCargoGlobal ["ACE_bloodIV"			, 20];
	_vehicle addItemCargoGlobal ["ACE_bloodIV_500"		, 30];
	_vehicle addItemCargoGlobal ["ACE_bloodIV_250"		, 30];
	_vehicle addItemCargoGlobal ["ACE_bodyBag"			, 15];
	_vehicle addItemCargoGlobal ["ACE_epinephrine"		, 40];
	_vehicle addItemCargoGlobal ["ACE_morphine"			, 40];
	_vehicle addItemCargoGlobal ["ACE_packingBandage"	, 60];
	_vehicle addItemCargoGlobal ["ACE_personalAidKit"	, 30];
	_vehicle addItemCargoGlobal ["ACE_plasmaIV"			, 20];
	_vehicle addItemCargoGlobal ["ACE_plasmaIV_500"		, 30];
	_vehicle addItemCargoGlobal ["ACE_plasmaIV_250"		, 30];
	_vehicle addItemCargoGlobal ["ACE_salineIV"			, 40];
	_vehicle addItemCargoGlobal ["ACE_salineIV_500"		, 50];
	_vehicle addItemCargoGlobal ["ACE_salineIV_250"		, 50];
	_vehicle addItemCargoGlobal ["ACE_surgicalKit"		, 30];
	_vehicle addItemCargoGlobal ["ACE_tourniquet"		, 40];
};
true