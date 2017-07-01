#include "statemachine.hpp"

class baseMission {
    // condition for the task - e.g. need specific mod
    taskcondition = "";
    // chance to spawn the mission
    probability = 1;
    // possible armys for this mission
    armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"specops",1}, /*{"droneoperations",1},*/ {"guards",1}};

    class position {
        // locationtypes for the mission to be spawned inside
        locationtypes[] = {QGVAR(town), QGVAR(industrie), QGVAR(military), QGVAR(other)};
        // radius around the locations
        radius = 500;
    };

    class objective {
        delay = 0; // delay for the spawn to be executed, can be string or number
        // special spawnfunction, if defined, this one is used
        spawnfunction = "";

        // if you don't use a special spawnfunction, you can spawn the target inside a composition
        target = "";    // possible values: composition, house
        // the possible compositiontypes
        composition_types[] = {"isObjective"};
        house_types[] = {"hasmissiontarget"};

        objects = ""; //the objecttype defined inside unitlists
        amount = 1; //the amount, [min,max];
        //amount[] = {1,5};
        objectsfunction = ""; // the function called after the objects have been spawned
    };

    class task {
        delay = 0;  // delay for the task to be displayed, can be string or number

        title = LSTRING(baseMission_title);   // LSTRING is used to just use the cfg
        description = LSTRING(baseMission_description);
        tasktype = "";

        onSucceeded = LSTRING(baseMission_success);
        onFailed = LSTRING(baseMission_failed);
        onNeutral = LSTRING(baseMission_neutral);

        showMarker = 1; // show the missionmarker on spot
    };

    class condition {
        // conditionfunction
        conditiontype = "counter";
        timeout = 0; // timeout if needed

        // completion functions
        onSucceeded = "";
        onFailed = "";
        onNeutral = "";
    };

};

class baseMainmission : baseMission {
    class side {
        min = 1;
        max = 3;
        sidemissions[] = {"%ALL"}; // sidemissionWildcard
    };
};
class baseSidemission : baseMission {
    class position : position {
        // the possible locations, if none defined, the mainlocation is used
        areas[] = {};
        // the min/max distance of the location to choose, if negative, the condition is ignored
        minDistance = -1;
        maxDistance = -1;
        // the radius around the location
        radius = 500;
    };
};

class mainmissions {
    #include "main.hpp"
};
class sidemissions {
    #include "side.hpp"
};
