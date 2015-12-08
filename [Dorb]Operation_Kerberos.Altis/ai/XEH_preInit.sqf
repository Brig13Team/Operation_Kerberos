#include "script_component.hpp"

ADDON = false;

PREP(EH_killed);

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
PREPS(fdc,register);


PREP(attackpos_create);
PREP(attackpos_getAll);
PREP(dangerzone_buffer);
PREP(handle);
PREP(init);
PREP(init_mission);
PREP(killed);
PREP(recon);
PREP(recon_radars);
PREP(register_Group);
PREP(register_POI);
PREP(reset);
PREP(state_attack);
PREP(state_change);
PREP(state_defend);
PREP(state_evade);
PREP(state_idle);
PREP(state_retreat);
PREP(state_wait);
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


