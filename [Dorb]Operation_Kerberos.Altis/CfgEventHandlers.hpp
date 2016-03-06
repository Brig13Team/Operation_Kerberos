/*

    Author: Dorbedo, iJesuz

*/

#define CBA_OFF
#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
    INCLUDE_PREINIT(main);
    INCLUDE_PREINIT(events);
    INCLUDE_PREINIT(common);
    INCLUDE_PREINIT(headless);
    INCLUDE_PREINIT(interface);
    INCLUDE_PREINIT(player);
    INCLUDE_PREINIT(logistics);
    INCLUDE_PREINIT(mission);
    INCLUDE_PREINIT(headquarter);
    INCLUDE_PREINIT(spawn);
    INCLUDE_PREINIT(tfar_addon);
};

class Extended_PostInit_EventHandlers {
    INCLUDE_POSTINIT(main);
    INCLUDE_SERVERPOSTINIT(interface);
    INCLUDE_SERVERPOSTINIT(player);
    INCLUDE_SERVERPOSTINIT(mission);
    INCLUDE_CLIENTPOSTINIT(logistics);
    INCLUDE_CLIENTPOSTINIT(interface);
    INCLUDE_CLIENTPOSTINIT(player);
    INCLUDE_CLIENTPOSTINIT(mission);
    INCLUDE_POSTINIT(logistics);
    INCLUDE_POSTINIT(headquarter);
    INCLUDE_POSTINIT(common);
    INCLUDE_POSTINIT(headless);
    INCLUDE_POSTINIT(tfar_addon);
};
class Extended_Init_Eventhandlers {
    #include "spawn\XEH_init.hpp"
    #include "logistics\XEH_init.hpp"
};
class Extended_InitPost_EventHandlers {
    #include "headless\XEH_initPost.hpp"
};
//class Extended_animChanged_EventHandlers {};
//class Extended_animDone_EventHandlers {};
//class Extended_animStateChanged_EventHandlers {};
//class Extended_containerClosed_EventHandlers {};
//class Extended_containerOpened_EventHandlers {};
//class Extended_controlsShifted_EventHandlers {};
//class Extended_dammaged_EventHandlers {};
//class Extended_engine_EventHandlers {};
//class Extended_epeContact_EventHandlers {};
//class Extended_epeContactEnd_EventHandlers {};
//class Extended_epeContactStart_EventHandlers {};
//class Extended_explosion_EventHandlers {};
//class Extended_Fired_Eventhandlers {};
class Extended_FiredBIS_EventHandlers {
    #include "player\XEH_firedBIS.hpp"
};
//class Extended_firedNear_EventHandlers {};
//class Extended_fuel_EventHandlers {};
//class Extended_gear_EventHandlers {};
class Extended_getIn_EventHandlers {
    #include "player\XEH_getIn.hpp"
};
//class Extended_getOut_EventHandlers {};
//class Extended_handleHeal_EventHandlers {};
class Extended_hit_EventHandlers {
    #include "player\XEH_hit.hpp"
};
class Extended_hitPart_EventHandlers {
    #include "player\XEH_hitPart.hpp"
    #include "bwpatch\XEH_hitPart.hpp"
};
//class Extended_incomingMissile_EventHandlers {};
class Extended_inventoryClosed_EventHandlers {
    #include "logistics\XEH_InventoryClosed.hpp"
};
//class Extended_inventoryOpened_EventHandlers {};
class Extended_killed_EventHandlers {
    #include "headquarter\XEH_killed.hpp"
};
//class Extended_landedTouchDown_EventHandlers {};
//class Extended_landedStopped_EventHandlers {};
//class Extended_local_EventHandlers {};
class Extended_respawn_EventHandlers {
    #include "player\XEH_respawn.hpp"
};
//class Extended_put_EventHandlers {};
//class Extended_take_EventHandlers {};
class Extended_seatSwitched_EventHandlers {
    #include "player\XEH_SeatSwitched.hpp"
};
//class Extended_soundPlayed_EventHandlers {};
//class Extended_weaponAssembled_EventHandlers {};
//class Extended_weaponDisAssembled_EventHandlers {};
