/*
	Author: Dorbedo
	
	Description:
		Wahrscheinlichkeiten der Kommandofahrzeuge
	
	Parameter(s):
		0 : ARRAY	- Position
	
*/
#include "makros.hpp"

private["_position","_rand"];

_position = _this select 0;

_rand = floor (random 15);

If ((_rand >= 0)&&(_rand < 3)) then {[_position] FSPAWN(spawn_commandveh_airdrop);};
If ((_rand >= 3)&&(_rand < 6)) then {[_position] FSPAWN(spawn_commandveh_sniper);};
If ((_rand >= 6)&&(_rand < 9)) then {[_position] FSPAWN(spawn_commandveh_artillery);};
If ((_rand >= 9)&&(_rand < 12)) then {[_position] FSPAWN(spawn_commandveh_mech);};
If ((_rand >= 12)&&(_rand < 15)) then {[_position] FSPAWN(spawn_commandveh_tanks);};		//etwas geringere Wahrscheinlichkeit, da sehr stark

_rand = floor (random 4);
If (_rand < 2) then {[_position] FSPAWN(spawn_commandveh_antiair);};