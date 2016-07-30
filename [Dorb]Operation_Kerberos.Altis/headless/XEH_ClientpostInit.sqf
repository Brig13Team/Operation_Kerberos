/*
    Author: Dorbedo
    
    Description:
        registers the HC

*/
#include "script_component.hpp"
CHECK((!GVARMAIN(HC_enabled))||(hasInterface))

[QGVAR(HCjoined),[player]] call CBA_fnc_serverEvent;
