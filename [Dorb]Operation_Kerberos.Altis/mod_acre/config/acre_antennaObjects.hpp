/*
 *  Author: Dorbedo
 *
 *  Description:
 *      definines the acre vehicles antenna-positions
 *
 */
#define CBA_OFF
#include "script_component.hpp"
class acre_antennaObjects {
    class rhs_gaz66_r142_base {
        position[] = {0,0,47.75};
        condition ="(_this select 0) doorPhase 'mast_source' == 1";
    };
    class rhs_gaz66_r142_msv : rhs_gaz66_r142_base {};
    class rhs_gaz66_r142_vdv : rhs_gaz66_r142_base {};
    class rhs_gaz66_r142_vmf : rhs_gaz66_r142_base {};
    class rhs_gaz66_r142_vv : rhs_gaz66_r142_base {};

    /*
    class Land_TTowerBig_1_F {
        position[] = {0,0,38};
        condition = "true";
        actionPosition[] = {0,0,-18.5};
    };
    class Land_TTowerBig_2_F {
        position[] = {0,0,46};
        condition = "true";
        actionPosition[] = {0,0,-22.5};
    };
    */
    class Land_TTowerSmall_2_F {
        position[] = {0,0,17};
        actionPosition[] = {0,-1,-8};
    };
    class Land_TTowerSmall_1_F {
        position[] = {0,0,10};
        actionPosition[] = {0,0,-4};
    };
    class Land_TBox_F {
        position[] = {0,0,4};
    };
};
