#define CBA_OFF
#include "script_component.hpp"
#define TASK_DESC(VAR) class VAR { \
    description = CSTRING(TRIPLES(NEW,VAR,desc)); \
    title = CSTRING(TRIPLES(NEW,VAR,title)); \
    marker = ""; \
    tasktype = QUOTE(VAR); \
}

#define TASK_DESC2(VAR,VAR2) class VAR { \
    description = CSTRING(TRIPLES(NEW,VAR,desc)); \
    title = CSTRING(TRIPLES(NEW,VAR,title)); \
    marker = ""; \
    tasktype = QUOTE(VAR2); \
}


class CfgTaskDescriptions {
    TASK_DESC2(capture,target);
    TASK_DESC2(scarab,kill);
    TASK_DESC2(device,interact);
    class emp : device {};
    /*
    TASK_DESC2(emp,interact);
    */
    TASK_DESC2(hostage,heal);
    TASK_DESC2(intel,download);
    TASK_DESC2(prototype,Default);
    TASK_DESC2(tower,destroy);
    TASK_DESC2(wpncache,destroy);

    TASK_DESC2(rtb,run);
    
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