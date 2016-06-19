#define CBA_OFF
#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
    class MAIN_ADDON {
        init = "call compile preProcessFileLineNumbers 'XEH_PreInit.sqf'";
    };
};

class Extended_PostInit_EventHandlers {
	class Dorb_Logistics_client {
		Clientinit = "call compile preProcessFileLineNumbers 'logistics\XEH_clientpostinit.sqf'";
	};
	class Dorb_Logistics {
		init = "call compile preProcessFileLineNumbers 'logistics\XEH_postinit.sqf'";
	};
    class Dorb_headless_client {
        Clientinit = "call compile preProcessFileLineNumbers 'headless\XEH_clientpostinit.sqf'";
    };
    class Dorb_headless_Server {
        Serverinit = "call compile preProcessFileLineNumbers 'headless\XEH_serverpostinit.sqf'";
    };
    class Dorb_player_post {
        init = "call compile preProcessFileLineNumbers 'player\XEH_postinit.sqf'";
    };
    class Dorb_ai_post {
		Serverinit = "call compile preProcessFileLineNumbers 'ai\XEH_postinit.sqf'";
	};
};

class Extended_Init_Eventhandlers {
    #include "spawn\XEH_init.hpp"
	#include "logistics\XEH_init.hpp"
};

class Extended_inventoryClosed_EventHandlers {
    #include "logistics\XEH_InventoryClosed.hpp"
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
	#include "bwpatch\XEH_hitPart.hpp"
};

class Extended_GetIn_Eventhandlers {
    #include "player\XEH_getIn.hpp"
};

class Extended_SeatSwitched_Eventhandlers {
	#include "player\XEH_seatSwitched.hpp"
};