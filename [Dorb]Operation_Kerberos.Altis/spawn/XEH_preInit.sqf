#include "script_component.hpp"

ADDON = false;

PREP(addNVG);
PREP(addACEMedicalItems);

PREP(crew);
PREP(defence_macros);
PREP(gear);
PREP(macro_exec3d);
PREP(minefield);
PREP(minefields);
PREP(naval_minefield);
PREP(patrol)
PREP(Patrol_task);
PREP(unit);
PREP(vehicle);

PREPS(attack,air);
PREPS(attack,airdrop);
PREPS(attack,inf);
PREPS(attack,veh);
PREPS(attack,waves);

PREPS(city,fortify);
PREPS(city,fortify_buildings);
PREPS(city,fortify_roads);
PREPS(city,fortify_roads_defence);
PREPS(city,patrol_building);
PREPS(city,roads);
PREPS(city,spawn_explosives);
PREPS(city,spawn_static);
PREPS(city,spawn_unit);

PREPS(obj,mil);
PREPS(obj,sonstiges);
PREPS(obj,stadt);

ADDON = true;
