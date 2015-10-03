/*
	Author: Dorbedo, iJesuz
	
	Description:
		Grouptracker
		
	ARMA Version 1.48
*/
scriptName "dorb\player\grouptracker";
If(!hasInterface)exitWith{};

#define SELF dorb_player_fnc_grouptracker
#define REFRESHTIME 4

private ["_mode","_params","_return"];
_mode = [_this, 0, "", [""]] call BIS_fnc_param;

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

			private "_anzahl";
			_anzahl = ((count DORB_GPTR_DATA)-1);
			for "_i" from 0 to _anzahl do {
				/// Entfernt die Marker von nicht mehr existententen Gruppen
				private "_delete";
				_delete = 0;
				if (((DORB_GPTR_DATA select _i)select 1)isEqualTo "") then { _delete = 1; };
				if (isNull((DORB_GPTR_DATA select _i)select 0)) then { _delete = 2; };
				if ((!isNull((DORB_GPTR_DATA select _i)select 0))&&{(count (units ((DORB_GPTR_DATA select _i)select 0)))<1}) then { _delete = 2; };

				If (_delete > 0) then {
					_del = DORB_GPTR_DATA deleteAt _i;
					If (_delete > 1) then {
						deleteMarkerLocal (_del select 1);
						deleteMarkerLocal ((_del select 1) + "_size");
					};
					_anzahl = _anzahl - 1;
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
		private["_mark","_mark2","_group","_groupID"];
		_group = param[1, grpNull,[grpNull]];
		If ((isNull _group)||(!alive (leader _group))) exitWith {""};
		_groupID = groupID _group;
		_mark = createMarkerLocal [_groupID,getPos (leader _group)];
		_mark2 = createMarkerLocal [_groupID + "_size",getPos (leader _group)];
		
		_mark setMarkerShapeLocal "ICON";
		_mark setMarkerColorLocal DORB_GPTR_COLOR;
		_mark setMarkerTypeLocal (["symbol",leader _group] call SELF);
		_mark setMarkerTextLocal _groupID;
		
		_mark2 setMarkerShapeLocal "ICON";
		_mark2 setMarkerColorLocal "ColorBlack";
		_mark2 setMarkerTypeLocal (["symbol_size",leader _group, getMarkerType _mark] call SELF);

		_groupID
	};
	case "symbol": {
		/*
			returns the vehicle-symbol of the leader. Civilian count as blufor
		*/
		private ["_post","_leader"];
		_leader = param[1, objNull,[objNull]];
		if (!alive _leader) exitWith {"unknown"};
		_post = switch (true) do {
			case ((typeOf vehicle _leader) in ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"]): {"hq"};
			case (getText(configFile >> "cfgVehicles" >> typeOf _leader >> "vehicleclass") in ["MenSniper","MenRecon"]) : {"recon"};
			case (getNumber(configFile >> "CfgVehicles" >> typeOf _leader >> "engineer") == 1): {"maint"};
			case ((vehicle _leader isKindOf "MBT_01_arty_base_F")or(vehicle _leader isKindOf "MBT_01_mlrs_base_F")) : {"art"};
			case ((vehicle _leader isKindOf "Wheeled_Apc_F")or(vehicle _leader isKindOf "APC_Tracked_02_base_F")or(vehicle _leader isKindOf "APC_Tracked_03_base_F")) : {"mech_inf"};
			case (vehicle _leader isKindOf "Tank") : {"armor"};
			case (vehicle _leader isKindOf "Car") : {"motor_inf";};
			case ((vehicle _leader isKindOf "Ship")or(vehicle _leader isKindOf "Submarine")) : {"naval"};
			case ((vehicle _leader isKindOf "Autonomous")or(vehicle _leader isKindOf "UAV")) : {"uav"};
			case (vehicle _leader isKindOf "Plane") : {"plane"};
			case (vehicle _leader isKindOf "Air") : {"air"};
			case (vehicle _leader isKindOf "Man") : {"inf"};
			case (vehicle _leader isKindOf "StaticWeapon") : {"support"};
			default {"unknown"};
		};
		DORB_GPTR_PREFIX + _post
	};
	case "symbol_size": {
		/*
			returns the size symbol
		*/
		private["_leader","_group"];
		_leader = param[1, objNull,[objNull]];
		_marker = param[2, "",[""]];
		if (!alive _leader) exitWith {"Empty"};
		_group = group _leader;
		if ((count units _group) < 2) exitWith {"Empty"};
		if (_marker in [ DORB_GPTR_PREFIX + "art", DORB_GPTR_PREFIX + "armor", DORB_GPTR_PREFIX + "plane", DORB_GPTR_PREFIX + "air" ]) exitWith {
			private ["_vehicles","_ret"];
			_vehicles = [];
			{
				if ( (!((vehicle _x) isKindOf "Man")) && { !((vehicle _x) in _vehicles) } ) then { _vehicles pushBack (vehicle _x); };
			} forEach (units _group);
			_ret = "Empty";
			// if ((count units _vehicles) == 1) then { _ret = "group_1"; };
			if ((count _vehicles) == 2) then { _ret = "group_2"; };
			if ((count _vehicles) >= 3) then { _ret = "group_3"; };
			_ret
		};
		if (_marker in [ DORB_GPTR_PREFIX + "inf", DORB_GPTR_PREFIX + "mech_inf", DORB_GPTR_PREFIX + "motor_inf", DORB_GPTR_PREFIX + "recon", DORB_GPTR_PREFIX + "maint", DORB_GPTR_PREFIX + "support" ]) exitWith {
			private "_ret";
			_ret = "Empty";
			if ((count units _group) >=  2) then { _ret = "group_1"; };
			if ((count units _group) >=  9) then { _ret = "group_2"; };
			if ((count units _group) >= 13) then { _ret = "group_3"; };
			_ret
		};
		"Empty"
	};
	case "update": {
		/*
			updates the position of the unit
		*/
		private ["_gruppe","_marker","_marker2","_return"];
		(_this select 1) params[["_gruppe",grpNull,[grpNull]],["_marker","",[""]]];
		_marker2 = format["%1_size",_marker];
		If (count (units _gruppe)<1) then {
			[grpNull,_marker];
		}else{
			if (alive(leader _gruppe)) then {
				_marker setMarkerPosLocal (getPos(leader _gruppe));
				_marker setMarkerTextLocal (groupID _gruppe);
				_marker setMarkerTypeLocal (["symbol",leader _gruppe] call SELF);

				_marker2 setMarkerPosLocal (getPos(leader _gruppe));
				_marker2 setMarkerTypeLocal (["symbol_size",leader _gruppe,getMarkerType _marker] call SELF);
			};
			[_gruppe,_marker];
		};
	};
	case "terminate": {
		/*
			terminates the grouptracker
		*/
		DORB_GPTR_AKTIV=false;
		{
			deleteMarkerLocal (_x select 1);
			deleteMarkerLocal ((_x select 1) + "_size");
		}forEach DORB_GPTR_DATA;
		DORB_GPTR_DATA=[];
	};
	case "restart": {
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