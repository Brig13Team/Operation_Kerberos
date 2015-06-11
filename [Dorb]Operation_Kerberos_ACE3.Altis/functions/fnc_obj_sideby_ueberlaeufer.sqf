/*
	Author: iJesuz
	
	Description:
		Überläufer erstellen
		Eigenschaften:
			Flugangst --> wenn er geflogen wird der Radius der Infos größer
			Paranoia --> wenn er mit zuviel Ammis in Kontakt kommt, denkt er sich zufällige Positionen aus
			Suizidgefährdet --> wenn er nach dem ersten Kontakt mit Ammis den Kontakt zu lang verliert, macht er Selbstmord
			nichts --> nichts

	Parameter(s):
		0 : Array - Position
*/
#include "script_component.hpp"

private ["_position", "_ziel", "_zielPos", "_kleidung"];

_position = _this select 0;

_zielPos = _position;
// TODO: place him in a near building (50 m for example)

_ziel = [_zielPos, createGroup civilian, "C_man_polo_1_F"] call FM(spawn_unit);
removeAllWeapons _ziel; removeAllItems _ziel; removeAllAssignedItems _ziel; removeUniform _ziel; removeVest _ziel; removeBackpack _ziel; removeHeadgear _ziel; removeGoggles _ziel; _ziel forceAddUniform "U_I_OfficerUniform"; for "_i" from 1 to 3 do {_ziel addItemToUniform "ACE_fieldDressing";}; _ziel addItemToUniform "ACE_EarPlugs"; for "_i" from 1 to 2 do {_ziel addItemToUniform "ACE_morphine";}; _ziel addItemToUniform "ACE_atropine"; _ziel addItemToUniform "ACE_epinephrine"; _ziel addItemToUniform "ACE_packingBandage"; _ziel addItemToUniform "ACE_elasticBandage"; _ziel addItemToUniform "ACE_Banana"; for "_i" from 1 to 2 do {_ziel addItemToUniform "30Rnd_9x21_Mag";}; _ziel addHeadgear "H_MilCap_dgtl"; _ziel addGoggles "G_Squares"; _ziel addWeapon "hgun_PDW2000_F"; _ziel addPrimaryWeaponItem "muzzle_snds_L";
_eigenschaften = ["Flugangst", "Paranoia", "suizidgefaehrdet", "nichts"];
_wichtung = [0.125, 0.25, 0.01, 1];
_eigenschaft = [_eigenschaften, _wichtung] call BIS_fnc_selectRandomWeighted;
_eigenschaft = "Flugangst";

LOG(FORMAT_2("[SIDEBY] Ueberlaeufer an Position %1 mit Eigenschaft %2 erstellt!", position _ziel, _eigenschaft));

[_ziel, _eigenschaft] call FM(TRIPLES(obj,sideby,ueberlaeuferVerhoeren));
