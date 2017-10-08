#include "script_component.hpp"


switch (side player) do {
    case west : {
        private _id = ["vehicles_west",vehiclesspawn_west] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["air_west",airspawn_west] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["naval_west",marinespawn_west] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
    case east : {
        private _id = ["vehicles_east",vehiclesspawn_east] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["air_east",airspawn_east] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["naval_east",marinespawn_east] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
    case resistance : {
        private _id = ["vehicles_resistance",vehiclesspawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["air_resistance",airspawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["naval_resistance",marinespawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            LSTRING(CATEGORY_DEPOT),
            "",
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
};
