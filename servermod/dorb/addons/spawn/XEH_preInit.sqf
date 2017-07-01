
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

ADDON = true;

GVAR(SpawnLast) = CBA_missiontime;
GVAR(targetHouses) = [];
GVAR(usedHouses) = [];
GVAR(spawnedCompositions) = [];
GVAR(cleanUpDump) = [];
