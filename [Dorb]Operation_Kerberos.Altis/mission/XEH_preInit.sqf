#include "script_component.hpp"

ADDON = false;

PREP(choose_main);
PREP(choose_side);

PREP(examine);

PREP(init);

PREP(rescue_draw3D);
PREP(reward);
PREP(rtb);

PREP(taskhandler);

PREPS(mainmission,create);
PREPS(mainmission,device);
PREPS(mainmission,emp);
PREPS(mainmission,prototype);
PREPS(mainmission,scarab);
PREPS(mainmission,scarab_explode);
PREPS(mainmission,scarab_launch);
PREPS(mainmission,tower);

PREPS(sidemission,create);

ADDON = true;