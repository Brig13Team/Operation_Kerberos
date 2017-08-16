/*
    Author: Dorbedo
    v1.0
*/
class strategy {

    class groundattack {
        condition = "true";

        value = 100;
        strength[] = {1,1,0};
        defence[] = {0,0,0};
        type = 1;

        function = QFUNC(strategy_groundattack);

        timeout = 1800;
        finishcondition = "(({alive _x} count (units (_this select 1)))<=((_this select 0)*0.3))";
        parameter[] = {};
    };

    class helicopter {
        condition = QUOTE(['helicopter'] call FUNC(ressources_canUseCallIn));

        value = 4000;
        strength[] = {0.8,0.7,0.3};
        defence[] = {0.3,0.3,0.3};
        type = 2;

        function = QFUNC(strategy_helicopter);

        timeout = 1000;
        finishcondition = "(!(alive (_this select 0)))";
        parameter[] = {};

        onFinish = QFUNC(strategy_onFinishAir);

    };

    class airinterception {
        condition = QUOTE(['airinterception'] call FUNC(ressources_canUseCallIn));

        value = 5000;
        strength[] = {0,0,1};
        defence[] = {0.5,0.5,0.5};
        type = 2;

        function = QFUNC(strategy_airinterception);

        timeout = 1000;
        finishcondition = "(!(alive (_this select 0)))";
        parameter[] = {};

        onFinish = QFUNC(strategy_onFinishAir);
    };

    class cas : airinterception {
        condition = QUOTE(['cas'] call FUNC(ressources_canUseCallIn));

        value = 4000;
        strength[] = {0.8,0.7,0};
        defence[] = {0.5,0.5,0};
        type = 2;

        function = QFUNC(strategy_cas);
    };

    class drones {
        condition = QUOTE(['drones'] call FUNC(ressources_canUseCallIn));

        value = 4000;
        strength[] = {0.4,0.8,0};
        defence[] = {0.5,0.5,0.5};
        type = 2;

        function = QFUNC(strategy_drones);

        timeout = 1000;
        finishcondition = "";
        parameter[] = {};
    };

    class artillery {
        condition = QUOTE('artillery' call EFUNC(headquarter,fdc_ready));

        value = 2500;
        strength[] = {0.7,0.3,0};
        defence[] = {1,0.8,0};
        type = 2;

        function = QFUNC(strategy_artillery);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};
    };

    class rocket {
        condition = QUOTE('rocket' call EFUNC(headquarter,fdc_ready));

        value = 3000;
        strength[] = {0.4,0.5,0};
        defence[] = {1,0.8,0};
        type = 2;

        function = QFUNC(strategy_rocket);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};
    };

    class mortar {
        condition = QUOTE('mortar' call EFUNC(headquarter,fdc_ready));

        value = 2000;
        strength[] = {0.7,0,0};
        defence[] = {1,0.8,0};
        type = 2;

        function = QFUNC(strategy_mortar);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};
    };

};
