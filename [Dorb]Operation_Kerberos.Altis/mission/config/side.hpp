/*
 *  Author: Dorbedo
 *
 *  Description:
 *      sidemissions
 *
 */
#define CBA_OFF
#include "script_component.hpp"
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
        target = "";
        objects = "radar";
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
        target = "composition";
        composition_types[] = {"artillery"};
        amount[] = {3,3};
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
        title = LSTRING(side_artillery_title);
        description = LSTRING(side_artillery_desc);
        onSucceeded = LSTRING(side_artillery_succeeded);
        tasktype = "kill";
    };
    class condition : condition {
        timeout = 1200;
        onFailed = QFUNC(sidemission_chopper_failed);
        onTimeout = QFUNC(sidemission_chopper_failed);
    };
};
