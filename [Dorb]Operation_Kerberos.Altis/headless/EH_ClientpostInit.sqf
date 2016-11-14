/*
    Author: Dorbedo

    Description:
        registers the HC

*/
#include "script_component.hpp"
CHECK(isServer)
CHECK((!GVAR(HC_enabled))||(hasInterface))

[QGVAR(HCjoined),[player]] call CBA_fnc_serverEvent;
