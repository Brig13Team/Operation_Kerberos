#include "script_component.hpp"

ADDON = false;

PREP(end);
PREP(handleRescuePoint);
PREP(spawn);
PREP(spawnSide);

PREPS(mainmission,_holdPFH);
PREPS(mainmission,_oneCounter_condition);
PREPS(mainmission,_oneCounter);
PREPS(mainmission,_rtb_condition);
PREPS(mainmission,_twoCounters_condition);
PREPS(mainmission,_twoCounters);
PREPS(mainmission,capture);
PREPS(mainmission,device);
PREPS(mainmission,dronecommando);
PREPS(mainmission,emp);
PREPS(mainmission,hold);
PREPS(mainmission,hostage);
PREPS(mainmission,intel);
PREPS(mainmission,jammer);
PREPS(mainmission,prototype);
PREPS(mainmission,prototype_rescued);
PREPS(mainmission,radiotower);
PREPS(mainmission,rtb);
PREPS(mainmission,scarab);
PREPS(mainmission,upload);
PREPS(mainmission,weaponcache);

PREPS(sidemission,artillery);
PREPS(sidemission,chopper);
PREPS(sidemission,chopper_failed);
PREPS(sidemission,radar);
PREPS(sidemission,supplys_succeeded);
PREPS(sidemission,wreck);

PREPS(spawn,chooseLocation);
PREPS(spawn,chooseMission);
PREPS(spawn,createAtRescuePoint);
PREPS(spawn,getAmount);
PREPS(spawn,getObjects);
PREPS(spawn,getRadius);
PREPS(spawn,spawnTargets);

PREPS(spawnfunctions,supplys);

PREPS(statemachine,addSide);
PREPS(statemachine,addTask);
PREPS(statemachine,cancelALL);
PREPS(statemachine,checkOneCounter);
PREPS(statemachine,checkTwoCounter);
PREPS(statemachine,chooseMain);
PREPS(statemachine,cleanup);
PREPS(statemachine,endmission);
PREPS(statemachine,getMissions);
PREPS(statemachine,HoldPFH);
PREPS(statemachine,initHold);
PREPS(statemachine,initOneCounter);
PREPS(statemachine,initTwoCounter);
PREPS(statemachine,onTransition);
PREPS(statemachine,rtb);
PREPS(statemachine,spawn);

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
PREPS(obj,doTriangulate);
// PREPS(obj,effectDownloadClient);
// PREPS(obj,effectDownloadServer);
PREPS(obj,effectEarthquake);
// PREPS(obj,effectSandstorm);
PREPS(obj,effectTriangulation);
// PREPS(obj,handleCarry);
// PREPS(obj,init_Download);
// PREPS(obj,initACEAction_case);
PREPS(obj,initACEAction_DataTerminal);
PREPS(obj,initACEAction_device);
PREPS(obj,initACEAction_intel);
PREPS(obj,initACEAction_upload);
PREPS(obj,initACEAction_wreck);
PREPS(obj,markTargets);
PREPS(obj,onRadiotowerDamaged);
PREPS(obj,spawnEMP);
PREPS(obj,spawnNuke);
PREPS(obj,triangulate);

ADDON = true;

ISNIL(rescuepositions,[]);
