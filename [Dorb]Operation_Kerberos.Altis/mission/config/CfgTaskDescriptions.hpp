#define CBA_OFF
#include "script_component.hpp"
#define TASK_DESC(VAR) class VAR { \
    description = CSTRING(DOUBLES(VAR,DESC)); \
    title = CSTRING(DOUBLES(VAR,TITLE)); \
    marker = ""; \
    tasktype = QUOTE(VAR); \
}

#define TASK_DESC2(VAR,VAR2) class VAR { \
    description = CSTRING(DOUBLES(VAR,DESC)); \
    title = CSTRING(DOUBLES(VAR,TITLE)); \
    marker = ""; \
    tasktype = QUOTE(VAR2); \
}


class CfgTaskDescriptions {
    // mainmissions
    TASK_DESC2(intel,download);
    TASK_DESC2(weaponcache,destroy);
    TASK_DESC2(device,interact);
    TASK_DESC2(emp,interact);
    TASK_DESC2(hostage,heal);
    TASK_DESC2(clear,target);
    TASK_DESC2(capture,target);
    TASK_DESC2(scarab,kill);
    TASK_DESC2(radiotower,destroy);
    TASK_DESC2(dronecommando,destroy);
    TASK_DESC2(prototype,Default);
    TASK_DESC2(specops,target);

    // sidemissions
    TASK_DESC2(artillery,target);
    TASK_DESC2(ugv,target);
    TASK_DESC2(convoi,target);
    TASK_DESC2(radar,target);

    class _rtb {
        title = "STR_DORB_MISSION_RTB";
        description = "STR_DORB_MISSION_RTB_START_1";
        marker = "";
        tasktype = "run";
    };

    // Vanilla
    TASK_DESC(armor);
    TASK_DESC(attack);
    TASK_DESC(Default);
    TASK_DESC(defend);
    TASK_DESC(destroy);
    TASK_DESC(download);
    TASK_DESC(exit);
    TASK_DESC(heal);
    TASK_DESC(interact);
    // TASK_DESC(intel);
    TASK_DESC(kill);
    TASK_DESC(map);
    TASK_DESC(meet);
    TASK_DESC(move);
    TASK_DESC(move1);
    TASK_DESC(move2);
    TASK_DESC(move3);
    TASK_DESC(move4);
    TASK_DESC(move5);
    TASK_DESC(navigate);
    TASK_DESC(radio);
    TASK_DESC(rearm);
    TASK_DESC(refuel);
    TASK_DESC(repair);
    TASK_DESC(rifle);
    TASK_DESC(run);
    TASK_DESC(scout);
    TASK_DESC(search);
    TASK_DESC(talk);
    TASK_DESC(talk1);
    TASK_DESC(talk2);
    TASK_DESC(talk3);
    TASK_DESC(talk4);
    TASK_DESC(talk5);
    TASK_DESC(target);
    TASK_DESC(upload);
    TASK_DESC(walk);
    TASK_DESC(whiteboard);
};
