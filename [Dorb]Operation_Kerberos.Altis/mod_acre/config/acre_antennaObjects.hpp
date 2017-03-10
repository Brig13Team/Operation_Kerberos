/*
 *  Author: Dorbedo
 *
 *  Description:
 *      definines the acre vehicles antenna-positions
 *
 */
#include "script_component.hpp"
class acre_antennaObjects {
    class rhs_gaz66_r142_base {
        position = [0,0,47.75];
        condition ="_target doorPhase 'mast_source' == 1";
    };
    class rhs_gaz66_r142_msv : rhs_gaz66_r142_base {};
    class rhs_gaz66_r142_vdv : rhs_gaz66_r142_base {};
    class rhs_gaz66_r142_vmf : rhs_gaz66_r142_base {};
    class rhs_gaz66_r142_vv : rhs_gaz66_r142_base {};


    class Land_TTowerBig_1_F {
        position = [0,0,38];
        condition = "true";
    };
    class Land_TTowerBig_1_F {
        position = [0,0,46];
        condition = "true";
    };
    class Land_TTowerSmall_2_F {
        position = [0,0,17];
        condition = "true";
    };
    class Land_TTowerSmall_2_F {
        position = [0,0,10];
        condition = "true";
    };
    class Land_TTowerSmall_1_F {
        position = [0,0,4];
        condition = "true";
    };
};
