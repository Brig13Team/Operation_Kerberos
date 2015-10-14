#define CBA_OFF
#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
	INCLUDE_PREINIT(main);
	INCLUDE_PREINIT(common);
	INCLUDE_PREINIT(interface);
	INCLUDE_PREINIT(player);
	INCLUDE_PREINIT(logistics);
	INCLUDE_PREINIT(mission);
	INCLUDE_PREINIT(ai);
	INCLUDE_PREINIT(spawn);
};

class Extended_PostInit_EventHandlers {
    INCLUDE_POSTINIT(common);
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

class Extended_Killed_EventHandlers {
    #include "ai\XEH_killed.hpp"
};

class Extended_SeatSwitched_EventHandlers {
    #include "player\XEH_SeatSwitched.hpp"
};
