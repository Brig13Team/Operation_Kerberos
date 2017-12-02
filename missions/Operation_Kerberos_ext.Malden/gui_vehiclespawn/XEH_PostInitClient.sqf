#define DEBUG_MODE_FULL

#include "script_component.hpp"

switch (str(side player)) do {
    case "WEST" : {
        private _id = ["carrier_west",west_carrier] call FUNC(registerSpawn);
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

        _id = ["vehicles_west_public",west_landvehicles] call FUNC(registerSpawn);
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

        _id = ["logistic_west",west_logistic] call FUNC(registerSpawn);
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
        _id = ["logistic_west",west_logistic2] call FUNC(registerSpawn);
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

        _id = ["naval_west",west_naval] call FUNC(registerSpawn);
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
        private _id = ["vehicles_resistance",resistance_vehiclespawn] call FUNC(registerSpawn);
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

        _id = ["air_resistance_public",resistance_airspawn] call FUNC(registerSpawn);
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

        _id = ["naval_resistance",resistance_marinespawn] call FUNC(registerSpawn);
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

        _id = ["logistic_resistance",resistance_logistic] call FUNC(registerSpawn);
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
    };
};
