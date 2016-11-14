#include "script_component.hpp"

ADDON = false;

PREP(army_set);
PREP(cleanup_base);
PREP(cleanup_full);
PREP(crew);

PREP(defence_create);
PREP(defence_macros);

//PREP(exec_housemacro).sqf

PREP(gear);
PREP(group);

PREP(macro_exec3d);
//PREP(mainmission);
PREP(minefield);
PREP(minefields);
PREP(mission);

PREP(naval_minefield);

PREP(onHit);

PREP(patrol_create);
PREP(Patrol_task);

PREP(stayInVehicle);

PREP(strikeforce_create);

PREP(unit);

PREP(vehicle);


PREPS(city,fortify);
PREPS(city,fortify_buildings);
PREPS(city,fortify_roads);
PREPS(city,fortify_roads_defence);
PREPS(city,patrol_building);
PREPS(city,roads);
PREPS(city,spawn_explosives);
PREPS(city,spawn_static);
PREPS(city,spawn_unit);

PREPS(composition,chooseHouse);
PREPS(composition,createFromHouse);
PREPS(composition,exportToHpp);
PREPS(composition,spawnHouse);

ADDON = true;
