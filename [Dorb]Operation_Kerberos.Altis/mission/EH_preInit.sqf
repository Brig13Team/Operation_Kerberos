#include "script_component.hpp"

ADDON = false;

PREP(rtb);
PREP(testCreate);
PREP(test);

PREPS(mainmission,capture_cond);
PREPS(mainmission,capture);
PREPS(mainmission,clear_cond);
PREPS(mainmission,clear);
PREPS(mainmission,device_cond);
PREPS(mainmission,device);
PREPS(mainmission,dronecommand_cond);
PREPS(mainmission,dronecommand);
PREPS(mainmission,emp_cond);
PREPS(mainmission,emp);
PREPS(mainmission,hostage_cond);
PREPS(mainmission,hostage);
PREPS(mainmission,intel_cond);
PREPS(mainmission,intel);
PREPS(mainmission,prototype_cond);
PREPS(mainmission,prototype);
PREPS(mainmission,radiotower_cond);
PREPS(mainmission,radiotower);
PREPS(mainmission,scarab_cond);
PREPS(mainmission,scarab);
PREPS(mainmission,weaponcache_cond);
PREPS(mainmission,weaponcache);

PREPS(objects,case_carry);
PREPS(objects,case_drop);
PREPS(objects,case_handler);
PREPS(objects,device_canDisable);
PREPS(objects,device_doDisable);
PREPS(objects,device_effect_sandstorm_init);
PREPS(objects,device_effect_sandstorm);
PREPS(objects,device_init);
PREPS(objects,handlerRescue);
PREPS(objects,initACEAction_Device);
PREPS(objects,initACEAction_Intel);
PREPS(objects,nuke);
PREPS(objects,onCacheDestroyed);
PREPS(objects,onEarthquake);
PREPS(objects,onEMP);
PREPS(objects,onHandleDamageC4);
PREPS(objects,onHostageKilled);
PREPS(objects,onHostageRescued);
PREPS(objects,onIntelFound);
PREPS(objects,onPrototypeKilled);
PREPS(objects,onPrototypeReturned);

PREPS(sidemission,clearArea);
PREPS(sidemission,targetsAlive);

PREPS(taskmanager,add);
PREPS(taskmanager,addChild);
PREPS(taskmanager,cancel);
PREPS(taskmanager,cancelAll);
PREPS(taskmanager,choose_location);
PREPS(taskmanager,choose_mission);
PREPS(taskmanager,exists);
PREPS(taskmanager,handle);
PREPS(taskmanager,init);
PREPS(taskmanager,remove);
PREPS(taskmanager,setState);
PREPS(taskmanager,spawn);
PREPS(taskmanager,spawnSide);

ADDON = true;
