#define CBA_OFF
#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
    class MAIN_ADDON {
        init = "call compile preProcessFileLineNumbers 'XEH_PreInit.sqf'";
    };
};

class Extended_PostInit_EventHandlers {
    class Dorb_common_client {
        Clientinit = "call compile preProcessFileLineNumbers 'common\XEH_clientpostinit.sqf'";
    };
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
    class Dorb_player_Server {
        Serverinit = "call compile preProcessFileLineNumbers 'player\XEH_serverpostinit.sqf'";
    };
    class Dorb_player_Client {
        Clientinit = "call compile preProcessFileLineNumbers 'player\XEH_Clientpostinit.sqf'";
    };
    class Dorb_ai_post {
		Serverinit = "call compile preProcessFileLineNumbers 'ai\XEH_postinit.sqf'";
	};
    class dorb_acrepatch {
        init = "call compile preProcessFileLineNumbers 'acrepatch\XEH_postinit.sqf'";
    };
    class dorb_acrepatch_server {
        Serverinit = "call compile preProcessFileLineNumbers 'acrepatch\XEH_Serverpostinit.sqf'";
    };
    class dorb_modasrai {
        init = "call compile preProcessFileLineNumbers 'modasrai\XEH_postinit.sqf'";
    };
    class dorb_database {
        Serverinit = "[] spawn compile preProcessFileLineNumbers 'database\EH_postinit.sqf'";
    };
};

class Extended_Init_Eventhandlers {
    #include "spawn\XEH_init.hpp"
	#include "logistics\XEH_init.hpp"
};

class Extended_InitPost_Eventhandlers {
    #include "headless\XEH_initPost.hpp"
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

class Extended_killed_Eventhandlers {
    #include "player\XEH_killed.hpp"
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
