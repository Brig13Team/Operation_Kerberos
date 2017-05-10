/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the taskhandler statemachine
 *
 */
#include "script_component.hpp"


class GVAR(statemachine_Taskmanager) {

    list = QUOTE(missionnamespace getVariable [ARR_2(QGVAR(missions),[])]);
    skipNull = 1;

    class initial {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
        class isMainMission {
            targetState = "Spawn";
            condition = "isNull(_this getVariable ['parent',locationNull])";
            onTransition = QFUNC(statemachine_chooseMain);
        };
        class isSideMission {
            targetState = "Spawn";
            condition = "true";
            onTransition = "";
        };
    };

    class oneCounter {
        onState = QFUNC(CheckOneCounter);
        onStateEntered = "_this setvariable ['progress','none']";
        onStateLeaving = "";
        class success {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='success'";
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

    class twoCounter {
        // check the counter, it will set the progress directly onto the mission
        onState = QFUNC(CheckTwoCounter);
        onStateEntered = "_this setvariable ['progress','none']";
        onStateLeaving = "";
        // the possible mission endings, it's needed to create 3 transitions, to define the ending for endmission
        // the mission was a complete success
        class success {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='success'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        // you have failed the mission
        class failed {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='failed'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        // the mission is not won, but not lost either. like you have killed half of the hostages
        class neutral {
            targetState = "endmission";
            condition = "(_this getvariable ['progress','none'])=='neutral'";
            onTransition = QFUNC(statemachine_onTransition);
        };
        // the mission failed through a timeout
        class timeout {
            targetState = "endmission";
            condition = "(_this getvariable ['timeout',1E20])<CBA_missiontime";
            onTransition = QFUNC(statemachine_onTransition);
        };
        // this state is used to cancel the mission without any messages
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
            condition = "!(isNull(_this getVariable ['parent',locationNull]))";
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
        /*nothing happens here*/
        onStateEntered = QUOTE(HASH_DELETE(_this));
    };

    // return with all units into the base
    class RTB {
        onState = "";
        // add the rtb task and show the message
        onStateEntered = QFUNC(statemachine_rtb);
        onStateLeaving = "";
        class success {
            // we want to cleanup, after the units are back in base
            targetState = "cleanup"
            // check inf the units are all back to base
            condition = QUOTE({_x distance2D (getMarkerPos GVARMAIN(respawnmarker)) > 200} count ([] call CBA_fnc_players) == 0);
            // mark the task as finished and display the message
            onTransition = QFUNC(statemachine_rtb);
        };
    };

    // cleanup the mainMission
    class cleanup {
        onState = "";
        onStateEntered = QEFUNC(statemachine_cleanup);
        onStateLeaving = "";
        class newtask {
            // the mission is not needed anymore, it can be dumped
            targetState = "dump";
            // wait until everything is cleaned up
            condition = QUOTE(!(missionNamespace getVariable [QEGVAR(spawn,cleaningUp),true]));
            // create a new blank Mission
            onTransition = QUOTE(GVAR(Missions) pushBack HASH_CREATE);
        };
    };

    class spawn {
        onState = "";
        onStateEntered = QEFUNC(statemachine_spawn);
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
            onTransition = QFUNC(statemachine_addSide);
        };
        class timeout {
            targetState = "error";
            condition = "(_this getvariable ['spawntimeout',1E20])<CBA_missiontime";
            onTransition = "";
        };
    };

    class addTask {
        onState = "";
        onStateEntered = QEFUNC(statemachine_addTask);
        onStateLeaving = "";
        class twoCounter {
            targetState = "twoCounter";
            condition = "(_this getVariable ['conditiontype','none']) == 'twoCounter'";
            onTransition = QFUNC(statemachine_inittwoCounter);
        };
        class oneCounter {
            targetState = "oneCounter";
            condition = "(_this getVariable ['conditiontype','none']) == 'oneCounter'";
            onTransition = QFUNC(statemachine_initOneCounter);
        };
        class hold {
            // a hold mission is just some kind of oneCounter, but with another init
            targetState = "oneCounter";
            condition = "(_this getVariable ['conditiontype','none']) == 'hold'";
            onTransition = QFUNC(statemachine_initHold);
        };
        // the provided conditiotype is not supported
        class errorout {
            targetState = "error"
            condition = "true";
            onTransition = "";
        };
    };

    class error {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
        // if its a sidemission do nothing
        class isSideMission {
            targetState = "dump";
            condition = "!(isNull(_this getVariable ['parent',locationNull]))";
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
