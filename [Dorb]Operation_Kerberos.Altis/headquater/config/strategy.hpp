#define CBA_OFF
#include "script_component.hpp"
class strategy {
    //// _tankGroups,_infaterieGroups,_helicoptersGroups
    //// [_airborne,_airinterception,_armored,_cas,_fortifications,_motorized,_drones];
    
    /// simple attack
    class infanterie {
        condition = "(_infaterieGroups) > 0";
        probability = 0.5;
        parameter = "[_currentLogic,_infaterieGroups]";
    };
    class tankattack : infanterie {
        condition = "(_tankGroups) > 0";
        parameter = "[_currentLogic,_tankGroups]";
    };
    class helicopter : infanterie {
        condition = "_helicoptersGroups > 0";
        parameter = "[_currentLogic,_helicoptersGroups]";
    };
    
    /// simple support
    class airborne : infanterie {
        condition = QUOTE(GVAR(callIn_airborne) > 0);
        parameter = "[_currentLogic,_currenttroopsNeeded]";
    };
    class airinterception : airborne {
        condition = QUOTE(GVAR(callIn_airinterception) > 0);
    };
    class armored : airborne {
        condition = QUOTE(GVAR(callIn_armored) > 0);
    };
    class cas : airborne {
        condition = QUOTE(GVAR(callIn_cas) > 0);
    };
    class motorized : airborne {
        condition = QUOTE(GVAR(callIn_motorized) > 0);
    };
    class drones : airborne {
        condition = QUOTE(GVAR(callIn_drones) > 0);
    };
    class artillery : airborne {
        condition = QUOTE('artillery' call EFUNC(headquater,fdc_ready));
    };
    class rocket : airborne {
        condition = QUOTE('rocket' call EFUNC(headquater,fdc_ready));
    };
    class mortar : airborne {
        condition = QUOTE('mortar' call EFUNC(headquater,fdc_ready));
    };
    
    /// combined shit
    
};