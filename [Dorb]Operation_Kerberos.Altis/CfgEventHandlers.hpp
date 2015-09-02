#define CBA_OFF
	#include "script_component.hpp"
#undef CBA_OFF
class Extended_PreInit_EventHandlers {
    class MAIN_ADDON {
        init = "call compile preProcessFileLineNumbers 'XEH_PreInit.sqf'";
    };
};

class Extended_Init_Eventhandlers {
    #include "spawn\XEH_init.hpp"
};

class Extended_Respawn_EventHandlers {
    #include "player\XEH_respawn.hpp"
};

class Extended_fired_Eventhandlers {
    #include "player\XEH_fired.hpp"
};

class Extended_Hit_EventHandlers {
    #include "player\XEH_hit.hpp"
};

class Extended_HitPart_EventHandlers {
    #include "player\XEH_hitPart.hpp"
};

class Extended_GetIn_Eventhandlers {
    #include "player\XEH_getIn.hpp"
};