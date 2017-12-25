/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the taskhandler statemachine
 *
 */

class GVAR(statemachine_Taskmanager) {

    list = QUOTE([false] call FUNC(statemachine_getAllMissions));
    skipNull = 1;

    class initial {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
        class isMainMission {
            targetState = "spawn";
            condition = "true";
            onTransition = QFUNC(statemachine_createMission);
        };
    };

    class spawn {
        onState = "";
        onStateEntered = QFUNC(statemachine_spawnMission);
        onStateLeaving = "";
        class cancel {
            // prevent the spawning, if the was an exit forced
            targetState = "dump";
            condition = "(_this getvariable ['progress','none'])=='cancel'";
            onTransition = "";
        };
        class spawncomplete {
            targetState = "addTask";
            condition = "_this getVariable ['spawningfinished',false]";
            onTransition = "";
        };
        class timeout {
            targetState = "error";
            condition = "(_this getvariable ['spawntimeout',1E20])<CBA_missiontime";
            onTransition = "";
        };
    };

    class addTask {
        onState = "";
        onStateEntered = QFUNC(statemachine_addTask);
        onStateLeaving = "";
        // this transition is used to define some precondition, wich have to be reached before the check can be performed
        class delayCondition {
            targetState = "delayCheck";
            condition = "(_this getvariable ['delaycheck',0])>0";
            onTransition = "";
        };
        class tocounter {
            targetState = "counter";
            condition = "(_this getVariable ['conditiontype','none']) == 'counter'";
            onTransition = QFUNC(statemachine_initcounter);
        };
        class toclear {
            targetState = "clear";
            condition = "(_this getVariable ['conditiontype','none']) == 'clear'";
            onTransition = QFUNC(statemachine_initclear);
        };
        // the provided conditiotype is not supported
        class errorout {
            targetState = "error";
            condition = "true";
            onTransition = "";
        };
    };

    class addSpawnDelay {
        onState = "";
        onStateEntered = "_this setVariable ['delayend',CBA_missiontime + (_this getVariable 'spawndelay')]";
        onStateLeaving = "";
        class cancel {
            targetState = "dump";
            condition = "(_this getvariable ['progress','none'])=='cancel'";
            onTransition = "";
        };
        class spawn {
            targetState = "spawn";
            condition = "(_this getvariable ['delayend',-1])<CBA_missiontime";
            onTransition = "";
        };
    };

    class counter {
        onState = QFUNC(statemachine_checkCounter);
        onStateEntered = "_this setvariable ['progress','none']";
        onStateLeaving = "";
        class succeeded {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='succeeded'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class failed {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='failed'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class neutral {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='neutral'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class timeout {
            targetState = "endmission";
            condition = "(_this getvariable ['timeout',1E20])<CBA_missiontime";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class cancel {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='cancel'";
            onTransition = QFUNC(statemachine_onTransition);
        };
    };

    class clear {
        onState = QFUNC(statemachine_checkclear);
        onStateEntered = "_this setvariable ['progress','none']";
        onStateLeaving = "";
        class succeeded {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='succeeded'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class failed {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='failed'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class neutral {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='neutral'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class timeout {
            targetState = "endmission";
            condition = "(_this getvariable ['timeout',1E20])<CBA_missiontime";
            onTransition = QFUNC(statemachine_onTransition);
        };
        class cancel {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='cancel'";
            onTransition = QFUNC(statemachine_onTransition);
        };
    };

    // the mission has been ended
    class endmission {
        onState = "";
        // set the rask as fullfilled and end the mission
        onStateEntered = QFUNC(statemachine_endmission);
        onStateLeaving = "";
        // if its a sidemission do nothing
        class isSideMission {
            targetState = "dump";
            condition = "!(_this getVariable ['isMain',true])";
            onTransition = "";
        };
        // create the rtb task, if it's a mainmission
        class toRTB {
            targetState = "RTB";
            condition = "true";
            onTransition = QFUNC(statemachine_cancelALL);
        };
    };

    class dump {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
    };

    // cleanup the mainMission
    class cleanup {
        onState = "";
        onStateEntered = QFUNC(statemachine_cleanup);
        onStateLeaving = "";
        class newtask {
            // the mission is not needed anymore, it can be dumped
            targetState = "dump";
            // wait until everything is cleaned up
            condition = QUOTE(!(missionNamespace getVariable [ARR_2('EGVAR(spawn,cleaningUp)',true)]));
            // create a new blank Mission
            onTransition = QUOTE((GVAR(Missions)) pushBack HASH_CREATE;);
        };
    };

    class delayCheck {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
        class twoCounter {
            targetState = "twoCounter";
            condition = "((_this getvariable ['delaycheck',0])<CBA_missiontime)&&{(_this getVariable ['conditiontype','none']) == 'twoCounter'}";
            onTransition = QFUNC(statemachine_inittwoCounter);
        };
        class oneCounter {
            targetState = "oneCounter";
            condition = "((_this getvariable ['delaycheck',0])<CBA_missiontime)&&{(_this getVariable ['conditiontype','none']) == 'oneCounter'}";
            onTransition = QFUNC(statemachine_initOneCounter);
        };
        class hold {
            targetState = "oneCounter";
            condition = "((_this getvariable ['delaycheck',0])<CBA_missiontime)&&{(_this getVariable ['conditiontype','none']) == 'hold'}";
            onTransition = QFUNC(statemachine_initHold);
        };
    };

    class error {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
        // if its a sidemission do nothing
        class isSideMission {
            targetState = "dump";
            condition = "!(_this getVariable ['isMain',true])";
            onTransition = "";
        };
        // if the mainmission errors, we have to cancel the mission
        class cancelall {
            targetState = "dump";
            condition = "true";
            onTransition = QFUNC(statemachine_cancelALL);
        };
    };
};
