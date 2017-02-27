#define CBA_OFF
#include "script_component.hpp"

class missions_config {
    class side {
        class side_base {
            class task {
                name = "";
                description = "";
                tasktype = "";
                taskmarker = "";
            };
            class location {
                areas[] = {QGVAR(town),QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 500;
                areas_minDistance = 500;
                areas_maxDistance = 2500;
            };
            type = "";
            probability = -1;
            spawn_fnc = "";
            spawn_delay = 600;
            task_fnc = "";
            task_delay = 300;
            markerOnSpot = 1;
        };
        class artillery_base : side_base {
            type = "artillery";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 500;
                areas_minDistance = 3000;
                areas_maxDistance = 25000;
            };
            spawn_fnc = QEFUNC(spawn,sidemission_artillery);
            spawn_delay = 0;
            task_fnc = QEFUNC(mission,sidemission_targetsAlive);
            task_delay = 1800;
            markerOnSpot = 0;
        };
        class ugv_base : side_base {
            type = "ugv";
            class location : location {
                areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
                distance = 500;
            };
        };
        class convoi_base : side_base {
            type = "convoi";
            class location : location {
                areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
                distance = 200;
            };
            spawn_delay = 600;
            spawn_fnc = QEFUNC(spawn,sidemission_convoi);
            task_delay = 60;
            task_fnc = QEFUNC(mission,sidemission_convoi);
        };
        class radar_base : side_base {
            type = "radar";
            class location {
                areas[] = {}; /// empty array leads to position of Main Target
                distance = 600;
            };
            spawn_delay = 1;
            spawn_fnc = QEFUNC(spawn,sidemission_radar);
            task_delay = 1;
            task_fnc = QEFUNC(mission,sidemission_targetsAlive);
        };
        /*
        class rtb {
            class location {
                areas[] = {QGVAR(base)};
                distance = 0;
            };
        };
        */
    };

    class main_base {
        class task {
            name = "";
            description = "";
            tasktype = "";
            taskmarker = "";
        };
        class location {
            areas[] = {QGVAR(town),QGVAR(industrie),QGVAR(military),QGVAR(other)};
            distance = 800;
        };
        objectsamount_min = 1;
        objectsamount_max = 1;
        probability = 1;
        armys[] = {{"regular",1},{"armored",1},{"infanterie",1},{"airborne",1},{"specops",1},{"droneoperations",1},{"guards",1}};
        class sidemissions : side {
            class artillery : artillery_base {
                probability = 0.8;
            };
            class artillery2 : artillery_base {
                probability = 0.2;
            };
            class radar : radar_base {
                probability = 0.8;
            };
            /*
            class convoi : convoi_base {
                probability = 0.8;
            };
            */
        };
    };

    class main {
        class intel : main_base {
            taskDescription = "intel";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 2;
            objectsamount_max = 10;
        };
        class weaponcache : main_base {
            taskDescription = "weaponcache";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 5;
            objectsamount_max = 10;
        };
        class device : main_base {
            taskDescription = "device";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(town),QGVAR(industrie)};
                distance = 250;
            };
            intervall = 10;
        };
        class emp : device {
            taskDescription = "emp";
        };
        class hostage : main_base {
            taskDescription = "hostage";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 1;
            objectsamount_max = 5;
        };
        class clear : main_base {
            taskDescription = "clear";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            clearradius = 750;
            // the amount of units which can remain in a area
            unitamount = 10;
        };
        class capture : main_base {
            taskDescription = "capture";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 1;
            objectsamount_max = 3;
        };

        class scarab : main_base {
            taskDescription = "scarab";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 100;
            };
            objectsamount_min = 1;
            objectsamount_max = 3;
        };

        class radiotower : main_base {
            taskDescription = "radiotower";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 1500;
            };
            objectsamount_min = 1;
            objectsamount_max = 3;
        };
        class dronecommando : main_base {
            taskDescription = "dronecommando";
            class sidemissions : sidemissions {};
            class location : location {};
            armys[] = {{"specops",1},{"droneoperations",1},{"guards",1}};
        };
        class prototype : main_base {
            taskDescription = "prototype";
            class sidemissions : sidemissions {};
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 1500;
            };
            objectsamount_min = 1;
            objectsamount_max = 1;
        };
        class specops : main_base {
            taskDescription = "specops";
            class sidemissions : sidemissions {};
            class location : location {};
            armys[] = {{"specops",1}};
            clearradius = 750;
            // the amount of units which can remain in a area
            unitamount = 10;
        };
        /*
        class outpost : main_base {
            taskDescription = "outpost";
            class location : location {
                areas[] = {QGVAR(military)};
            };
        };
        class kill : main_base {
            taskDescription = "capture";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
        };
        class radarsetup : main_base {
            taskDescription = "radarsetup";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
        };
        */
    };


};
