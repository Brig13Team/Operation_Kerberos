
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

ADDON = true;

GVAR(SpawnLast) = CBA_missiontime;
GVAR(targetHouses) = [];
GVAR(usedHouses) = [];
GVAR(spawnedCompositions) = [];
GVAR(cleanUpDump) = [];

ISNIL(camouflage,0);

GVAR(armysWhitelist) = getMissionConfigValue["kerberos_armyWhitelist",[]];
