/*
    Author: Dorbedo

    Description:
        cacheing handler

    Parameter(s):
        

*/
#include "script_component.hpp"


If (!GVAR(enabled)) exitWith {
	[(_this select 1)] call CBA_fnc_removeEventhandler;
	{
		[_x,false] call FUNC(cache);
	} forEach allGroups;
};

{
	private _currentGroup = _x;
	private _canBeCached = ({
		(isPlayer _x)||
		(side _x == GVAR(playerside))||
		(vehicle _x isKindOf "Air")||
		{("Artillery" in getArray(configFile>>"cfgVehicles">>typeOf _x>>"availableforsupporttypes"))}
	} count (units _currentGroup))==0;
	
	If (_canBeCached) then {
		private _groupPos = getPos (_leader _currentGroup);
		If !(_currentGroup in GVAR(cachedGroups)) then {
			private _addToCache = false;
			{
				private _distance = switch (true) do {
					case ((vehicle _x) isKindOf "Air") : {GVAR(distances) select 1 + GVAR(distances) select 3};
					case ((vehicle _x) isKindOf "LandVehicle") : {GVAR(distances) select 1 + GVAR(distances) select 3};
					default {GVAR(distances) select 0};
				};
			
				If ((_x distance _groupPos)<_distance) exitWith {
					_addToCache = true;
				};
				nil;
			} count allPlayers;
			If (_addToCache) then {[_currentGroup,true] call FUNC(cache);};
		}else{
			private _removeFromCache = false;
			{
				private _distance = switch (true) do {
					case ((vehicle _x) isKindOf "Air") : {GVAR(distances) select 1 + GVAR(distances) select 3};
					case ((vehicle _x) isKindOf "LandVehicle") : {GVAR(distances) select 1 + GVAR(distances) select 3};
					default {GVAR(distances) select 0};
				};
			
				If ((_x distance _groupPos)<_distance) exitWith {
					_removeFromCache = true;
				};
				nil;
			} count allPlayers;
			If (_removeFromCache) then {[_currentGroup,false] call FUNC(cache);};
		};
	};
	nil;
} count allGroups;

