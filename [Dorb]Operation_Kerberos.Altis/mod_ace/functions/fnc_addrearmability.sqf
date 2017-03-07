/*
    Author: Dorbedo
    
    Description:
        adds ACE rearm truck ability to a unit/class
        
    unit-init:
        [this] execVM "fnc_addACErearmability.sqf"
        /// adds supply to this unit

    initplayer.sqf:
        ["rhsusf_m113_usarmy_supply"] execVM "fnc_addACErearmability.sqf"
        /// adds supply to this class
        
*/
_this params [["_unit",objNull,["",objNull]]];
If (isNull _unit) exitWith {false;};
private _actionTake = [
    "ace_rearm_takeAmmo",
    localize "STR_ace_rearm_takeAmmo",
    "z\ace\addons\rearm\ui\icon_rearm_interact.paa",
    {},
    {([_target,ACE_player] call ace_rearm_fnc_canTakeAmmo)&&([ACE_player,objNull,["isNotInside"]]call ace_common_fnc_canInteractWith)},
    {[_target,ACE_player] call ace_rearm_fnc_addRearmActions},
    [],
    [0,0,0],
    7
    ] call ace_interact_menu_fnc_createAction;
private _actionStore = [
    "ace_rearm_StoreAmmo",
    localize "STR_ace_rearm_StoreAmmo",
    "z\ace\addons\rearm\ui\icon_rearm_interact.paa",
    {[_target,ACE_player] call ace_rearm_fnc_StoreAmmo;},
    {([_target,ACE_player] call ace_rearm_fnc_canStoreAmmo)&&([ACE_player,objNull,["isNotInside"]]call ace_common_fnc_canInteractWith)},
    {},
    [],
    [0,0,0],
    7
    ] call ace_interact_menu_fnc_createAction;
If (_unit isEqualType "String") then {
    [_unit, 0, ["ACE_MainActions"], _actionTake] call ace_interact_menu_fnc_addActionToClass;
    [_unit, 0, ["ACE_MainActions"], _actionStore] call ace_interact_menu_fnc_addActionToClass;
}else{
    [_unit, 0, ["ACE_MainActions"], _actionTake] call ace_interact_menu_fnc_addActionToObject;
    [_unit, 0, ["ACE_MainActions"], _actionStore] call ace_interact_menu_fnc_addActionToObject;
};
true;