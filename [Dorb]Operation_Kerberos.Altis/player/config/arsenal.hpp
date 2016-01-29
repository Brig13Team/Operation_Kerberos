#define CBA_OFF
#include "script_component.hpp"
class GVAR(arsenal) {
    class west {
        BISBlack[] = {"OPFOR","INDEP"};
        dlcs[] = {"RHS_USAF","bwa3"};
        class blacklist {
            items[] = {"B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F","B_Respawn_Sleeping_bag_F","B_Respawn_TentA_F","B_Respawn_TentDome_F"};
            magazines[] = {};
        };
    };
    class east {
        BISBlack[] = {"BLUFOR","INDEP"};
        dlcs[] = {"RHS_AFRF"};
        class blacklist {
            items[] = {"B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F","B_Respawn_Sleeping_bag_F","B_Respawn_TentA_F","B_Respawn_TentDome_F"};
            magazines[] = {};
        };
    };
};