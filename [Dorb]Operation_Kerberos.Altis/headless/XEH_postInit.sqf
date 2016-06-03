#include "script_component.hpp"
CHECK(!GVARMAIN(HC_enabled))
CHECK(hasInterface&&(!isServer))

If (isServer) then {
    [GVAR(joined),{_this call FUNC(connect);}] call CBA_fnc_addEventHandler;
    addMissionEventHandler ["HandleDisconnect",{_this call EFUNC(disconnect)}];
}else{
    [QGVAR(joined),[player]] call CBA_fnc_ServerEvent;
};
