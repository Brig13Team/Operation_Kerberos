/*
    Author: Dorbedo
    v1.0
*/
#include "script_component.hpp"

ADDON = false;

PREPS(attackpos,add);
PREPS(attackpos,atPosition);
PREPS(attackpos,check);
PREPS(attackpos,create);
PREPS(attackpos,delete);
PREPS(attackpos,reduce);
PREPS(attackpos,update);

PREPS(drones,attack);
PREPS(drones,canDoAirstrike);
PREPS(drones,canDoReconnaissance);
PREPS(drones,createWaypoint);
PREPS(drones,doAirstrike);
PREPS(drones,doReconnaissance);
PREPS(drones,handle);
PREPS(drones,onMissionEnd);
PREPS(drones,onMissionStart);
PREPS(drones,requestAirstrike);
PREPS(drones,requestReconnaissance);
PREPS(drones,scan);

PREPS(fdc,handle);
PREPS(fdc,placeOrder);
PREPS(fdc,ready);
PREPS(fdc,register);

PREPS(ressources,CanCallInUnits);
PREPS(ressources,canUseCallIn);
PREPS(ressources,CheckIntervall);
PREPS(ressources,getsaveSpawnPos);
PREPS(ressources,getsaveSpawnPosAir);
PREPS(ressources,handle);
PREPS(ressources,onMissionInit);
PREPS(ressources,supply);
PREPS(ressources,supplyAirdrop);
PREPS(ressources,supplyInfanterie);
PREPS(ressources,supplyMechanized);
PREPS(ressources,supplyMounted);
PREPS(ressources,supplySniper);
PREPS(ressources,supplyTanks);

PREPS(state,attack);
PREPS(state,change);
PREPS(state,defend);
PREPS(state,evade);
PREPS(state,idle);
PREPS(state,retreat);
PREPS(state,set);
PREPS(state,wait);

PREPS(statemachine,airinterception);
PREPS(statemachine,attack);
PREPS(statemachine,attackfinished);
PREPS(statemachine,canBeDeletedUnseen);
PREPS(statemachine,cas);
PREPS(statemachine,delete);
PREPS(statemachine,getAIGroups);
PREPS(statemachine,OffMapreturn);
PREPS(statemachine,patrol);
PREPS(statemachine,patrolCombat);
PREPS(statemachine,patrolDefence);
PREPS(statemachine,PatrolTask);;
PREPS(statemachine,return);
PREPS(statemachine,supply);
PREPS(statemachine,transport);
PREPS(statemachine,transportUnload);

PREPS(strategy,_checkisWorking);
PREPS(strategy,_choose);
PREPS(strategy,_onfinished);
PREPS(strategy,_onFinishAir);
PREPS(strategy,_onFinishSAD);
PREPS(strategy,airinterception);
PREPS(strategy,artillery);
PREPS(strategy,cas);
PREPS(strategy,drones);
PREPS(strategy,groundattack);
PREPS(strategy,helicopter);
PREPS(strategy,mortar);
PREPS(strategy,rocket);

PREPS(waypoints,add);
PREPS(waypoints,costs);
PREPS(waypoints,deactivate);
PREPS(waypoints,generate);
PREPS(waypoints,movementcost);
PREPS(waypoints,next);
PREPS(waypoints,test);
PREPS(waypoints,updateValue);

PREP(balanceGroups);
PREP(checkPOI);
PREP(dzconvert);
PREP(dzFindPeaks);
PREP(getCost);
PREP(getDefence);
PREP(getDistanceCoeff);
PREP(getDZCoeff);
PREP(getKnownPlayerPos);
PREP(getPlayerCoeff);
PREP(getstrengthAI);
PREP(getstrengthAIGroup);
PREP(getType);
PREP(handle);
PREP(handleAA);
PREP(handleDebugMarker);
PREP(handlePlayerGroups);
PREP(handleRadars);
PREP(initVehicle);
PREP(killedUnit);
PREP(MissionCleanUp);
PREP(MissionInit);
PREP(onKilled);
PREP(onUnconscious);
PREP(radar_airInterceptionGroup);
PREP(registerAA);
PREP(registerGroup);
PREP(registerPlayerGroup);
PREP(registerPOI);
PREP(registerRadar);
PREP(requestRecon);
PREP(strengthPlayer);

ADDON = true;
