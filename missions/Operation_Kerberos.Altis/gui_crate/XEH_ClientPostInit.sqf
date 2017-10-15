#include "script_component.hpp"

TRACEV_1(side player);
switch (str(side player)) do {
    case "WEST" : {
        private _id = ["west",cratespawner1] call FUNC(registerSpawn);
        TRACEV_1(_id);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
    case "EAST" : {
        private _id = ["east",cratespawner2] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
    case "GUER" : {
        private _id = ["guer",cratespawner3] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
    };
};
