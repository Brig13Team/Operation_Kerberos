
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

        // used to delay the evaluation by seconds. (use 1E18 to delay BOOL-like)
        delaycheck = 0;
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


    class artillery : __base {
        conditiontype = "oneCounter";
        class location : location {
            areas[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
            minDistance = 5000;
            maxDistance = 9000;
        };
        class defence {
            target = "composition";
            composition_types[] = {"artillery"};
        };
        class object {
            min = 3;
            max = 3;

        };
        disableMarker = 1;
    };


/*
    class wreck : __base {
        class location : location {
            radius = 3000;
        };
        taskdelay = 1200;
    };
*/
/*
 *  deliver goods from rescuepoint to a civilian town
 *  Reward: POI-Position gets marked
 */
/*
    class supplys : __base {
        conditiontype = "oneCounter";
        class location : location {
            areas[] = {QGVAR(town)};
            minDistance = 4000;
            maxDistance = -1;
        };
        spawnfunction = QFUNC(spawnfunctions_supplys);
        //spawndelay = 600;
        probability = 0.2;
        onSucceeded = QFUNC(sidemission_supplys_succeeded);
    };
*/
/*
 *  Build an Antenna on Top of a Mountain
 *  Reward: some kind of triangulation effect for every vehicle
 */
/*
    class antenna : __base {
        class location : location {
            areas[] = {QGVAR(mountain)};
            minDistance = 6000;
            maxDistance = -1;
        };
        spawnfunction = QFUNC(spawnfunctions_antenna);
        spawndelay = 1000;
        probability = 0.2;
        onSucceeded = QFUNC(sidemission_antenna_succeeded);
    };
*/
/*
 *  Enemy Chopper
 *  Reward: the chopper
 *  Failure: the chopper is ready for combat
 */

    class chopper : __base {
        conditiontype = "oneCounter";
        class location : location {
            radius = 8000;
        };
        class defence {
            target = "composition";
            composition_types[] = {"chopper"};
        };
        spawndelay = 650;
        probability = 0.2;
        timeout = 900;
        onFailed = QFUNC(sidemission_chopper_failed);
        onTimeout = QFUNC(sidemission_chopper_failed);
    };

};
