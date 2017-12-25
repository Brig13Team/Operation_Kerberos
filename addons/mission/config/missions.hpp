class baseMission {
    // the condition for the task to be created e.g. special mod requirements
    taskcondition = "";
    probability = 1;
    class position {
        locationtypes[] = {QGVAR(town), QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 500;
    };
    class objective {
        // special spawnfunction
        spawnfunction = "";

        // if spawnfunctions is not defined, use composition
        isHouse = 0;
        compositiontypes[] = {"isObjective"};
        housetypes[] = {"isObjective"};
        objects = "";
        amount = 1; //the amount, [min,max];

        // special
        objectsfunction = "";
    };
    class condition {
        conditiontype = "";
        timeout = 0;
        onSucceed = "";
        onFailed = "";
        onNeutral = "";
        onTimeout = "";
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

class device : baseMainmission {
    probability = PROPABILITY_LAND;
    armys[] = {{"guards", 1}, {"infanterie", 1}, {"armored", 1}, {"airborne", 1}, {"specops", 1}};
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 800;
    };
    class objective : objective {
        target = "composition";
        composition_types[] = {"isobjective","device"};
        objects = "device";
        objectsfunction = QFUNC(mainmission_device);
    };
    class task_west {
        title = ELSTRING(mission,device_title_independent);
        description = ELSTRING(mission,device_desc_independent);
        onSucceeded = ELSTRING(mission,device_succeeded_independent);
        onFailed = ELSTRING(mission,device_failed_independent);
        onNeutral = ELSTRING(mission,device_neutral_independent);
        tasktype = "interact";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,device_title_independent);
        description = ELSTRING(mission,device_desc_independent);
        onSucceeded = ELSTRING(mission,device_succeeded_independent);
        onFailed = ELSTRING(mission,device_failed_independent);
        onNeutral = ELSTRING(mission,device_neutral_independent);
        tasktype = "interact";
    };
};

class emp : device {
    probability = PROPABILITY_LAND;
    armys[] = {{"guards", 1}, {"infanterie", 1}, {"specops", 1}};
    class objective : objective {
        composition_types[] = {"isobjective","emp"};
        objects = "emp";
        amount = 1;
        objectsfunction = QFUNC(mainmission_emp);
    };
    class task_west {
        title = ELSTRING(mission,emp_title_independent);
        description = ELSTRING(mission,emp_desc_independent);
        onSucceeded = ELSTRING(mission,emp_succeeded_independent);
        onFailed = ELSTRING(mission,emp_failed_independent);
        onNeutral = ELSTRING(mission,emp_neutral_independent);
        tasktype = "interact";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,emp_title_independent);
        description = ELSTRING(mission,emp_desc_independent);
        onSucceeded = ELSTRING(mission,emp_succeeded_independent);
        onFailed = ELSTRING(mission,emp_failed_independent);
        onNeutral = ELSTRING(mission,emp_neutral_independent);
        tasktype = "interact";
    };
};

class dronecommando : device {
    probability = PROPABILITY_LAND;
    armys[] = {{"specops", 1}};
    class objective : objective {
        objects = "dronecommando";
        composition_types[] = {"dronecommando"};
        amount = 1;
        objectsfunction = QFUNC(mainmission_dronecommando);
    };
    class task_west {
        title = ELSTRING(mission,dronecommando_title_independent);
        description = ELSTRING(mission,dronecommando_desc_independent);
        onSucceeded = ELSTRING(mission,dronecommando_succeeded_independent);
        onFailed = ELSTRING(mission,dronecommando_failed_independent);
        onNeutral = ELSTRING(mission,dronecommando_neutral_independent);
        tasktype = "destroy";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,dronecommando_title_independent);
        description = ELSTRING(mission,dronecommando_desc_independent);
        onSucceeded = ELSTRING(mission,dronecommando_succeeded_independent);
        onFailed = ELSTRING(mission,dronecommando_failed_independent);
        onNeutral = ELSTRING(mission,dronecommando_neutral_independent);
        tasktype = "destroy";
    };
};

class prototype : device {
    probability = PROPABILITY_LAND;
    class objective : objective {
        objects = "prototype";
        composition_types[] = {"isobjective","prototype"};
        amount = 1;
        objectsfunction = QFUNC(mainmission_prototype);
    };
    class task_west {
        title = ELSTRING(mission,prototype_title_independent);
        description = ELSTRING(mission,prototype_desc_independent);
        onSucceeded = ELSTRING(mission,prototype_succeeded_independent);
        onFailed = ELSTRING(mission,prototype_failed_independent);
        onNeutral = ELSTRING(mission,prototype_neutral_independent);
        tasktype = "Default";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,prototype_title_independent);
        description = ELSTRING(mission,prototype_desc_independent);
        onSucceeded = ELSTRING(mission,prototype_succeeded_independent);
        onFailed = ELSTRING(mission,prototype_failed_independent);
        onNeutral = ELSTRING(mission,prototype_neutral_independent);
        tasktype = "Default";
    };
};

