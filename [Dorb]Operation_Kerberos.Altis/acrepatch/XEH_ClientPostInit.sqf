/*
 * Author: Dorbedo
 *
 */
 #include "script_component.hpp"
If (hasInterface) then {
    /*
    /// before the player opens the arsenal, we change the ACRE radios to the default ones
    [
        QGVARMAIN(arsenalOpened),
        {[FUNC(ArsenalRemoveRadio),_this] call CBA_fnc_directCall;}
    ] call CBA_fnc_addEventHandler;
    /// after each save
    [
        QGVARMAIN(arsenalOpened),
        {
            disableSerialization;
            private _display = (uinamespace getVariable "RscDisplayGarage");
		    (_display displayctrl 44147) ctrladdeventhandler ["buttonclick",QUOTE([ARR_2(FUNC(ArsenalRemoveRadio),_this)] call CBA_fnc_directCall;)];
        }
    ] call CBA_fnc_addEventHandler;
    */
    If (isServer) then { // self hosted game
        GVAR(isDataSyncronized) = true;
    }else{
        GVAR(isDataSyncronized) = false;
        If (isNil "ACREjipc") then {ACREjipc = "";}; // Should already be finished, but just in case
        [
            {!(ACREjipc isEqualType "String")},
            {GVAR(isDataSyncronized) = true;},
            []
        ] call CBA_fnc_waitUntilAndExecute

    };
    //[] spawn FUNC(ArsenalRemoveRadio);
    /*
    GVAR(isGearSyncing) = false;
    [
        QGVAR(syncGear),
        {
            If (isNil QGVAR(isGearSyncing)) then {
                GVAR(isGearSyncing) = false;
            };
            CHECK(GVAR(isGearSyncing))
            GVAR(isGearSyncing) = true;
            _this params ["_unit"];
            ([_unit] call EFUNC(player,getLoadout)) params ["_loadout","_weaponsarray"];
            If ((local _unit)&&(hasInterface)) then {
                ERROR_WITH_TITLE("Asnycron Gear","Your Gear got asnycron. Trying to syncronize your gear.");
            };
            removeAllWeapons _unit;
            removeAllItemsWithMagazines _unit;
            removeAllAssignedItems _unit;
            removeHeadgear _unit;
            removeGoggles _unit;
            removeAllContainers _unit;
            [

                {
                    _this call EFUNC(player,setLoadout);
                    GVAR(isGearSyncing) = false;
                },
                [_unit,_loadout,_weaponsarray],
                5
            ] call CBA_fnc_waitAndExecute;
        }
    ] call CBA_fnc_addEventHandler;
    */
};
