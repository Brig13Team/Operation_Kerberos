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
        objects[] = {};
        objects_count[] = {};
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
            objects[] = {"Land_File1_F","Land_File2_F","Land_FilePhotos_F","Land_Laptop_F","Land_Laptop_unfolded_F","Land_SatellitePhone_F","Land_MobilePhone_smart_F"/*,"Land_Suitcase_F"*/};
            objects_count[] = {1,10};
        };
        class weaponcache : main_base {
            taskDescription = "weaponcache";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            objects[] = {"Box_East_Wps_F","Box_East_WpsSpecial_F","Box_East_Ammo_F","Box_East_Grenades_F","Box_East_Support_F"};
            objects_count[] = {5,10};
        };
        class device : main_base {
            taskDescription = "device";
            class location : location {
                areas[] = {QGVAR(town),QGVAR(industrie)};
                distance = 250;
            };
            object = "Land_Device_assembled_F";
            intervall = 10;
        };
        class emp : main_base {
            taskDescription = "emp";
            class location : location {
                areas[] = {QGVAR(town),QGVAR(industrie)};
                distance = 250;
            };
            object = "Land_Device_assembled_F";
            intervall = 10;
        };
        class hostage : main_base {
            taskDescription = "hostage";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
            hostages[] = {"C_scientist_F","C_journalist_F","C_man_1","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F",C_man_polo_6_F};
            hostages_count[] = {1,5};
        };
        /*
        class scarab : main_base {
            taskDescription = "scarab";
        };
        class tower : main_base {
            taskDescription = "tower";
            class location : location {
                distance = 1500;
            };
        };
        class prototype : main_base {
            taskDescription = "prototype";
        };
        class clear : main_base {
            taskDescription = "clear";
            class location : location {
                areas[] = {QGVAR(industrie),QGVAR(military),QGVAR(other)};
            };
        };
        class kill : main_base {
            taskDescription = "capture";
            class location : location {
                areas[] = {QGVAR(town)};
                distance = 200;
            };
        };
        class dronecommando : main_base {
            taskDescription = "dronecommando";
            armys[] = {{"specops",1},{"droneoperations",1},{"guards",1}};
        };
        class specops : main_base {
            taskDescription = "specops";
            armys[] = {{"specops",1}};
        };
        class outpost : main_base {
            taskDescription = "outpost";
            class location : location {
                areas[] = {QGVAR(military)};
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
