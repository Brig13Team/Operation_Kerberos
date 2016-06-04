/*
    Author: Dorbedo
    v1.0
*/
#include "script_component.hpp"

ADDON = false;

PREPS(attackpos,create);
PREPS(attackpos,create_logic);
PREPS(attackpos,getAll);
PREPS(attackpos,reduce);
PREPS(attackpos,remove);

PREP(dangerzone_buffer);
PREP(dangerzone_convert);

PREPS(drones,attack);
PREPS(drones,createWaypoint);
PREPS(drones,doAirstrike);
PREPS(drones,doReconnaissance);
PREPS(drones,init);
PREPS(drones,requestAirstrike);
PREPS(drones,requestReconnaissance);
PREPS(drones,scan);

PREPS(fdc,defend_artypos);
PREPS(fdc,handle);
PREPS(fdc,placeOrder);
PREPS(fdc,ready);
PREPS(fdc,register);

PREPS(state,attack);
PREPS(state,change);
PREPS(state,defend);
PREPS(state,evade);
PREPS(state,idle);
PREPS(state,retreat);
PREPS(state,wait);

PREPS(strategy,_exec);
PREPS(strategy,_choose);
PREPS(strategy,_failed);
PREPS(strategy,_success);
PREPS(strategy,airborne);
PREPS(strategy,armored);
PREPS(strategy,artillery);
PREPS(strategy,cas);
PREPS(strategy,drones);
PREPS(strategy,helicopter);
PREPS(strategy,infanterie);
PREPS(strategy,mortar);
PREPS(strategy,motorized);
PREPS(strategy,rocket);
PREPS(strategy,tankattack);

PREPS(waypoints,add);
PREPS(waypoints,deaktivate);
PREPS(waypoints,evade);
PREPS(waypoints,generate);
PREPS(waypoints,movementcost);
PREPS(waypoints,next);
PREPS(waypoints,test);





PREP(EH_killed);
PREP(handle);
PREP(killed);

PREP(recon);
PREP(recon_radars);

PREP(register_POI);

PREP(player_unconscious);
PREP(player_value);

PREP(strength_ai);
PREP(strength_player);

ADDON = true;


