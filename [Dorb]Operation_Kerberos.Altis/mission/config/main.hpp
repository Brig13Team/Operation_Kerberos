/*
 *  Author: Dorbedo
 *
 *  Description:
 *      mainmissions
 *
 */
#include "script_component.hpp"
/*
class baseMission {
    condition = "";
    probability = 1;
    armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"specops",1}, {"droneoperations",1}, {"guards",1}};
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

class capture : baseMainmission {
    armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1},{"guards",1}};
    class position : position {
        locationtypes[] = {QGVAR(town)};
        radius = 200;
    };
    class objective : objective {
        target = "house";
        objects = "officer";
        amount[] = {1,3};
        objectsfunction = QFUNC(mainmission_capture);
    };
    class task : task {
        title = LSTRING(main_capture_title);
        description = LSTRING(main_capture_desc);
        onSucceeded = LSTRING(main_capture_succeeded);
        onFailed = LSTRING(main_capture_failed);
        onNeutral = LSTRING(main_capture_neutral);
    };
};

class hostage : capture {
    class objective : objective {
        objects = "hostage";
        amount[] = {2,4};
        objectsfunction = QFUNC(mainmission_hostage);
    };
    class task : task {
        title = LSTRING(main_hostage_title);
        description = LSTRING(main_hostage_desc);
        onSucceeded = LSTRING(main_hostage_succeeded);
        onFailed = LSTRING(main_hostage_failed);
        onNeutral = LSTRING(main_hostage_neutral);
    };
};

class intel : capture {
    class objective : objective {
        objects = "intel";
        amount[] = {2,6};
        objectsfunction = QFUNC(mainmission_intel);
    };
    class task : task {
        title = LSTRING(main_intel_title);
        description = LSTRING(main_intel_desc);
        onSucceeded = LSTRING(main_intel_succeeded);
        onFailed = "";
        onNeutral = "";
    };
};

class upload : intel {
    class objective : objective {
        objects = "upload";
        amount = 1;
        objectsfunction = QFUNC(mainmission_upload);
    };
    class task : task {
        title = LSTRING(main_upload_title);
        description = LSTRING(main_upload_desc);
        onSucceeded = LSTRING(main_upload_succeeded);
    };
};

class weaponcache : intel {
    class objective : objective {
        objects = "weaponcache";
        amount[] = {5,8};
        objectsfunction = QFUNC(mainmission_weaponcache);
    };
    class task : task {
        title = LSTRING(main_weaponcache_title);
        description = LSTRING(main_weaponcache_desc);
        onSucceeded = LSTRING(main_weaponcache_succeeded);
    };
};

class device : baseMainmission {
    armys[] = {{"regular",1}, {"armored",1}, {"infanterie",1}, {"airborne",1}, {"specops",1}, {"droneoperations",1}, {"guards",1}};
    class position : position {
        locationtypes[] = {QGVAR(industrie), QGVAR(military), QGVAR(other)};
        radius = 800;
    };
    class objective : objective {
        target = "composition";
        composition_types[] = {"isObjective","device"};
        objects = "device";
        objectsfunction = QFUNC(mainmission_device);
    };
    class task : task {
        title = LSTRING(main_device_title);
        description = LSTRING(main_device_desc);
        onSucceeded = LSTRING(main_device_succeeded);
        onNeutral = LSTRING(main_device_neutral);
    };
};

class emp : device {
    class objective : objective {
        objects = "emp";
        amount = 1;
        objectsfunction = QFUNC(mainmission_emp);
    };
    class task : task {
        title = LSTRING(main_emp_title);
        description = LSTRING(main_emp_desc);
        onSucceeded = LSTRING(main_emp_succeeded);
        onFailed = "";
        onNeutral = LSTRING(main_emp_neutral);
    };
};

class dronecommando : device {
    armys[] = {{"droneoperations",1}};
    class objective : objective {
        objects = "dronecommando";
        amount = 1;
        objectsfunction = QFUNC(mainmission_dronecommando);
    };
    class task : task {
        title = LSTRING(main_dronecommando_title);
        description = LSTRING(main_dronecommando_desc);
        onSucceeded = LSTRING(main_dronecommando_succeeded);
        onFailed = "";
        onNeutral = "";
    };
};

class prototype : device {
    class objective : objective {
        objects = "prototype";
        amount = 1;
        objectsfunction = QFUNC(mainmission_prototype);
    };
    class task : task {
        title = LSTRING(main_prototype_title);
        description = LSTRING(main_prototype_desc);
        onSucceeded = LSTRING(main_prototype_succeeded);
        onFailed = LSTRING(main_prototype_failed);
        onNeutral = "";
    };
};

class jammer : device {
    class position : position {
        radius = 1200;
    };
    class objective : objective {
        objects = "jammer";
        amount[] = {1,3};
        objectsfunction = QFUNC(mainmission_jammer);
    };
    class task : task {
        title = LSTRING(main_jammer_title);
        description = LSTRING(main_jammer_desc);
        onSucceeded = LSTRING(main_jammer_succeeded);
        onFailed = "";
        onNeutral = "";
    };
};

class radiotower : jammer {
    class objective : objective {
        objects = "radiotower";
        amount[] = {1,3};
        objectsfunction = QFUNC(mainmission_radiotower);
    };
    class task : task {
        title = LSTRING(main_radiotower_title);
        description = LSTRING(main_radiotower_desc);
        onSucceeded = LSTRING(main_radiotower_succeeded);
        onFailed = "";
        onNeutral = "";
    };
};
/*
class scarab : device {
    class objective : objective {
        objects = "scarab";
        amount[] = {1,3};
        objectsfunction = QFUNC(mainmission_scarab);
    };
    class task : task {
        title = LSTRING(main_scarab_title);
        description = LSTRING(main_scarab_desc);
        onSucceeded = LSTRING(main_scarab_succeeded);
        onFailed = LSTRING(main_scarab_failed);
        onNeutral = "";
    };
};
*/
