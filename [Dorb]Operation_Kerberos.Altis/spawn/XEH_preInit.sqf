#include "script_component.hpp"

ADDON = false;

PREP(cleanup_base);
PREP(cleanup_full);

PREP(addACEMedicalItems);
PREP(addACErearmability);
PREP(addTFR);
PREP(army_set);

PREP(crew);

PREP(defence_create);
PREP(defence_macros);

PREP(exec_housemacro);
PREP(defence_house);

PREP(gear);
PREP(group);

PREP(macro_exec3d);
PREP(minefield);
PREP(minefields);
PREP(mission);

PREP(naval_minefield);

PREP(patrol_create);
PREP(Patrol_task);

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

ADDON = true;
