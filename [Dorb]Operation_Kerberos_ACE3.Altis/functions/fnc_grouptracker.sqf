/*
	Author: Dorbedo
	
	Description:
		Grouptracker
		
	ARMA Version 1.48
*/
scriptName "DORB_GROUPTRACKER";
If(!hasInterface)exitWith{};

#define SELF dorb_fnc_grouptracker
#define REFRESHTIME 4

private ["_mode","_params","_return"];
_mode 	= [_this, 0, "", [""]] call BIS_fnc_param;

switch (_mode) do {

	case "init" : {
		/*
			Initialize the grouptracker
		*/
		private ["_gruppen","_marker"];
		_gruppen=[];
		_marker=[];
		DORB_GPTR_DATA=[];
		
		DORB_GPTR_AKTIV=true;
		DORB_GPTR_COLOR = switch (true) do {
			case (playerSide==west) : 		{DORB_GPTR_INDEX=0;"ColorBLUFOR"};
			case (playerSide==east) : 		{DORB_GPTR_INDEX=1;"ColorOPFOR"};
			case (playerSide==resistance) : {DORB_GPTR_INDEX=2;"ColorIndependent"};
			case (playerSide==civilian) : 	{DORB_GPTR_INDEX=3;"ColorCivilian"};
			default {"ColorBlack"}
		};
		DORB_GPTR_PREFIX = switch (true) do {
			case (playerSide == east) : {"o_"};
			case (playerSide == resistance) : {"n_"};
			default {"b_"};
		};
		
		while {DORB_GPTR_AKTIV} do {
			
			_gruppen = ["gruppen"] call SELF;

			{
				private "_arraypos";
				_arraypos = [DORB_GPTR_DATA, _x] call BIS_fnc_findNestedElement; //Expected result: [1, 0]
				If (_arraypos isEqualTo []) then {
					DORB_GPTR_DATA pushBack [_x,(["create",_x] call SELF)];
				};
			}forEach _gruppen;
			
			/// Deletes old Marker
			for "_i" from 0 to ((count DORB_GPTR_DATA)-1) do {
				/// Entfernt die Marker von nicht mehr existententen Gruppen
				if (isNull((DORB_GPTR_DATA select _i)select 0)) then {			
					_del = DORB_GPTR_DATA deleteAt _i;
					deleteMarkerLocal (_del select 1);
				};
			};
			for "_i" from 0 to ((count DORB_GPTR_DATA)-1) do {
				if (((DORB_GPTR_DATA select _i)select 1)isEqualTo "") then {			
					DORB_GPTR_DATA deleteAt _i;
				};
			};
			for "_i" from 0 to ((count DORB_GPTR_DATA)-1) do {
				if (count (units ((DORB_GPTR_DATA select _i)select 0))<1) then {			
					_del = DORB_GPTR_DATA deleteAt _i;
					deleteMarkerLocal (_del select 1);
				};
			};
			
			/// Updates the position
			{
				_x = ["update",_x] call SELF;
			}forEach DORB_GPTR_DATA;

			sleep REFRESHTIME;
		};
	};
	case "gruppen": {
		/*
			returns a list with the groups
		*/
		private ["_alleGruppen","_gruppen","_KI"];
		_alleGruppen = allGroups;
		_gruppen = [];
		_KI=true;
		{
			// Disable Groups with KI-Leader - uncomment following line
			//_KI = (isPlayer(leader _x ));
			If ((_KI) and (side(leader _x ) == playerSide)and((count (units _x)) >0)) then {
				_gruppen pushBack _x;
			};
		}forEach _alleGruppen;
		_gruppen
	};
	case "create": {
		/*
			creates a local Marker
		*/
		private["_mark","_group"];
		_group = param[1, grpNull,[grpNull]];
		If ((isNull _group)||(!alive (leader _group))) exitWith {""};
		_mark = createMarkerLocal [format["%1",_group],getPos (leader _group)];
		_mark setMarkerShapeLocal "ICON";
		_mark setMarkerColorLocal DORB_GPTR_COLOR;
		_mark setMarkerTypeLocal (["symbol",leader _group] call SELF);
		_mark setMarkerTextLocal (groupID _group);
		format["%1",_group]
	};
	case "symbol" : {
		/*
			returns the vehicle-symbol of the leader. Civilian count as bluefor
		*/
		private ["_post","_leader"];
		_leader = param[1, objNull,[objNull]];
		if (!alive _leader) exitWith {"unknown"};
		_post = switch (true) do {
			case ((vehicle _leader isKindOf "MBT_01_arty_base_F")or(vehicle _leader isKindOf "MBT_01_mlrs_base_F")) : {"art"};
			case ((vehicle _leader isKindOf "Wheeled_Apc_F")or(vehicle _leader isKindOf "APC_Tracked_02_base_F")or(vehicle _leader isKindOf "APC_Tracked_03_base_F")) : {"mech_inf"};
			case (vehicle _leader isKindOf "Tank") : {"armor"};
			case (vehicle _leader isKindOf "Car") : {"motor_inf";};
			case ((vehicle _leader isKindOf "Ship")or(vehicle _leader isKindOf "Submarine")) : {"naval"};
			case (vehicle _leader isKindOf "Autonomous") : {"uav"};
			case (vehicle _leader isKindOf "Plane") : {"plane"};
			case (vehicle _leader isKindOf "Air") : {"air"};
			case ((vehicle _leader isKindOf "Man")||(vehicle _leader isKindOf "StaticWeapon")) : {"inf"};
			default {"unknown"};
		};
		format["%1%2",DORB_GPTR_PREFIX,_post]
	};
	case "update" : {
		/*
			updates the position of the unit
		*/
		private ["_gruppe","_marker","_return"];
		(_this select 1) params[["_gruppe",grpNull,[grpNull]],["_marker","",[""]]];
		If (count (units _gruppe)<1) then {
			[grpNull,_marker];
		}else{
			if (alive(leader _gruppe)) then {
				_marker setMarkerPosLocal (getPos(leader _gruppe));
				_marker setMarkerTextLocal (groupID _gruppe);
				_marker setMarkerTypeLocal (["symbol",leader _gruppe] call SELF);
			};
			[_gruppe,_marker];
		};
	};
	case "terminate"	 : {
		/*
			terminates the grouptracker
		*/
		DORB_GPTR_AKTIV=false;
		{
			deleteMarkerLocal (_x select 1);
		}forEach DORB_GPTR_DATA;
		DORB_GPTR_DATA=[];
	};
	case "restart"	 : {
		/*
			restarts the grouptracker
		*/
		if(isNil "DORB_GPTR_AKTIV")exitWith{};
		DORB_GPTR_AKTIV=false;
		["terminate"] call SELF;
		uisleep 10;
		["init"] spawn SELF;
	};
};