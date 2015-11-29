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
PREPS(fdc,init);
PREPS(fdc,observer);
PREPS(fdc,placeOrder);
PREPS(fdc,register);

PREP(check_radars);
PREP(dangerzone_buffer);
PREP(handle);
PREP(init);
PREP(init_mission);
PREP(killed);
PREP(recon);
PREP(registerALLGroups);
PREP(registerGroup);
PREP(reset);
PREP(state_attack);
PREP(state_change);
PREP(state_defend);
PREP(state_evade);
PREP(state_idle);
PREP(state_retreat);
PREP(state_wait);
PREP(waypoints_add);
PREP(waypoints_generate);
ADDON = true;
