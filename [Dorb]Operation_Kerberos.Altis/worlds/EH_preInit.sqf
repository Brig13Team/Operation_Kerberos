#include "script_component.hpp"

ADDON = false;

PREP(initialize);
PREP(exportLocations);
PREP(getLocations);
PREP(showLocations);


ADDON = true;

If (isServer) then {
    [] call FUNC(initialize);
};
