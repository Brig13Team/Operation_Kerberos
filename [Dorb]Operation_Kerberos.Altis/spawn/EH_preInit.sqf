#include "script_component.hpp"

ADDON = false;

PREP(army_set);

PREP(cleanup_base);
PREP(cleanup_full);
PREP(createMinefields);
PREP(createMission);
PREP(createMissionComposition);
PREP(createMissionHouse);
PREP(crew);

PREP(delaySpawn);
PREP(gear);
PREP(getGroup);
PREP(getUnit);
PREP(group);
PREP(groupFromArray);

PREP(minefield);
PREP(minefields);
PREP(missiontarget);

PREP(naval_minefield);

PREP(onHit);
PREP(onMissionEnding);

PREP(Patrol_task);

PREP(spawnGroup_attack);
PREP(spawnGroup_defence);
PREP(spawnGroup_patrol);
PREP(spawnMinefieldACE);

PREP(stayInVehicle);

PREP(unit_limit);
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

PREPS(composition,chooseComposition);
PREPS(composition,chooseHouse);
PREPS(composition,createFromHouse);
PREPS(composition,createFromPosition);
PREPS(composition,helperRoad);
PREPS(composition,exportToHpp);
PREPS(composition,spawnComposition);
PREPS(composition,spawnHouse);

PREPS(mission,device);
PREPS(mission,hostages);
PREPS(mission,intel);
PREPS(mission,kill);

ADDON = true;

GVAR(SpawnLast) = CBA_missiontime;
GVAR(targetHouses) = [];
