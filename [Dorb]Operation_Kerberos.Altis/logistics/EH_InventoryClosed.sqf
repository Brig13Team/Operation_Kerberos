/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the init Eventhandler
 *
 */
#include "script_component.hpp"

["ReammoBox_F", "InventoryClosed", {
    [QGVAR(setContainerWeight),(_this select 1)] call CBA_fnc_localEvent;
},true,[],true] call CBA_fnc_addClassEventHandler;
