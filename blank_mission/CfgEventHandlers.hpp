class Extended_PreInit_EventHandlers {
    class ADDON {
        init = "call compile preProcessFileLineNumbers 'XEH_PreInit.sqf'";
    };
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


