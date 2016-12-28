/*
    Author: Dorbedo
    v1.0
*/
#define CBA_OFF
#include "script_component.hpp"
class strategy {
    //// _tankGroups,_infanterieGroups,_helicoptersGroups
    //// [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized,_drones];

    /// simple attack

    class infanterie {
        type[] = {1,0,0};
        value = 1000000;
        threat[] = {1,0.8,0.3};
        condition = "true";

        function = QFUNC(strategy_infanterie);

        timeout = -1;
        finishcondition = "(({alive _x} count (units (_this select 1)))<=((_this select 0)*0.3))";
        parameter[] = {};
    };

    class armored {
        type[] = {0,1,0};
        value = 2500000;
        threat[] = {1,1,0.3};
        condition = "true";

        function = QFUNC(strategy_armored);

        timeout = -1;
        finishcondition = "(canMove (_this select 0))";
        parameter[] = {};

    };


    class helicopter {
        type[] = {0,0,1};
        value = 3000000;
        threat[] = {1,1,0.7};
        condition = QUOTE(['helicopter'] call FUNC(ressources_canUseCallIn));

        function = QFUNC(strategy_helicopter);

        timeout = 1000;
        finishcondition = "(!(alive (_this select 0)))";
        parameter[] = {};

        onFinish = QFUNC(strategy_helicopter_OnFinish);

    };

    class airinterception {
        type[] = {0,0,1};
        value = 3000000;
        threat[] = {0,0,1};
        condition = QUOTE(['airinterception'] call FUNC(ressources_canUseCallIn));

        function = QFUNC(strategy_helicopter);

        timeout = 1000;
        finishcondition = "(!(alive (_this select 0)))";
        parameter[] = {};

        onFinish = QFUNC(strategy_helicopter_OnFinish);

    };

    class drones {
        type[] = {0,0,1};
        value = 2000000;
        threat[] = {1,1,0};
        condition = "true";

        function = QFUNC(strategy_drones);

        timeout = 1000;
        finishcondition = "";
        parameter[] = {};

    };

    class artillery {
        type[] = {0,0,0};
        value = 2000000;
        threat[] = {1,1,0};
        condition = QUOTE('artillery' call EFUNC(headquarter,fdc_ready));

        function = QFUNC(strategy_artillery);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};

    };

    class rocket {
        type[] = {0,0,0};
        value = 2000000;
        threat[] = {1,1,0};
        condition = QUOTE('rocket' call EFUNC(headquarter,fdc_ready));

        function = QFUNC(strategy_rocket);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};

    };

    class mortar {
        type[] = {0,0,0};
        value = 2000000;
        threat[] = {1,1,0};
        condition = QUOTE('mortar' call EFUNC(headquarter,fdc_ready));

        function = QFUNC(strategy_mortar);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};

    };

};
