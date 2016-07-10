#define CBA_OFF
#include "script_component.hpp"
class missions_config {
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
        probability = 1;
        armys[] = {{"regular",1},{"armored",1},{"infanterie",1},{"airborne",1},{"specops",1},{"droneoperations",1},{"guards",1}};
        class sidemissions {};
    };
    class side_arty : side_base {
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
    class side_ugv : side_base {
        type = "ugv";
        class location : location {
            areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
            distance = 500;
        };
    };
    class side_convoi : side_base {
        type = "convoi";
        class location : location {
            areas[] = {QGVAR(water),QGVAR(military),QGVAR(other)};
            distance = 200;
        };
        delay_spawn = 600;
        delay_reveal = 60;
    };
    class side_radar : side_base {
        type = "radar";
        class location {
            areas[] = {}; /// empty array leads to position of Main Target
            distance = 600;
        };
        delay_spawn = 1;
        delay_reveal = 1;
        probability = 0.8;
    };
    class side_standard {
        class artillery : side_arty {
            probability = 0.8;
        };
        class radar1 : side_radar {
            probability = 0.8;
        };
        class radar2 : side_radar {
            probability = 0.6;
        };
        class convoi1 : side_convoi {
            probability = 0.8;
        };
        class convoi2 : side_convoi {
            delay_spawn = 1200;
        };    
    };
    class main {
        class scarab : main_base {
            taskDescription = "scarab";
            class sidemissions : side_standard {};
        };
        class tower : main_base {
            taskDescription = "tower";
            class location : location {
                distance = 1500;
            };
            class sidemissions : side_standard {};
        };
        class device : main_base {
            taskDescription = "device";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            class sidemissions : side_standard {};
        };
        class emp : main_base {
            taskDescription = "emp";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            class sidemissions : side_standard {};
        };
        class prototype : main_base {
            taskDescription = "prototype";
            class sidemissions : side_standard {};
        };
        class clear : main_base {
            taskDescription = "clear";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            class sidemissions : side_standard {};
        };
        
        class hostage : main_base {
            taskDescription = "hostage";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            class sidemissions : side_standard {};
        };
        class kill : main_base {
            taskDescription = "capture";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            class sidemissions : side_standard {};
        };
        class intel : main_base {
            taskDescription = "intel";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            class sidemissions : side_standard {};
        };
        class weaponcaches : main_base {
            taskDescription = "wpncache";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            class sidemissions : side_standard {};
        };
        class dronecommando : main_base {
            taskDescription = "dronecommando";
            armys[] = {{"specops",1},{"droneoperations",1},{"guards",1}};
            class sidemissions : side_standard {};
        };
        class specops : main_base {
            taskDescription = "specops";
            armys[] = {{"specops",1}};
            class sidemissions : side_standard {};
        };
        class outpost : main_base {
            taskDescription = "outpost";
            class location : location {
                areas[] = {QGVAR(military)};
            };
            class sidemissions : side_standard {};
        };
        class radarsetup : main_base {
            taskDescription = "radarsetup";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
            class sidemissions : side_standard {};
        };
    };
    class rtb {
        class location {
            areas[] = {QGVAR(base)};
            distance = 0;
        };
    };
};