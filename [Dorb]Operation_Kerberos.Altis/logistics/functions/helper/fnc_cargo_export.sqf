/*
 *  Author: Dorbedo
 *
 *  Description:
 *      exports the values into config
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If (isNull GVAR(helper_vehicle)) exitWith {
    hint "no vehicle selected";
};

private _tab = "    ";
private _tab2 = "        ";

private _export = _tab + format ["class %1 {",typeOf GVAR(helper_vehicle)] + endl
+ _tab2 + format["width = %1;",GVAR(helper_cargo_w)] + endl
+ _tab2 + format["length = %1;",GVAR(helper_cargo_l)] + endl
+ _tab2 + format["height = %1;",GVAR(helper_cargo_h)] + endl
+ _tab2 + format["offset[] = {%1,%2,%3};",GVAR(helper_cargo_x),GVAR(helper_cargo_y),GVAR(helper_cargo_z)] + endl
+ _tab + "};" + endl;

copyToClipboard _export;
