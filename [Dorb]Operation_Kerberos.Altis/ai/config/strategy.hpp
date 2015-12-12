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
        condition = "_airborne > 0";
        parameter = "[_currentLogic,_currenttroopsNeeded]";
    };
    class airinterception : airborne {
        condition = "_airinterception > 0";
    };
    class armored : airborne {
        condition = "_armored > 0";
    };
    class cas : airborne {
        condition = "_cas > 0";
    };
    
    class motorized : airborne {
        condition = "_motorized > 0";
    };
    class drones : airborne {
        condition = "_drones > 0";
    };
    class artillery : airborne {
        condition = QUOTE('artillery' call EFUNC(ai,fdc_ready));
    };
    class rocket : airborne {
        condition = QUOTE('rocket' call EFUNC(ai,fdc_ready));
    };
    class mortar : airborne {
        condition = QUOTE('mortar' call EFUNC(ai,fdc_ready));
    };
    
    /// combined shit
    
};