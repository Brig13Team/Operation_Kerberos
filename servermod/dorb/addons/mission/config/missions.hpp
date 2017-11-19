#include "script_component.hpp"
/**
 *
 * Author: Dorbedo
 * the missionconfig
 *
 */

#define PROPABILITY_LAND 0.5/7
#define PROPABILITY_TOWN 0.5/5

class baseMission {
    // condition for the task - e.g. need specific mod
    taskcondition = "";
    // chance to spawn the mission
    probability = 1;
    // possible armys for this mission - see component spawn
    armys[] = {
        {"guards",1}, // mainly infanterie with some light vehicles
        {"infanterie",1}, // infanterie with some medium vehicles
        {"armored",1}, // tanks,
        {"airborne",1}, // infanterie with heavy airsupport
        {"specops",1} // skilled infanterie with some specials
    };

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

    class task_west {
        delay = 0;  // delay for the task to be displayed, can be string or number

        title = LSTRING(baseMission_title);   // LSTRING is used to just use the cfg
        description = LSTRING(baseMission_description);
        tasktype = "";

        onSucceeded = LSTRING(baseMission_succeeded);
        onFailed = LSTRING(baseMission_failed);
        onNeutral = LSTRING(baseMission_neutral);

        showMarker = 1; // show the missionmarker on spot
    };

    class task_east : task_west {};
    class task_independent : task_west {};
    class task_civilian : task_independent {};

    class condition {
        // conditionfunction
        conditiontype = "counter";
        timeout = 0; // timeout if needed

        // completion functions
        onSucceeded = "";
        onFailed = "";
        onNeutral = "";
        onTimeout = "";
    };
};

class capture : baseMission {
    probability = PROPABILITY_TOWN;
    armys[] = {{"guards", 1}, {"infanterie", 1}, {"armored", 1}, {"airborne", 1}};
    class position : position {
        locationtypes[] = {QGVAR(town)};
        radius = 200;
    };
    class objective : objective {
        target = "house";
        objects = "officer";
        amount[] = {1,3};
        objectsfunction = QFUNC(mission_capture);
    };
    class task_west {
        title = ELSTRING(mission,capture_title_west);
        description = ELSTRING(mission,capture_desc_west);
        onSucceeded = ELSTRING(mission,capture_succeeded_west);
        onFailed = ELSTRING(mission,capture_failed_west);
        onNeutral = ELSTRING(mission,capture_neutral_west);
        tasktype = "target";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,capture_title_independent);
        description = ELSTRING(mission,capture_desc_independent);
        onSucceeded = ELSTRING(mission,capture_succeeded_independent);
        onFailed = ELSTRING(mission,capture_failed_independent);
        onNeutral = ELSTRING(mission,capture_neutral_independent);
        tasktype = "target";
    };
};

class hostage : capture {
    probability = PROPABILITY_TOWN;
    class objective : objective {
        objects = "hostage";
        amount[] = {2,4};
        objectsfunction = QFUNC(mainmission_hostage);
    };
    class task_west {
        title = ELSTRING(mission,hostage_title_independent);
        description = ELSTRING(mission,hostage_desc_independent);
        onSucceeded = ELSTRING(mission,hostage_succeeded_independent);
        onFailed = ELSTRING(mission,hostage_failed_independent);
        onNeutral = ELSTRING(mission,hostage_neutral_independent);
        tasktype = "heal";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,hostage_title_independent);
        description = ELSTRING(mission,hostage_desc_independent);
        onSucceeded = ELSTRING(mission,hostage_succeeded_independent);
        onFailed = ELSTRING(mission,hostage_failed_independent);
        onNeutral = ELSTRING(mission,hostage_neutral_independent);
        tasktype = "heal";
    };
};

class intel : capture {
    probability = PROPABILITY_TOWN;
    class objective : objective {
        objects = "intel";
        amount[] = {2,6};
        objectsfunction = QFUNC(mainmission_intel);
    };
    class task_west {
        title = ELSTRING(mission,intel_title_independent);
        description = ELSTRING(mission,intel_desc_independent);
        onSucceeded = ELSTRING(mission,intel_succeeded_independent);
        onFailed = ELSTRING(mission,intel_failed_independent);
        onNeutral = ELSTRING(mission,intel_neutral_independent);
        tasktype = "download";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,intel_title_independent);
        description = ELSTRING(mission,intel_desc_independent);
        onSucceeded = ELSTRING(mission,intel_succeeded_independent);
        onFailed = ELSTRING(mission,intel_failed_independent);
        onNeutral = ELSTRING(mission,intel_neutral_independent);
        tasktype = "download";
    };
};

class upload : intel {
    probability = PROPABILITY_TOWN;
    class objective : objective {
        objects = "upload";
        amount = 1;
        objectsfunction = QFUNC(mainmission_upload);
    };
    class task_west {
        title = ELSTRING(mission,upload_title_independent);
        description = ELSTRING(mission,upload_desc_independent);
        onSucceeded = ELSTRING(mission,upload_succeeded_independent);
        onFailed = ELSTRING(mission,upload_failed_independent);
        onNeutral = ELSTRING(mission,upload_neutral_independent);
        tasktype = "upload";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,upload_title_independent);
        description = ELSTRING(mission,upload_desc_independent);
        onSucceeded = ELSTRING(mission,upload_succeeded_independent);
        onFailed = ELSTRING(mission,upload_failed_independent);
        onNeutral = ELSTRING(mission,upload_neutral_independent);
        tasktype = "upload";
    };
};

class weaponcache : intel {
    probability = PROPABILITY_TOWN;
    class objective : objective {
        objects = "weaponcache";
        amount[] = {5,8};
        objectsfunction = QFUNC(mainmission_weaponcache);
    };
    class task_west {
        title = ELSTRING(mission,weaponcache_title_independent);
        description = ELSTRING(mission,weaponcache_desc_independent);
        onSucceeded = ELSTRING(mission,weaponcache_succeeded_independent);
        onFailed = ELSTRING(mission,weaponcache_failed_independent);
        onNeutral = ELSTRING(mission,weaponcache_neutral_independent);
        tasktype = "upload";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,weaponcache_title_independent);
        description = ELSTRING(mission,weaponcache_desc_independent);
        onSucceeded = ELSTRING(mission,weaponcache_succeeded_independent);
        onFailed = ELSTRING(mission,weaponcache_failed_independent);
        onNeutral = ELSTRING(mission,weaponcache_neutral_independent);
        tasktype = "upload";
    };
};
