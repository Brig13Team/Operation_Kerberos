
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
GVAR(armysBlacklist) = getMissionConfigValue["kerberos_armyBlacklist",["vanilla"]];
GVAR(armysBlacklist) = GVAR(armysBlacklist) select {!(_x in GVAR(armysWhitelist))};
