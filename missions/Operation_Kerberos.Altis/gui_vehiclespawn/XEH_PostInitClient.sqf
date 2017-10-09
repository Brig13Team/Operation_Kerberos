#define DEBUG_MODE_FULL

#include "script_component.hpp"

TRACEV_1(side player);
switch (str(side player)) do {
    case "WEST" : {
        private _id = ["vehicles_west",vehiclespawn_west] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        _id = ["air_west",airspawn_west] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        _id = ["naval_west",marinespawn_west] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
    case "EAST" : {
        private _id = ["vehicles_east",vehiclespawn_east] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["air_east",airspawn_east] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["naval_east",marinespawn_east] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
    case "GUER" : {
        private _id = ["vehicles_resistance",vehiclespawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["air_resistance",airspawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);

        _id = ["naval_resistance",marinespawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
};