class jammer : device {
    condition = "";
    probability = PROPABILITY_LAND;
    class position : position {
        radius = 1200;
    };
    class objective : objective {
        objects = "jammer";
        composition_types[] = {"isobjective","jammer"};
        amount[] = {1,3};
        objectsfunction = QFUNC(mainmission_jammer);
    };
    class task_west {
        title = ELSTRING(mission,jammer_title_independent);
        description = ELSTRING(mission,jammer_desc_independent);
        onSucceeded = ELSTRING(mission,jammer_succeeded_independent);
        onFailed = ELSTRING(mission,jammer_failed_independent);
        onNeutral = ELSTRING(mission,jammer_neutral_independent);
        tasktype = "destroy";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,jammer_title_independent);
        description = ELSTRING(mission,jammer_desc_independent);
        onSucceeded = ELSTRING(mission,jammer_succeeded_independent);
        onFailed = ELSTRING(mission,jammer_failed_independent);
        onNeutral = ELSTRING(mission,jammer_neutral_independent);
        tasktype = "destroy";
    };
};

class radiotower : jammer {
    condition = "";
    probability = PROPABILITY_LAND;
    class objective : objective {
        objects = "radiotower";
        composition_types[] = {"radiotower"};
        amount[] = {1,3};
        objectsfunction = QFUNC(mainmission_radiotower);
    };
    class task_west {
        title = ELSTRING(mission,radiotower_title_independent);
        description = ELSTRING(mission,radiotower_desc_independent);
        onSucceeded = ELSTRING(mission,radiotower_succeeded_independent);
        onFailed = ELSTRING(mission,radiotower_failed_independent);
        onNeutral = ELSTRING(mission,radiotower_neutral_independent);
        tasktype = "destroy";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,radiotower_title_independent);
        description = ELSTRING(mission,radiotower_desc_independent);
        onSucceeded = ELSTRING(mission,radiotower_succeeded_independent);
        onFailed = ELSTRING(mission,radiotower_failed_independent);
        onNeutral = ELSTRING(mission,radiotower_neutral_independent);
        tasktype = "destroy";
    };
};

class scarab : device {
    probability = PROPABILITY_LAND;
    taskcondition = QUOTE(isClass(configFile>>'CfgPatches'>>'rhs_main'));
    class objective : objective {
        objects = "scarab";
        composition_types[] = {"scarab"};
        amount[] = {2,3};
        objectsfunction = QFUNC(mainmission_scarab);
    };
    class task_west {
        title = ELSTRING(mission,scarab_title_independent);
        description = ELSTRING(mission,scarab_desc_independent);
        onSucceeded = ELSTRING(mission,scarab_succeeded_independent);
        onFailed = ELSTRING(mission,scarab_failed_independent);
        onNeutral = ELSTRING(mission,scarab_neutral_independent);
        tasktype = "destroy";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,scarab_title_independent);
        description = ELSTRING(mission,scarab_desc_independent);
        onSucceeded = ELSTRING(mission,scarab_succeeded_independent);
        onFailed = ELSTRING(mission,scarab_failed_independent);
        onNeutral = ELSTRING(mission,scarab_neutral_independent);
        tasktype = "destroy";
    };
    class condition : condition {
        timeout = 5400;
        onSucceeded = QEFUNC(gui,stopTimerGlobal);
        onFailed = QFUNC(mainmission_scarab_failed);
        onNeutral = QFUNC(mainmission_scarab_failed);
        onTimeout = QFUNC(mainmission_scarab_failed);
    };
};


class radar : basesidemission {
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
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
    class task_west {
        title = ELSTRING(mission,radar_title_independent);
        description = ELSTRING(mission,radar_desc_independent);
        onSucceeded = ELSTRING(mission,radar_succeeded_independent);
        onFailed = ELSTRING(mission,radar_failed_independent);
        onNeutral = ELSTRING(mission,radar_neutral_independent);
        tasktype = "target";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,radar_title_independent);
        description = ELSTRING(mission,radar_desc_independent);
        onSucceeded = ELSTRING(mission,radar_succeeded_independent);
        onFailed = ELSTRING(mission,radar_failed_independent);
        onNeutral = ELSTRING(mission,radar_neutral_independent);
        tasktype = "target";
    };
};

class aid : basesidemission {
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(town)};
        radius = 1500;
    };
    class objective : objective {
        newComposition = 1;
        target = "composition";
        composition_types[] = {"aid"};
        amount = 1;
        objectsfunction = QFUNC(sidemission_aid);
    };
    class task_west {
        title = ELSTRING(mission,aid_title_independent);
        description = ELSTRING(mission,aid_desc_independent);
        onSucceeded = ELSTRING(mission,aid_succeeded_independent);
        onFailed = ELSTRING(mission,aid_failed_independent);
        onNeutral = ELSTRING(mission,aid_neutral_independent);
        tasktype = "heal";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,aid_title_independent);
        description = ELSTRING(mission,aid_desc_independent);
        onSucceeded = ELSTRING(mission,aid_succeeded_independent);
        onFailed = ELSTRING(mission,aid_failed_independent);
        onNeutral = ELSTRING(mission,aid_neutral_independent);
        tasktype = "heal";
    };
};

