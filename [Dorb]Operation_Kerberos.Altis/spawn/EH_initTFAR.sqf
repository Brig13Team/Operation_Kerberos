/*
 *  Author: Dorbedo
 *
 *  Description:
 *      adds the init Eventhandler
 *
 */
#include "script_component.hpp"

["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy", "init", {
    _this call FUNC(addTFR);
},true,[],true] call CBA_fnc_addClassEventHandler;
