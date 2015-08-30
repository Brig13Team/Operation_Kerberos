#define CBA_OFF
#include "script_component.hpp"
class Extended_PreInit_EventHandlers {
    class MAIN_ADDON {
        init = "call compile preProcessFileLineNumbers 'XEH_PreInit.sqf'";
    };
};

class Extended_Init_Eventhandlers {
    #include "spawn\XEH_getIn.hpp"
};

class Extended_Respawn_EventHandlers {
    #include "players\XEH_respawn.hpp"
};

class Extended_fired_Eventhandlers {
    #include "players\XEH_fired.hpp"
};

class Extended_Hit_EventHandlers {
    #include "players\XEH_hit.hpp"
};

class Extended_GetIn_Eventhandlers {
    #include "players\XEH_getIn.hpp"
};
#undef CBA_OFF