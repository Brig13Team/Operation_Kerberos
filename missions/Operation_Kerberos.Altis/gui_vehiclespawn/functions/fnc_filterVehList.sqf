/**
 * Author: Dorbedo
 * filters the VehicleList
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _curVehList =+ GVAR(curVehList);
If ((_curVehList isEqualTo [])||{((GVAR(filterName) isEqualTo "")&&(GVAR(filterMod) isEqualTo ""))}) exitWith {
    GVAR(curVehListFiltered) = nil;
};

// this should be the fastest way, although it looks awful
switch (true) do {
    case (GVAR(filterMod) isEqualTo "") : {
        private _lenght = count GVAR(filterName);
        GVAR(curVehListFiltered) = GVAR(curVehList) select {
            ((toLower (_x select 3)) find GVAR(filterName))>=0
        };
    };
    case (GVAR(filterName) isEqualTo "") : {
        private _lenght = count GVAR(filterMod);
        GVAR(curVehListFiltered) = GVAR(curVehList) select {
            ((toLower (_x select 1)) find GVAR(filterMod))>=0
        };
    };
    default {
        private _lenghtName = count GVAR(filterName);
        private _lenghtMod = count GVAR(filterMod);
        GVAR(curVehListFiltered) = GVAR(curVehList) select {
            (((toLower (_x select 3)) find GVAR(filterName))>=0)&&
            {((toLower (_x select 1)) find GVAR(filterMod))>=0}
        };
    };
};
