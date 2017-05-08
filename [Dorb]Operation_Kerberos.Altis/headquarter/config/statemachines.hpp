/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the statemachine for the playergroups
 *
 */
#include "script_component.hpp"


class GVAR(AIGroups_statemachine) {
    // Class properties have the same name as the corresponding function parameters
    // and code goes into strings.
    list = QFUNC(getAIGroups);
    skipNull = 1;

    class initial {
        onState = "";
        onStateEntered = "_this setVariable ['GVAR(target)',locationNull]";
        onStateLeaving = "";
        // groups patroling the outer parameter
        class toPatrol {
            targetState = "patrol";
            condition = "(_this getVariable ['GVAR(state)','none'])=='patrol'";
            onTransition = "";
        };
        // attackgroups
        class toCombat {
            targetState = "combat";
            condition = "(_this getVariable ['GVAR(state)','none'])=='combat'";
            onTransition = "";
        };
        // groups defending the POIs
        class toDefence {
            targetState = "defence";
            condition = "(_this getVariable ['GVAR(state)','none'])=='defence'";
            onTransition = "";
        };
        // static units e.g. compositions
        class toStatic {
            targetState = "static";
            condition = "(_this getVariable ['GVAR(state)','none'])=='static'";
            onTransition = "";
        };
    };


    // patrol recoursively around the Area
    class patrol {
        onState = "";
        onStateEntered = QFUNC(statemachine_patrol);
        onStateLeaving = "";
        // the grouptype has been changed due to the curcumstance, that not enaught attackunits are availlible
        class patrol_toCombat {
            targetState = "Combat";
            condition = "(_this getVariable ['GVAR(state)','none'])=='combat'";
            onTransition = "";
        };
    };

    // combat waiting modi
    class combat {
        onState = "";
        onStateEntered = QFUNC(statemachine_patrolCombat);
        onStateLeaving = "";
        class attack {
            targetState = "combat_inAttack";
            condition = "(!isNull(_this getVariable ['GVAR(target)',locationNull]))";
            onTransition = "";
        };
    };
    // attacking
    class combat_inAttack {
        onState = "";
        onStateEntered = QFUNC(statemachine_attack);
        onStateLeaving = "";
        class combat_return {
            targetState = "combat_return";
            condition = "(isNull(_this getVariable ['GVAR(target)',locationNull]))";
            onTransition = "";
        };
        class combat_complete {
            targetState = "combat_AttackComplete";
            condition = "(_this getVariable ['GVAR(state)','finished'])=='finished'";
            onTransition = "";
        };
    };
    // attack has been finished
    class combat_AttackComplete {
        onState = "";
        onStateEntered = QFUNC(statemachine_attackfinished);
        onStateLeaving = "";
        class combat_return {
            targetState = "combat_return";
            condition = "true";
            onTransition = "_this setVariable ['GVAR(state)','returning']";
        };
    };

    class combat_return {
        onState = "";
        onStateEntered = QFUNC(statemachine_return);
        onStateLeaving = "";
        class finished {
            targetState = "combat";
            condition = "(_this getVariable ['GVAR(state)','returning'])!='returning'";
            onTransition = "_this setVariable ['GVAR(state)','combat']";
        };
    };

    class defence {
        onState = "";
        onStateEntered = QFUNC(statemachine_patrolDefence);
        onStateLeaving = "";
        // the state has been switched to combat due to no POI exist anymore
        class defence_toCombat {
            targetState = "Combat";
            condition = "(_this getVariable ['GVAR(state)','none'])=='combat'";
            onTransition = "";
        };
        // if the POI has been destroyed, move the group to another POI to defend this one
        class defence_nextPOI {
            targetState = "defence";
            condition = "isNull (_this getVariable ['GVAR(target)',locationNull])";
            onTransition = "";
        };
    };

    class static {
        onState = "";
        onStateEntered = "_this setVariable ['GVAR(state)','static']";
        onStateLeaving = "";
    };


};
