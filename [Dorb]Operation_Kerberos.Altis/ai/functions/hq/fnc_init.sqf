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

GVAR(hq_aktive) = true;
GVAR(hq_definitions) = [2000,125];
GVAR(hq_definitions) pushBack ((GVAR(hq_definitions) select 0)/(GVAR(hq_definitions) select 1));

GVAR(hq_dangerzones) = [(GVAR(hq_definitions) select 2)] call EFUNC(common,matrix_create);

[] call FUNC(HQ_reset);

[
	{
		_this call FUNC(hq_handle);
	},
	INTERVALL_HQ,
	[]
] call CBA_fnc_addPerFrameHandler;

[
	{
		_this call FUNC(hq_dangerzone_buffer);
	},
	INTERVALL_BUFFER,
	[]
] call CBA_fnc_addPerFrameHandler;

[
	{
		_this call FUNC(hq_check_radars);
	},
	INTERVALL_RADARS,
	[]
] call CBA_fnc_addPerFrameHandler;
