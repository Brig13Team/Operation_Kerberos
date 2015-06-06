#include "script_component.hpp"

_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_params = _this select 3;
_althalo = [_params, 0,500] call BIS_fnc_Param;
_altchute = [_params, 1,100] call BIS_fnc_Param;
_players = [];

_players = call CBA_fnc_players;

if ((count _players)>5) exitWith {["STR_DORB_HALO","STR_DORB_HALO_DISABLED"] call FM(disp_message);};


if (not alive _host) exitwith {
	["STR_DORB_HALO","STR_DORB_HALO_DISABLED"] call FM(disp_message);
	_host removeaction _id;
};

if (vehicle _caller == _caller) then {

	private ["_pos"];
	
	["STR_DORB_HALO","STR_DORB_HALO_KlICK"] call FM(disp_message);
	

	openMap true;

	mapclick = false;

	onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";

	waituntil {mapclick or !(visiblemap)};
	
	if !(visibleMap) exitwith {
		["STR_DORB_HALO","STR_DORB_HALO_ABORT"] call FM(disp_message);
	};
	_pos = clickpos;

	_caller setpos [_pos select 0, _pos select 1, _althalo];
	_caller spawn bis_fnc_halo;
	/*
	[_caller]spawn{
		_caller = _this select 0;
		_packclass = typeOf (unitBackpack _caller);
		_helmet = headgear _caller;
		_gear=[];
		_gear = [_caller] call dorb_fnc_halo_get_loadout;
		if (_helmet != "H_CrewHelmetHeli_B") then {
			_caller addHeadGear "H_CrewHelmetHeli_B";
		};
		removeBackpack _caller; //remove the backpack
		_caller addBackpack "b_parachute"; //add the parachute
		_packHolder = createVehicle ["groundWeaponHolder", [0,0,0], [], 0, "can_collide"];
		_packHolder addBackpackCargoGlobal [_packclass, 1];

		waitUntil {animationState _caller == "HaloFreeFall_non"};
		_packHolder attachTo [_caller,[-0.12,-0.02,-0.74],"pelvis"]; 
		_packHolder setVectorDirAndUp [[0,-1,-0.05],[0,0,-1]];

		waitUntil {animationState _caller == "para_pilot"};
		_packHolder attachTo [vehicle _caller,[-0.07,0.67,-0.13],"pelvis"]; 
		_packHolder setVectorDirAndUp [[0,-0.2,-1],[0,1,0]];

		waitUntil {isTouchingGround _caller || (getPos _caller select 2) < 1};
		detach _packHolder;
		deleteVehicle _packHolder; //delete the backpack in front
		
		[_caller,_gear] call dorb_fnc_halo_set_loadout;
	};
	*/
	

};

if (getpos _caller select 2 > (_altchute + 100)) then {
sleep 1;

[_caller] spawn bis_fnc_halo;

openMap false;

_bis_fnc_halo_action = _caller addaction [format["<t size='1.5' shadow='2' color='#ff0000'>%1</t> <img size='3' color='#ff0000' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>",localize "STR_DORB_HALO_OPEN"],"A3\functions_f\misc\fn_HALO.sqf",[],1,false,true,"Eject"];

sleep 5;

//_caller groupchat "Have a nice trip";// and dont forget to open your chute!";

//auto open before impact
waituntil {(position _caller select 2) <= _altchute};

_caller removeaction _bis_fnc_halo_action;

if !((vehicle _caller) iskindof "ParachuteBase") then {

	[_caller] spawn bis_fnc_halo;

};

waituntil {(position _caller select 2) < 1};

_caller action ["Eject", vehicle _caller];
_caller switchmove "adthppnemstpsraswrfldnon_1";
_caller setvelocity [0,0,0];

};
