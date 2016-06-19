#include "script_component.hpp"

CHECK(!isServer)

GVAR(fdc_mortars) = [];
GVAR(fdc_artilleries) = [];
GVAR(fdc_rocket) = [];
GVAR(fdc_firemissions) = [];


[
	{
		_this call FUNC(fdc_handle);
	},
	INTERVALL_FDC,
	[]
] call CBA_fnc_addPerFrameHandler;

[
	{
		_this call FUNC(fdc_defend_artypos);
	},
	INTERVALL_SEARCH,
	[]
] call CBA_fnc_addPerFrameHandler;

[
    QEGVAR(headquarter,register_artillery),
    {
        _this call FUNC(fdc_register);
    }
] call CBA_fnc_addEventHandler;

