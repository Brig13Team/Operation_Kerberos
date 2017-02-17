#include "script_component.hpp"

ADDON = false;

PREP(rtb);
PREP(handleRescuePoint);
PREP(spawn);
PREP(getAllMissionTargets);
PREP(testCreate);
PREP(test);

// helper funcitons
PREPS(mainmission,__chooseLocation);
PREPS(mainmission,__device_condition);
PREPS(mainmission,__device_event);
PREPS(mainmission,__device);
PREPS(mainmission,__getAmount);
PREPS(mainmission,__getRadius);
PREPS(mainmission,__spawn);
PREPS(mainmission,__spawnTargets);
// abstract missions
PREPS(mainmission,_oneCounter_condition);
PREPS(mainmission,_oneCounter);
PREPS(mainmission,_twoCounters_condition);
PREPS(mainmission,_twoCounters);
// missions
PREPS(mainmission,capture);
PREPS(mainmission,device);
PREPS(mainmission,emp);
PREPS(mainmission,hostage);
PREPS(mainmission,intel);
PREPS(mainmission,weaponcache);
/*
PREPS(mainmission,clear_cond);
PREPS(mainmission,clear);
PREPS(mainmission,dronecommando_cond);
PREPS(mainmission,dronecommando);
PREPS(mainmission,prototype_cond);
PREPS(mainmission,prototype);
PREPS(mainmission,radiotower_cond);
PREPS(mainmission,radiotower);
PREPS(mainmission,scarab_cond);
PREPS(mainmission,scarab);
PREPS(mainmission,specops);
PREPS(mainmission,specops_cond);
*/

PREPS(sidemission,clearArea);
PREPS(sidemission,targetsAlive);

PREPS(taskmanager,__add);
PREPS(taskmanager,__cancelAll);
PREPS(taskmanager,__handle);
PREPS(taskmanager,__remove);
PREPS(taskmanager,__setState);
PREPS(taskmanager,add);
PREPS(taskmanager,addChild);
PREPS(taskmanager,handle);
PREPS(taskmanager,init);
PREPS(taskmanager,remove);
PREPS(taskmanager,removeChild);
PREPS(taskmanager,setState);
PREPS(taskmanager,setStateChild);
/*
PREPS(taskmanager,spawn);
PREPS(taskmanager,spawnSide);
*/

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

PREPS(obj,canCarry);
PREPS(obj,canDisable);
PREPS(obj,canDrop);
PREPS(obj,canDownload);
PREPS(obj,createSandstorm);
PREPS(obj,disableSandstorm);
PREPS(obj,doCarry);
PREPS(obj,doDisable);
PREPS(obj,doDownload);
PREPS(obj,doDrop);
PREPS(obj,doTriangulate);
PREPS(obj,effectDownloadClient);
PREPS(obj,effectDownloadServer);
PREPS(obj,effectEarthquake);
PREPS(obj,effectSandstorm);
PREPS(obj,effectTriangulation);
PREPS(obj,handleCarry);
PREPS(obj,init_commander);
PREPS(obj,init_device);
PREPS(obj,init_download);
PREPS(obj,init_hostage);
PREPS(obj,init_prototype);
PREPS(obj,initACEAction_case);
PREPS(obj,initACEAction_DataTerminal);
PREPS(obj,initACEAction_device);
PREPS(obj,initACEAction_Laptop);
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
PREPS(obj,triangulate);

ADDON = true;
