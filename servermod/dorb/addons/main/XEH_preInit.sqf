#include "script_component.hpp"

ISNILS(logging,[]);

ADDON = false;

#include "PREP.sqf"

ADDON = true;

[] call FUNC(hash_initialize);
