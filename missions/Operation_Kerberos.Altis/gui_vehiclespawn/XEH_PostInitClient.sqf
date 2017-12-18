#define DEBUG_MODE_FULL

#include "script_component.hpp"

TRACEV_1(side player);
switch (str(side player)) do {
    case "WEST" : {
        private _id = ["vehicles_west",vehiclespawn_west] call FUNC(registerSpawn);
        [
            LSTRING(NAME_VEHICLES),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["air_west",airspawn_west] call FUNC(registerSpawn);
        [
            LSTRING(NAME_AIR),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["logistic_west",logistic_west] call FUNC(registerSpawn);
        [
            LSTRING(NAME_LOGISTIC),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_logistic.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_logistic.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["naval_west",marinespawn_west] call FUNC(registerSpawn);
        [
            LSTRING(NAME_NAVAL),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
    case "EAST" : {
        private _id = ["vehicles_east",vehiclespawn_east] call FUNC(registerSpawn);
        [
            LSTRING(NAME_VEHICLES),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["air_east",airspawn_east] call FUNC(registerSpawn);
        [
            LSTRING(NAME_AIR),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["logistic_east",logistic_east] call FUNC(registerSpawn);
        [
            LSTRING(NAME_LOGISTIC),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_logistic.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_logistic.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["naval_east",marinespawn_east] call FUNC(registerSpawn);
        [
            LSTRING(NAME_NAVAL),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
    case "GUER" : {
        private _id = ["vehicles_resistance",vehiclespawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(NAME_VEHICLES),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_tank.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["air_resistance",airspawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(NAME_AIR),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_heli.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["logistic_resistance",logistic_resistance] call FUNC(registerSpawn);
        [
            LSTRING(NAME_LOGISTIC),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_logistic.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_logistic.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);

        _id = ["naval_resistance",marinespawn_resistance] call FUNC(registerSpawn);
        [
            LSTRING(NAME_NAVAL),
            ELSTRING(gui_main,CATEGORY_DEPOT),
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            LINKFUNC(openMenu),
            LINKFUNC(canOpenMenu),
            _id
        ] call EFUNC(gui_main,addApp);
        [
            format[QGVAR(interface_%1),_id],
            (parsingNamespace getVariable ["MISSION_ROOT",""]) + 'COMPONENT\data\icon_harbour.paa',
            {[ace_player,ace_player,_this] call FUNC(canOpenMenu);},
            _id
        ] call EFUNC(gui,addNotification);
    };
};
