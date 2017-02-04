#include "script_component.hpp"

ADDON = false;

PREP(rtb);
PREP(handleRescuePoint);
PREP(onKilled);
PREP(testCreate);
PREP(test);

/*
PREPS(mainmission,capture_cond);
PREPS(mainmission,capture);
PREPS(mainmission,clear_cond);
PREPS(mainmission,clear);
PREPS(mainmission,device_cond);
PREPS(mainmission,device);
PREPS(mainmission,dronecommando_cond);
PREPS(mainmission,dronecommando);
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
PREPS(mainmission,specops);
PREPS(mainmission,specops_cond);
PREPS(mainmission,weaponcache_cond);
PREPS(mainmission,weaponcache);
*/

PREPS(sidemission,clearArea);
PREPS(sidemission,targetsAlive);

PREPS(taskmanager,add);
PREPS(taskmanager,addChild);
PREPS(taskmanager,choose_location);
PREPS(taskmanager,choose_mission);
PREPS(taskmanager,handle);
PREPS(taskmanager,init);
PREPS(taskmanager,remove);
PREPS(taskmanager,removeChild);
PREPS(taskmanager,setState);
PREPS(taskmanager,setStateChild);
PREPS(taskmanager,spawn);
PREPS(taskmanager,spawnSide);

PREPS(obj,canCarry);
PREPS(obj,canDisable);
PREPS(obj,canDrop);
PREPS(obj,createSandstorm);
PREPS(obj,disableSandstorm);
PREPS(obj,doCarry);
PREPS(obj,doDisable);
PREPS(obj,doDownload);
PREPS(obj,doDrop);
PREPS(obj,effectEarthquake);
PREPS(obj,effectSandstorm);
PREPS(obj,handleCarry);
PREPS(obj,init_commander);
PREPS(obj,init_device);
PREPS(obj,init_hostage);
PREPS(obj,init_prototype);
PREPS(obj,initACEAction_case);
PREPS(obj,initACEAction_DataTerminal);
PREPS(obj,initACEAction_device);
PREPS(obj,initACEAction_secureIntel);
PREPS(obj,onCommanderCaptured);
PREPS(obj,onCommanderKilled);
PREPS(obj,onHostageKilled);
PREPS(obj,onHostageRescued);
PREPS(obj,onIntelFound);
PREPS(obj,onPrototypeKilled);
PREPS(obj,onPrototypeReturned);
PREPS(obj,onWeaponCacheDestroyed);
PREPS(obj,spawnEMP);
PREPS(obj,spawnNuke);

ADDON = true;
