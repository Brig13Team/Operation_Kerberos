#define CBA_OFF
#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
    INCLUDE_PREINIT(main);
	INCLUDE_PREINIT(comp_example);
	INCLUDE_PREINIT(comp_somefunctions);
};

class Extended_Respawn_EventHandlers {
	#include "comp_example\XEH_respawn.hpp"
};

class Extended_fired_Eventhandlers {
	#include "comp_example\XEH_fired.hpp"
};

class Extended_Hit_EventHandlers {
	#include "comp_example\XEH_hit.hpp"
};


