#include "script_component.hpp"
CHECK(!GVARMAIN(HC_enabled))
CHECK(hasInterface&&(!isServer))

If (isServer) then {
    [GVAR(joined),{_this call FUNC(connect);}] call EFUNC(events,addEventHandler);
    addMissionEventHandler ["HandleDisconnect",{_this call EFUNC(disconnect)}]
}else{
    [GVAR(joined),[player]] call EFUNC(events,serverEvent);
};
