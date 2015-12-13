#include "script_component.hpp"

ADDON = false;

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


PREP(attackpos_create);
PREP(attackpos_create_logic);
PREP(attackpos_getAll);
PREP(attackpos_reduce);
PREP(attackpos_remove);

PREP(dangerzone_buffer);
PREP(dangerzone_convert);

PREP(EH_killed);
PREP(handle);
PREP(init);
PREP(killed);

PREP(mission_end);
PREP(mission_init);

PREP(recon);
PREP(recon_radars);

PREP(register_Group);
PREP(register_POI);


PREP(state_attack);
PREP(state_change);
PREP(state_defend);
PREP(state_evade);
PREP(state_idle);
PREP(state_retreat);
PREP(state_wait);

PREP(strategy);
PREP(strategy_airborne);
PREP(strategy_armored);
PREP(strategy_artillery);
PREP(strategy_cas);
PREP(strategy_choose);
PREP(strategy_drones);
PREP(strategy_failed);
PREP(strategy_helicopter);
PREP(strategy_infanterie);
PREP(strategy_mortar);
PREP(strategy_motorized);
PREP(strategy_rocket);
PREP(strategy_success);
PREP(strategy_tankattack);


PREP(strength);
PREP(waypoints_add);
PREP(waypoints_create);
PREP(waypoints_deaktivate);
PREP(waypoints_evade);
PREP(waypoints_generate);
PREP(waypoints_movementcost);
PREP(waypoints_next);

PREP(waypoints_test);

ADDON = true;


