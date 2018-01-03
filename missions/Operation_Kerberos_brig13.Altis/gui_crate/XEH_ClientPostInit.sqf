#include "script_component.hpp"


switch (str(side player)) do {
    case "WEST" : {
        private _id = ["GUI_ARSENAL",cratespawner1] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["GUI_ARSENAL",cratespawner2] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
    case "EAST" : {
        private _id = ["GUI_ARSENAL",cratespawner4] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
    case "GUER" : {
        private _id = ["GUI_ARSENAL",cratespawner5] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
    default {
        private _id = ["GUI_ARSENAL",cratespawner6] call FUNC(registerSpawn);
        [
            LSTRING(HEADER),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_robot.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
};
