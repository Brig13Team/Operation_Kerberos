/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sidemissions
 *
 */

/*
class baseMission {
    condition = "";
    probability = 1;
    class position {
        locationtypes[] = {QGVAR(town), QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 500;
    };
    class objective {
        delay = 0;
        spawnfunction = "";
        target = "";
        composition_types[] = {"isObjective"};
        house_types[] = {"hasmissiontarget"};
        objects = "";
        objectsfunction = "";
    };
    class task {
        delay = 0;
        title = LSTRING(baseMission_title);
        description = LSTRING(baseMission_description);
        tasktype = "";
        showMarker = 1;

        onSucceeded = "";
        onFailed = "";
        onNeutral = "";
    };
    class condition {
        conditiontype = "counter";
        onSucceeded = "";
        onFailed = "";
        onNeutral = "";
    };
};
*/

class radar : basesidemission {
    class position : position {
        locationtypes[] = {};
        radius = 500;
    };
    class objective : objective {
        newComposition = 1;
        target = "composition";
        composition_types[] = {"radar"};
        amount = 1;
        objectsfunction = QFUNC(sidemission_radar);
    };
    class task : task {
        title = LSTRING(side_radar_title);
        description = LSTRING(side_radar_desc);
        onSucceeded = LSTRING(side_radar_succeeded);
        showMarker = 0;
        tasktype = "target";
    };
};

class artillery : radar {
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        minDistance = 5000;
        maxDistance = 9000;
    };
    class objective : objective {
        newComposition = 1;
        target = "composition";
        composition_types[] = {"artillery"};
        amount = 1;
        objectsfunction = QFUNC(sidemission_artillery);
    };
    class task : task {
        title = LSTRING(side_artillery_title);
        description = LSTRING(side_artillery_desc);
        onSucceeded = LSTRING(side_artillery_succeeded);
        tasktype = "destroy";
    };
};


class chopper : radar {
    probability = 0.2;
    class position : position {
        radius = 8000;
    };
    class objective : objective {
        delay = 650;
        target = "composition";
        composition_types[] = {"chopper"};
        amount = 1;
        objectsfunction = QFUNC(sidemission_chopper);
    };
    class task : task {
        title = LSTRING(side_chopper_title);
        description = LSTRING(side_chopper_desc);
        onSucceeded = LSTRING(side_chopper_succeeded);
        tasktype = "kill";
    };
    class condition : condition {
        timeout = 1200;
        onFailed = QFUNC(sidemission_chopper_failed);
        onTimeout = QFUNC(sidemission_chopper_failed);
    };
};

class airsuperiority : radar {
    class position : position {
        locationtypes[] = {};
        radius = 100;
    };
    class objective : objective {
        spawnfunction = QFUNC(spawnfunctions_airsuperiority);
        objectsfunction = QFUNC(sidemission_airsuperiority);
    };
    class task : task {
        title = LSTRING(side_airsuperiority_title);
        description = LSTRING(side_airsuperiority_desc);
        onSucceeded = LSTRING(side_airsuperiority_succeeded);
        showMarker = 0;
        tasktype = "target";
    };
};

class minefield : radar {
    probability = 0.1;
    class position : position {
        locationtypes[] = {QGVAR(other)};
        radius = 100;
    };
    class objective : objective {
        spawnfunction = QFUNC(spawnfunctions_minefield);
        objectsfunction = "";
    };
    class task : task {
        title = LSTRING(side_minefield_title);
        description = LSTRING(side_minefield_desc);
        onSucceeded = LSTRING(side_minefield_succeeded);
        showMarker = 1;
        tasktype = "map";
    };
    class condition : condition {
        conditiontype = "clear";
    };
};
