#include "script_component.hpp"

ADDON = false;

PREP(end);
PREP(handleRescuePoint);
PREP(spawn);
PREP(spawnSide);

PREPS(mainmission,_oneCounter_condition);
PREPS(mainmission,_oneCounter);
PREPS(mainmission,_rtb_condition);
PREPS(mainmission,_twoCounters_condition);
PREPS(mainmission,_twoCounters);
PREPS(mainmission,capture);
PREPS(mainmission,device);
PREPS(mainmission,dronecommando);
PREPS(mainmission,emp);
PREPS(mainmission,hostage);
PREPS(mainmission,intel);
PREPS(mainmission,prototype);
PREPS(mainmission,radiotower);
PREPS(mainmission,rtb);
PREPS(mainmission,scarab);
PREPS(mainmission,weaponcache);

PREPS(sidemission,radar);

PREPS(spawn,chooseLocation);
PREPS(spawn,getAmount);
PREPS(spawn,getObjects);
PREPS(spawn,getRadius);
PREPS(spawn,spawnTargets);

PREPS(taskmanager,__add);
PREPS(taskmanager,__cancelAll);
PREPS(taskmanager,__handle);
PREPS(taskmanager,__remove);
PREPS(taskmanager,__setState);
PREPS(taskmanager,add);
PREPS(taskmanager,addChild);
PREPS(taskmanager,getMissionTargets);
PREPS(taskmanager,handle);
PREPS(taskmanager,hasActiveMissions);
PREPS(taskmanager,init);
PREPS(taskmanager,remove);
PREPS(taskmanager,removeChild);
PREPS(taskmanager,setState);
PREPS(taskmanager,setStateChild);

PREPS(obj,__message);
PREPS(obj,_increaseCounter);
PREPS(obj,_increaseCounterOne);
PREPS(obj,_increaseCounterTwo);
PREPS(obj,_triggerFailed);
PREPS(obj,callEvent);
// PREPS(obj,canCarry);
// PREPS(obj,canDownload);
// PREPS(obj,canDrop);
// PREPS(obj,createSandstorm);
// PREPS(obj,disableSandstorm);
// PREPS(obj,doCarry);
// PREPS(obj,doDownload);
PREPS(obj,doDrop);
// PREPS(obj,doTriangulate);
// PREPS(obj,effectDownloadClient);
// PREPS(obj,effectDownloadServer);
PREPS(obj,effectEarthquake);
// PREPS(obj,effectSandstorm);
// PREPS(obj,effectTriangulation);
// PREPS(obj,handleCarry);
// PREPS(obj,init_Download);
// PREPS(obj,initACEAction_case);
// PREPS(obj,initACEAction_DataTerminal);
PREPS(obj,initACEAction_device);
PREPS(obj,initACEAction_intel);
PREPS(obj,onRadiotowerDamaged);
PREPS(obj,spawnEMP);
PREPS(obj,spawnNuke);
// PREPS(obj,triangulate);

ADDON = true;