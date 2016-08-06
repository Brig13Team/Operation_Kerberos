#include "script_component.hpp"

ADDON = false;

PREP(choose_main);
PREP(choose_side);

PREP(examine);

PREP(registerTask);
PREP(reward);
PREP(rtb);

PREP(isSidemission);

PREP(taskhandler);

PREPS(objects,case_carry);
PREPS(objects,case_drop);
PREPS(objects,case_handler);
PREPS(objects,device_canDisable);
PREPS(objects,device_damage_C4);
PREPS(objects,device_damage_disable);
PREPS(objects,device_disable);
PREPS(objects,device_effect_sandstorm);
PREPS(objects,device_effect_sandstorm_init);
PREPS(objects,device_init);
PREPS(objects,intel_init);

PREPS(taskmanager,add);
PREPS(taskmanager,addChild);
PREPS(taskmanager,cancel);
PREPS(taskmanager,cancelAll);
PREPS(taskmanager,choose_location);
PREPS(taskmanager,choose_mission);
PREPS(taskmanager,exists);
PREPS(taskmanager,init);
PREPS(taskmanager,remove);
PREPS(taskmanager,setState);
PREPS(taskmanager,spawn);

PREPS(mainmission,intel);
PREPS(mainmission,intel_cond);

ADDON = true;
