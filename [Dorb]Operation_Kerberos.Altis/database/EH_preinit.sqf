/*
 *  Author: Dorbedo
 *
 *  Description:
 *      preinit
 *
 */
#include "script_component.hpp"

ADDON = false;

PREP(bigData);
PREP(connectToDB);
PREP(getSingleValue);
PREP(getValue);
PREP(sendNoReturn);
PREP(sendWithReturn);

ADDON = true;

GVAR(initialized) = false;
