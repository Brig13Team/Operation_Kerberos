/*
 * Author: Dorbedo
 *
 */
 #include "script_component.hpp"
If (!hasInterface) then {
/*
    [
        QGVARMAIN(arsenalClosed),
        {[FUNC(checkRadio),_this] call CBA_fnc_directCall;}
    ] call CBA_fnc_addEventHandler;
*/
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
		    (_display displayctrl 44146) ctrladdeventhandler ["buttonclick",QUOTE([ARR_2(FUNC(ArsenalRemoveRadio),_this)] call CBA_fnc_directCall;)];
        }
    ] call CBA_fnc_addEventHandler;
};
