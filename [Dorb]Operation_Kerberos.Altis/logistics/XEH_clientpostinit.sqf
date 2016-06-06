/*
    Author: Dorbedo
    
    Description:
        initialization for logistics
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
CHECK(isHeadless)
CHECK(!isClass(missionconfigFile >> "logistics"))

ISNILS(EGVAR(player,respawn_fnc),[]);
EGVAR(player,respawn_fnc) pushBack QUOTE(player setVariable [ARR_2('GVAR(isloading)',false)];);

private _cfgLog = missionconfigFile >> "logistics" >> "vehicles";
private _mainAction = [
    QGVAR(action_main),
    localize LSTRING(ACTION_MAIN),
    "",
    {true},
    {true}] call ace_interact_menu_fnc_createAction;
private _loadAction = [
    QGVAR(action_load),
    localize LSTRING(ACTION_LOAD),
    "",
    {true},
    {[_target] call FUNC(canload);},
    {[_target] call FUNC(addLoadActions);}
    ] call ace_interact_menu_fnc_createAction;
private _unloadAction = [QGVAR(action_unload), localize LSTRING(ACTION_UNLOAD), "", {[_target] spawn FUNC(dounload);}, {  [_target] call FUNC(canUnload);  }] call ace_interact_menu_fnc_createAction;
private _infoAction = [QGVAR(action_info), localize LSTRING(ACTION_DISP_CARGO),"",{[_target] spawn FUNC(disp_cargo);},{true}] call ace_interact_menu_fnc_createAction;
private _paraAction = [QGVAR(action_paradrop), localize LSTRING(ACTION_PARADROP), "", {[_target,true] spawn FUNC(dounload);}, {[_target] call FUNC(candrop);}] call ace_interact_menu_fnc_createAction;
private _extendAction = [QGVAR(action_extend), localize LSTRING(ACTION_EXTEND), "", {[_target,true] spawn FUNC(changeCargo);}, {[_target,true] call FUNC(canChangeCargo);}] call ace_interact_menu_fnc_createAction;
private _reduceAction = [QGVAR(action_reduce), localize LSTRING(ACTION_REDUCE), "", {[_target,false] spawn FUNC(changeCargo);}, {[_target,false] call FUNC(canChangeCargo);}] call ace_interact_menu_fnc_createAction;

[localize ELSTRING(main,name), QGVAR(keybind_g), [localize LSTRING(ACTION_PARADROP), localize LSTRING(ACTION_PARADROP)], { if ([vehicle player] call FUNC(candrop)) then { [vehicle player,true] spawn FUNC(dounload)}; }, {true}, [0x22, [false, false, false]], false] call CBA_fnc_addKeybind;
/// Vehicles
for "_i" from 0 to ((count _cfgLog)-1) do {
    private _vehicle = configname(_cfgLog select _i);
    If (isClass(configFile >> "cfgvehicles" >> _vehicle)) then {
        private _canLoad = ( getnumber(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "max_length") ) > 0;
        private _canPara = ((( getnumber(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "max_length") ) > 0)&&(_vehicle isKindOf "Air"));
        private _canCargo = (isClass(missionconfigFile >> "logistics" >> "vehicles" >> _vehicle >> "cargo"));
        If (_canLoad) then {
            [_vehicle, 0, ["ACE_MainActions"], _mainAction] call ace_interact_menu_fnc_addActionToClass;
            [_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _loadAction] call ace_interact_menu_fnc_addActionToClass;
            [_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _unloadAction] call ace_interact_menu_fnc_addActionToClass;
            [_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _infoAction] call ace_interact_menu_fnc_addActionToClass;
            If (_canCargo) then {
                [_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _extendAction] call ace_interact_menu_fnc_addActionToClass;
                [_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _reduceAction] call ace_interact_menu_fnc_addActionToClass;
            };
            [_vehicle, 1, ["ACE_SelfActions"], _mainAction] call ace_interact_menu_fnc_addActionToClass;
            [_vehicle, 1, ["ACE_SelfActions",QGVAR(action_main)], _infoAction] call ace_interact_menu_fnc_addActionToClass;
            If (_canPara) then {
                [_vehicle, 1, ["ACE_SelfActions",QGVAR(action_main)], _paraAction] call ace_interact_menu_fnc_addActionToClass;
            };
        };
    };
};
/// Cargo
private _cfgVeh = configFile >> "CfgVehicles";
_loadAction = [
    QGVAR(action_load),
    localize LSTRING(ACTION_LOAD),
    "",
    {true},
    {[_target] call FUNC(canbeload);},
    {[_target] call FUNC(addbeLoadedActions);}
    ] call ace_interact_menu_fnc_createAction;

for "_i" from 0 to ((count _cfgVeh)-1) do {
    private _vehicle = configname(_cfgVeh select _i);
    If (!([_vehicle] call FUNC(getCargoCfg) isEqualTo "")) then {
        private _test1 = [_vehicle, 0, ["ACE_MainActions"], _mainAction] call ace_interact_menu_fnc_addActionToClass;
        private _test2 = [_vehicle, 0, ["ACE_MainActions",QGVAR(action_main)], _loadAction] call ace_interact_menu_fnc_addActionToClass;
		LOG_3(,_vehicle,_test1,_test2);
    };
    
};