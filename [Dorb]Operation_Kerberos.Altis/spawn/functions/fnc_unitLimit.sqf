/*
    Author: Dorbedo

    Description:
    returns if a unitlimit is reached

    Parameter(s):
        none

    Returns:
    Bool
*/
#include "script_component.hpp"
#ifndef MAX_AMOUNT_OF_UNITS
    #define MAX_AMOUNT_OF_UNITS 150
#endif
(GVARMAIN(side) countSide allUnits)>MAX_AMOUNT_OF_UNITS;
