#include "script_component.hpp"

ISNILS(logging,[]);

ADDON = false;

EFUNC(main,compile) = compile preProcessFileLineNumbers '\MAINPREFIX\PREFIX\addons\main\functions\fnc_compile.sqf';

#include "XEH_PREP.hpp"

ADDON = true;

[] call FUNC(hash_initialize);
