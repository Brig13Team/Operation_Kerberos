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


PREPS(objects,case_carry);
PREPS(objects,case_drop);
PREPS(objects,case_handler);
PREPS(objects,device_canDisable);
PREPS(objects,device_damage_C4);
PREPS(objects,device_damage_disable);
PREPS(objects,device_disable);
PREPS(objects,device_effect_earthquake);
PREPS(objects,device_effect_emp);
PREPS(objects,device_effect_sandstorm);
PREPS(objects,device_effect_sandstorm_init);
PREPS(objects,device_init);


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