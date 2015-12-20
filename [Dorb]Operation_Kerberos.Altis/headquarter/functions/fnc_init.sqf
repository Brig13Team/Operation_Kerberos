/*
    Author: Dorbedo
    
    Description:
        initialiuzes AI HQ
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
SCRIPT(init);
#define INTERVALL_HQ 30
#define INTERVALL_RADARS 20
#define INTERVALL_BUFFER 2

GVAR(aktive) = false;
GVAR(definitions) = [2000,125];
GVAR(definitions) pushBack ((GVAR(definitions) select 0)/(GVAR(definitions) select 1));

GVAR(dangerzones) = [(GVAR(definitions) select 2)] call EFUNC(common,matrix_create);

[] call FUNC(mission_end);

[
    {
        _this call FUNC(handle);
    },
    INTERVALL_HQ,
    []
] call CBA_fnc_addPerFrameHandler;

[
    {
        _this call FUNC(dangerzone_buffer);
    },
    INTERVALL_BUFFER,
    []
] call CBA_fnc_addPerFrameHandler;

[
    {
        _this call FUNC(check_radars);
    },
    INTERVALL_RADARS,
    []
] call CBA_fnc_addPerFrameHandler;
