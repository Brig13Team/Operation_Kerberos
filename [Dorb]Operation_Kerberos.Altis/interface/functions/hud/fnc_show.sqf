/*
	Author: Dorbedo
	
	Description:
		shows impact point
	
	Parameter(s):
		0 : OBJECT - Aircraft
	
*/
#include "script_component.hpp"
SCRIPT(hud_show);
(_this select 0) params["_plane"];
/// exit if player isn't pilot or gunner
If (!((toLower((assignedVehicleRole player)select 0)) in ["driver","turret"])) exitWith {};
/// exit if weapon is not supported or has no more ammo
If ((!((currentweapon _plane) in (getArray(missionConfigFile >> "hud" >> "Aircraft" >> (typeOf(vehicle player)) >> "weapons"))))||((_plane ammo (currentweapon _plane))==0)) exitWith {};
private["_ammoName","_initSpeed","_mass","_vecDir","_vel","_bulletVelVec","_allweaponpositions","_modelSpaceGunPos","_gunPos","_impactpoint","_impactstr","_drawColor"];
_ammoName         = getText  (configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "ammo");
_initSpeed        = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "initSpeed");
_mass             = getNumber(configFile >> "CfgMagazines" >> (currentMagazine _plane) >> "mass");

_vecDir =_plane weaponDirection (currentWeapon _plane);
_vel = velocity _plane;
_bulletVelVec = _vecDir vectorMultiply _initSpeed;

_allweaponpositions = getArray(missionConfigFile >> "hud" >> "Aircraft" >> (typeOf _plane) >> "positions");
_modelSpaceGunPos = (_allweaponpositions select ([_allweaponpositions,(currentWeapon _plane)] call BIS_fnc_findInPairs))select 1;
_modelSpaceGunPos = _modelSpaceGunPos vectorAdd  ((velocityModelSpace _plane) vectorMultiply -0.11);
_gunPos = _plane modelToWorld _modelSpaceGunPos;
If(!(surfaceIsWater _gunPos)) then {_gunPos = ATLToASL _gunPos;};

_impactpoint = [_ammoName,_gunPos,_vel,_bulletVelVec,_mass] call FUNC(hud_getImpact);

/// show the target
_impactstr = str((floor((_impactpoint distance _plane)/10))*10);
_drawColor = [0,1,0,0.5];//green
//if(ccip_resultIndex < 0) then {
    //_drawColor = [1,.22,0,0.5]//Orange
//};

drawIcon3D ["\A3\ui_f\data\igui\cfg\weaponcursors\arifle_gs.paa", _drawColor, _impactpoint, 1, 1, 0, _impactstr, 2, 0.0175 * SafeZoneW];