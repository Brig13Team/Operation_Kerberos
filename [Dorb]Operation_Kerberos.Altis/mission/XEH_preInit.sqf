#include "script_component.hpp"

ADDON = false;

PREP(choose_main);
PREP(choose_side);

PREP(examine);

PREP(playerinit);

PREP(rescue_draw3D);
PREP(reward);
PREP(rtb);

PREP(taskhandler);


PREPS(suitcase,carry);
PREPS(suitcase,drop);
PREPS(suitcase,handler);

PREPS(mainmission,create);
PREPS(mainmission,clear);
PREPS(mainmission,device);
PREPS(mainmission,emp);
PREPS(mainmission,intel);
PREPS(mainmission,kill);
PREPS(mainmission,hostage);
PREPS(mainmission,prototype);
PREPS(mainmission,scarab);
PREPS(mainmission,scarab_explode);
PREPS(mainmission,scarab_launch);
PREPS(mainmission,tower);
PREPS(mainmission,weaponcaches);

PREPS(sidemission,convoi);
PREPS(sidemission,create);


ADDON = true;