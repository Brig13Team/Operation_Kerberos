/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
	
*/
#include "script_component.hpp"
SCRIPT(init);

params [["_mode","",[""]],["_args",[],[[]]]];

switch (_mode) do { 
	case "start":
	{
		private ["_commander","_adrones","_rdrones","_avail_adrones","_avail_rdrones","_handle","_side"];
		_commander = _args param [0,objNull,[objNull]];
		_adrones = getArray (missionConfigFile >> "unitlists" >> "east" >> "east_basic" >> "attack_uavs");
		_rdrones = getArray (missionConfigFile >> "unitlists" >> "east" >> "east_basic" >> "recon_uavs");
		_avail_adrones = [];
		_avail_rdrones = [];

		if (playersNumber EGVAR(main,playerside) <=  5) then { _avail_rdrones pushBack (_rdrones SELRND); };
		if (playersNumber EGVAR(main,playerside) <= 15) then { _avail_rdrones pushBack (_rdrones SELRND); };
		if (playersNumber EGVAR(main,playerside) <= 25) then { _avail_rdrones pushBack (_rdrones SELRND); };
		if (playersNumber EGVAR(main,playerside) <= 35) then { _avail_rdrones pushBack (_rdrones SELRND); };

		if (playersNumber EGVAR(main,playerside) <= 10) then { _avail_adrones pushBack (_adrones SELRND); };
		if (playersNumber EGVAR(main,playerside) <= 20) then { _avail_adrones pushBack (_adrones SELRND); };
		if (playersNumber EGVAR(main,playerside) <= 30) then { _avail_adrones pushBack (_adrones SELRND); };
		if (playersNumber EGVAR(main,playerside) <= 40) then { _avail_adrones pushBack (_adrones SELRND); };
		
		SETVAR(missionNamespace,GVAR(requestedAirstrikes),[]);
		SETVAR(missionNamespace,GVAR(requestedReconnaissances),[]);
		SETVAR(missionNamespace,GVAR(availableReconDrones),_avail_rdrones);
		SETVAR(missionNamespace,GVAR(availableAttackDrones),_avail_adrones);

		_handle = [{
			private ["_requests","_leftrequests","_drone"];

			_requests = GETVAR(missionNamespace,GVAR(requestedAirstrikes),[]);
			_leftrequests = [];
			for "_i" from 0 to (count _requests - 1) do {
				if ((_x select 2) <= (serverTime)) then {
					if (count (GETVAR(missionNamespace,GVAR(availableAttackDrones),[])) > 0) then {
						[_requests select 0 select 0] spawn FUNC(drones_doAirstrike);
					} else {
						_leftrequests pushBack _requests;
					};
				};
			};
			SETVAR(missionNamespace,GVAR(requestedAirstrikes),_leftrequests);

			_rdrones = GETVAR(missionNamespace,GVAR(availableReconDrones),[]);
			if (count _rdrones > 0) then {

			};
		},10,[]] call CBA_fnc_addPerFrameHandler;

		LOG(FORMAT_1("handle = %1",_handle));
	};
	case "stop":
	{
		private ["_handle"];
		_handle = GETVAR(missionNamespace,GVAR(handle),-1);
		[_handle] call CBA_fnc_removePerFrameHandler;

		SETVAR(missionNamespace,GVAR(requestedAirstrikes),[]);
		SETVAR(missionNamespace,GVAR(requestedReconnaissances),[]);
		SETVAR(missionNamespace,GVAR(availableReconDrones),[]);
		SETVAR(missionNamespace,GVAR(availableAttackDrones),[]);
	};
};
