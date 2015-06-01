/*
	Author: Dorbedo
	
	Description:
		Grouptracker
*/

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
		DORB_GPTR_MARKERNAME=[];
		DORB_GPTR_MARKER=[];
		
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
				if(!(_x in _marker)) then {
					DORB_GPTR_MARKERNAME pushBack (["create",_x] call SELF);
					_marker pushBack _x;
				};
			}forEach _gruppen;
			
			/// Deletes old Marker
			for "_i" from 0 to ((count _marker)-1) do {
				
				/// Entfernt die Marker von nicht mehr existententen Gruppen
				if (isNull(_marker select _i)) then {			
					_del = DORB_GPTR_MARKERNAME select _i;
					_marker set [_i,-1];
					DORB_GPTR_MARKERNAME set[_i,-1];
					//_marker deleteAt _i;
					//DORB_GPTR_MARKERNAME deleteAt _i;
					if (!(_del in DORB_GPTR_MARKERNAME)) then {
						deleteMarkerLocal _del;
					};
				};
				
				/// Entfernt die Marker, falls sich die Gruppen-ID geändert hat
				If ((count DORB_GPTR_MARKERNAME) < _i) then {
					If ((format["%1",(_marker select _i)])!=(DORB_GPTR_MARKERNAME select _i)) then {
						deleteMarkerLocal (DORB_GPTR_MARKERNAME select _i);
						_marker set [_i,-1];
						DORB_GPTR_MARKERNAME set[_i,-1];
						//_marker deleteAt _i;
						//DORB_GPTR_MARKERNAME deleteAt _i;
					};		
				};
				
			};
			
			/// Entfernt doppelte Einträge
			If((count _marker >0)&&((count _marker)!=(count DORB_GPTR_MARKERNAME))) then {
				for "_i" from 0 to ((count DORB_GPTR_MARKERNAME)-2) do {
					for "_j" from (_i+1) to ((count DORB_GPTR_MARKERNAME)-1) do {
						If ((DORB_GPTR_MARKERNAME select _i) isEqualTo (DORB_GPTR_MARKERNAME select _j)) then {
							//DORB_GPTR_MARKERNAME deleteAt _j;
							DORB_GPTR_MARKERNAME set[_j,-1];
						};
					};
				};
			};
			_marker = _marker - [-1];
			DORB_GPTR_MARKERNAME = DORB_GPTR_MARKERNAME - [-1];
			
			for "_i" from 0 to ((count _marker)-1) do {
				if (count (units (_marker select _i))<1) then {
					deleteMarkerLocal (DORB_GPTR_MARKERNAME select _i);
					_marker set [_i,-1];
					DORB_GPTR_MARKERNAME set[_i,-1];
				};
			};
			
			_marker = _marker - [-1];
			DORB_GPTR_MARKERNAME = DORB_GPTR_MARKERNAME - [-1];
			
			DORB_GPTR_MARKER=_marker; //für debug
			if ((count _marker >0)&&((count _marker)!=(count DORB_GPTR_MARKERNAME))) then {sleep REFRESHTIME;["restart"] spawn SELF; diag_log text "Anzahl Marker != Anzahl Markernamen"; };
			
			/// Updates the position
			{
				_x = ["update",_x] call SELF;
			}forEach _marker;
			
			If ( ( player == leader group player )&&( ( player getVariable ["BIS_dynamicGroups_groupId", ""])!= "" ) ) then { ["settext"] call SELF};
			
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
			_KI = (isPlayer(leader _x ));
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
		_group = [_this, 1, grpNull,[grpNull]] call BIS_fnc_param;
		if ((_group == grpNull)||(!alive (leader _group))) exitWith {"delete"};
		_mark = createMarkerLocal [format["%1",_group],getPos (leader _group)];
		_mark setMarkerShapeLocal "ICON";
		_mark setMarkerColorLocal DORB_GPTR_COLOR;
		_mark setMarkerTypeLocal (["symbol",leader _group] call SELF);
		_mark setMarkerTextLocal (_group getVariable ["DORB_GPTR_NAME",(groupID _group)]);
		format["%1",_group]
	};
	case "symbol" : {
		/*
			returns the vehicle-symbol of the leader. Civilian count as bluefor
		*/
		private ["_symbol","_leader"];
		_leader = [_this, 1, objNull,[objNull]] call BIS_fnc_param;
		if (!alive _leader) exitWith {"unknown"};
		_post = switch (true) do {
			case ((vehicle _leader isKindOf "MBT_01_arty_base_F")or(vehicle _leader isKindOf "MBT_01_mlrs_base_F")) : {"art"};
			case ((vehicle _leader isKindOf "Wheeled_Apc_F")or(vehicle _leader isKindOf "APC_Tracked_02_base_F")or(vehicle _leader isKindOf "APC_Tracked_03_base_F")) : {"mech_inf"};
			case (vehicle _leader isKindOf "Tank") : {"armor"};
			case (vehicle _leader isKindOf "Car") : {"motor_inf";};
			case ((vehicle _leader isKindOf "Ship")or(vehicle _leader isKindOf "Submarine")) : {"naval"};
			case (vehicle _leader isKindOf "Plane") : {"plane"};
			case (vehicle _leader isKindOf "Air") : {"air"};
			case (vehicle _leader isKindOf "Man") : {"inf"};
			default {"unknown"};
		};
		format["%1%2",DORB_GPTR_PREFIX,_post]
	};
	case "update" : {
		/*
			updates the position of the unit
		*/
		private ["_gruppe","_marker","_return"];
		_gruppe = _this select 1;
		_marker = format ["%1",_gruppe];
		If (count (units _gruppe)<1) then {
			//deleteMarkerLocal _marker;
			//-1;
			grpNull;
		}else{
			_gruppe;
			if (alive(leader _gruppe)) then {
				_marker setMarkerPosLocal (getPos(leader _gruppe));
				_marker setMarkerTextLocal (_gruppe getVariable ["DORB_GPTR_NAME",(groupID _gruppe)]);
				_marker setMarkerTypeLocal (["symbol",leader _gruppe] call SELF);
			};
		};
	};
	case "settext"	 : {
		/*
			transfers the BIS-Groupname to group-variable 
		*/
		private ["_id","_name","_arr_pos"];	
		_arr_pos = [BIS_dynamicGroups_list,(group player)]call BIS_fnc_findNestedElement; 
		_arr_pos set [(count _arr_pos) - 1, 1];
		_name = [BIS_dynamicGroups_list,_arr_pos] call BIS_fnc_returnNestedElement;
		if (_name != (group player) getVariable ["DORB_GPTR_NAME", ""]) then {
			(group player) setVariable ["DORB_GPTR_NAME",_name,true];
		};
	};
	case "terminate"	 : {
		/*
			terminates the grouptracker
		*/
		DORB_GPTR_AKTIV=false;
		{
			deleteMarkerLocal _x;
		}forEach DORB_GPTR_MARKERNAME;
		DORB_GPTR_MARKERNAME=[];
	};
	case "restart"	 : {
		/*
			restarts the grouptracker
		*/
		if(isNil "DORB_GPTR_AKTIV")exitWith{};
		DORB_GPTR_AKTIV=false;
		["terminate"] call SELF;
		sleep 10;
		["init"] spawn SELF;
	};
};