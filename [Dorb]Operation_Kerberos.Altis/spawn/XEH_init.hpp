#define CBA_OFF
#include "script_component.hpp"
class Man {
    class ADDON {
        init = QUOTE(_this call FUNC(addNVG));
    };
};
class rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy {
    class ADDON {
        init = "(_this select 0) setVariable ['tf_hasRadio',true,true];";
    };
};
class ACE_bodyBagObject {
    class ADDON {
        init = "if (local (_this select 0)) then {deleteVehicle (_this select 0);};";
    };
};
