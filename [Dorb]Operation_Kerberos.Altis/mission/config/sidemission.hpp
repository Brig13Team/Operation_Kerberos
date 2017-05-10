#define CBA_OFF
#include "script_component.hpp"

class side {
    /*
     *  abstact missions
     */
    class __base {
        class location {
            // the possible locations, if none defined, the mainlocation is used
            areas[] = {};
            // the min/max distance of the location to choose, if negative, the condition is ignored
            minDistance = -1;
            maxDistance = -1;
            // the radius around the location
            radius = 500;
        };
        class object {};

        class defence {
            target = ""; // "house", "composition" or ""
            composition_types[] = {"isObjective"};
            house_types[] = {"hasmissiontarget"};
        };

        probability = 1.0;
        // special spawnfunction, if needed, returns the missionobjects
        spawnfunction = "";

        // if we want to delay the task showing up
        taskdelay = 0;

        // if we want to delay ths spawning
        spawndelay = 0;
    };

    /*
     *  playable missions
     */
    class radar : __base {
        conditiontype = "oneCounter";
        class location : location {
            radius = 500;
        };
        class defence {
            target = "composition";
            composition_types[] = {"radar"};
        };
        disableMarker = 1;
    };

    /*
    class artillery : __base {
        conditiontype = "oneCounter";
        class location : location {
            radius = 500;
        };
        class defence {
            target = "composition";
            composition_types[] = {"artillery"};
        };
        disableMarker = 1;
    };
    */

/*
    class wreck : __base {
        class location : location {
            radius = 3000;
        };
    };
*/
    class supplys : __base {
        class location : location {
            areas[] = {QGVAR(town)};
            minDistance = 4000;
            maxDistance = -1;
        };
        spawnfunction = QFUNC(spawnfunctions_supplys);
    };
};
