#include "script_component.hpp"
SCRIPT(halo);
params["_host","_caller","_id","_params"];
_params params[["_althalo",500,[0]],["_altchute",100,[0]]];

if ((count allPlayers)>7) exitWith {[LSTRING(HALO),LSTRING(HALO_DISABLED)] call EFUNC(interface,disp_message);};

if !(alive _host) exitwith {
	[LSTRING(HALO),LSTRING(HALO_DISABLED)] call EFUNC(interface,disp_message);
	_host removeaction _id;
};

if (vehicle _caller == _caller) then {
	private ["_pos"];
	[LSTRING(HALO),LSTRING(HALO_KLICK)] call EFUNC(interface,disp_message);
	openMap true;
	mapclick = false;
	onMapSingleClick "clickpos = _pos; mapclick = true; onMapSingleClick """";true;";
	waituntil {mapclick or !(visiblemap)};
	if !(visibleMap) exitwith {
		[LSTRING(HALO),LSTRING(HALO_ABORT)] call EFUNC(interface,disp_message);
	};
	_pos = clickpos;
	_caller setpos [_pos select 0, _pos select 1, _althalo];
	_caller spawn bis_fnc_halo;
};

if (getpos _caller select 2 > (_altchute + 100)) then {
	sleep 1;
	private "_bis_fnc_halo_action";
	[_caller] spawn bis_fnc_halo;
	openMap false;
	_bis_fnc_halo_action = _caller addaction [format["<t size='1.5' shadow='2' color='#ff0000'>%1</t> <img size='3' color='#ff0000' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>",localize LSTRING(HALO_OPEN)],"A3\functions_f\misc\fn_HALO.sqf",[],1,false,true,"Eject"];
	uisleep 5;
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
