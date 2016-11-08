/*
 * Author: Dorbedo
 *
 */
 #include "script_component.hpp"
If (hasInterface) then {

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
    [] spawn FUNC(ArsenalRemoveRadio);
};
