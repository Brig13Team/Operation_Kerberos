#define CBA_OFF
#include "script_component.hpp"

class missions_config {
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
        class sidemissions {
              class artillery {
                  probability = 0.8;
              };
              class radar {
                  probability = 0.8;
              };
              class convoi {
                  probability = 0.8;
              };
        };
    };
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
        delay_spawn = 600;
        delay_reveal = 300;
        probability = 1;
    };

    class main {
        class intel : main_base {
            taskDescription = "intel";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 2;
            objectsamount_max = 10;
        };
        class weaponcache : main_base {
            taskDescription = "weaponcache";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 5;
            objectsamount_max = 10;
        };
        class device : main_base {
            taskDescription = "device";
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
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 0;
            objectsamount_max = 5;
        };
        class clear : main_base {
            taskDescription = "clear";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            clearradius = 750;
            // the amount of units which can remain in a area
            unitamount = 10;
        };
        class capture : main_base {
            taskDescription = "capture";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objectsamount_min = 1;
            objectsamount_max = 3;
        };

        class scarab : main_base {
            taskDescription = "scarab";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            objectsamount_min = 1;
            objectsamount_max = 3;
        };

        class radiotower : main_base {
            taskDescription = "radiotower";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 1500;
            };
            objectsamount_min = 1;
            objectsamount_max = 3;
        };
        class dronecommando : main_base {
            taskDescription = "dronecommando";
            armys[] = {{"specops",1},{"droneoperations",1},{"guards",1}};
        };
        class prototype : main_base {
            taskDescription = "prototype";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 1500;
            };
            objectsamount_min = 1;
            objectsamount_max = 1;
        };
        class specops : main_base {
            taskDescription = "specops";
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

    class side {
        class artillery : side_base {
            type = "artillery";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
                distance = 500;
                areas_minDistance = 3000;
                areas_maxDistance = 25000;
            };
            delay_spawn = 0;
            delay_reveal = 1800; // delay until the mission is revealed
        };
        class ugv : side_base {
            type = "ugv";
            class location : location {
                areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
                distance = 500;
            };
        };
        class convoi : side_base {
            type = "convoi";
            class location : location {
                areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
                distance = 200;
            };
            delay_spawn = 600;
            delay_reveal = 60;
        };
        class radar : side_base {
            type = "radar";
            class location {
                areas[] = {}; /// empty array leads to position of Main Target
                distance = 600;
            };
            delay_spawn = 1;
            delay_reveal = 1;
            probability = 0.8;
        };
        class rtb {
            class location {
                areas[] = {QGVAR(base)};
                distance = 0;
            };
        };
    };
};
