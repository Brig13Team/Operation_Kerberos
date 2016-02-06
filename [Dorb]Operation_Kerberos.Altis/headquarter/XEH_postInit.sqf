#include "script_component.hpp"

If (hasInterface) exitWith {};

GVAR(WP_deaktivated) = [];
GVAR(WP_hashes) = [[],0] call CBA_fnc_hashCreate;



///// FDC
#define INTERVALL_FDC 120
#define INTERVALL_SEARCH 400


SETMVAR(GVAR(fdc_mortars),[]);
SETMVAR(GVAR(fdc_artilleries),[]);
SETMVAR(GVAR(fdc_rocket),[]);
SETMVAR(GVAR(fdc_firemissions),[]);
SETMVAR(GVAR(fdc_handle),-1);
SETMVAR(GVAR(fdc_handle_search),-1);

GVAR(fdc_handle) = [
    {
        _this call FUNC(fdc_handle);
    },
    INTERVALL_FDC,
    []
    ] call CBA_fnc_addPerFrameHandler;


GVAR(fdc_handle_search) = [
    {
        _this call FUNC(fdc_defend_artypos);
    },
    INTERVALL_SEARCH,
    []
    ] call CBA_fnc_addPerFrameHandler;