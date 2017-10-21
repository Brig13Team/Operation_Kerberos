/**
 * Author: Dorbedo
 * returns the weight of the current inventory
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * <SCLALAR> the current weight
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _weight = 0;
{
    private _amount = HASH_GET_DEF(GVAR(curInventory),_x,1);
    _weight = _weight + ([_x,_amount] call FUNC(getMass));
    nil
} count HASH_KEYS(GVAR(curInventory));

_weight