class artillery : radar {
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 500;
    };
    class objective : objective {
        newComposition = 1;
        target = "composition";
        composition_types[] = {"artillery"};
        amount = 1;
        objectsfunction = QFUNC(sidemission_artillery);
    };
    class task_west {
        title = ELSTRING(mission,artillery_title_independent);
        description = ELSTRING(mission,artillery_desc_independent);
        onSucceeded = ELSTRING(mission,artillery_succeeded_independent);
        onFailed = ELSTRING(mission,artillery_failed_independent);
        onNeutral = ELSTRING(mission,artillery_neutral_independent);
        tasktype = "destroy";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,artillery_title_independent);
        description = ELSTRING(mission,artillery_desc_independent);
        onSucceeded = ELSTRING(mission,artillery_succeeded_independent);
        onFailed = ELSTRING(mission,artillery_failed_independent);
        onNeutral = ELSTRING(mission,artillery_neutral_independent);
        tasktype = "destroy";
    };
};


class chopper : radar {
    probability = 0.2;
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 2000;
    };
    class objective : objective {
        delay = 650;
        target = "composition";
        composition_types[] = {"chopper"};
        amount = 1;
        objectsfunction = QFUNC(sidemission_chopper);
    };
    class condition : condition {
        timeout = 1200;
        onFailed = QFUNC(sidemission_chopper_failed);
        onTimeout = QFUNC(sidemission_chopper_failed);
    };
    class task_west {
        title = ELSTRING(mission,chopper_title_independent);
        description = ELSTRING(mission,chopper_desc_independent);
        onSucceeded = ELSTRING(mission,chopper_succeeded_independent);
        onFailed = ELSTRING(mission,chopper_failed_independent);
        onNeutral = ELSTRING(mission,chopper_neutral_independent);
        tasktype = "kill";
    };
    class task_east : task_west {};
    class task_independent {
        title = ELSTRING(mission,chopper_title_independent);
        description = ELSTRING(mission,chopper_desc_independent);
        onSucceeded = ELSTRING(mission,chopper_succeeded_independent);
        onFailed = ELSTRING(mission,chopper_failed_independent);
        onNeutral = ELSTRING(mission,chopper_neutral_independent);
        tasktype = "heal";
    };
};

class airsuperiority : radar {
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 100;
    };
    class objective : objective {
        spawnfunction = QFUNC(spawnfunctions_airsuperiority);
        objectsfunction = QFUNC(sidemission_airsuperiority);
    };
    class task_west {
        title = ELSTRING(mission,airsuperiority_title_independent);
        description = ELSTRING(mission,airsuperiority_desc_independent);
        onSucceeded = ELSTRING(mission,airsuperiority_succeeded_independent);
        onFailed = ELSTRING(mission,airsuperiority_failed_independent);
        onNeutral = ELSTRING(mission,airsuperiority_neutral_independent);
        tasktype = "target";
    };
    class task_east : task_west {};
    class task_independent {
        noTask = 1;
        title = ELSTRING(mission,airsuperiority_title_independent);
        description = ELSTRING(mission,airsuperiority_desc_independent);
        onSucceeded = ELSTRING(mission,airsuperiority_succeeded_independent);
        onFailed = ELSTRING(mission,airsuperiority_failed_independent);
        onNeutral = ELSTRING(mission,airsuperiority_neutral_independent);
        tasktype = "target";
    };
};

class minefield : radar {
    probability = 0.1;
    class position : position {
        locationtypes[] = {QGVAR(other)};
        radius = 600;
    };
    class objective : objective {
        spawnfunction = QFUNC(spawnfunctions_minefield);
        objectsfunction = "";
    };
    class condition : condition {
        conditiontype = "clear";
    };
    class task_west {
        title = ELSTRING(mission,minefield_title_independent);
        description = ELSTRING(mission,minefield_desc_independent);
        onSucceeded = ELSTRING(mission,minefield_succeeded_independent);
        onFailed = ELSTRING(mission,minefield_failed_independent);
        onNeutral = ELSTRING(mission,minefield_neutral_independent);
        tasktype = "map";
    };
    class task_east : task_west {};
    class task_independent {
        noTask = 1;
        title = ELSTRING(mission,minefield_title_independent);
        description = ELSTRING(mission,minefield_desc_independent);
        onSucceeded = ELSTRING(mission,minefield_succeeded_independent);
        onFailed = ELSTRING(mission,minefield_failed_independent);
        onNeutral = ELSTRING(mission,minefield_neutral_independent);
        tasktype = "map";
    };
};
