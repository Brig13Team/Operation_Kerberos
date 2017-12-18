#include "script_component.hpp"

GVAR(compositions) = [] call FUNC(getPossibleCompositions);
GVAR(houses) = [] call FUNC(getPossibleHouseCompositions);

GVAR(mission) = [true] call FUNC(getPossibleCompositions);
GVAR(missionhouses) = [true] call FUNC(getPossibleHouseCompositions);

