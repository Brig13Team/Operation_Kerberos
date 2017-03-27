/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"


private _listbox = _display displayCtrl IDC_ARTILLERY_NETWORK_ORDERLIST;
private _networkConnected = ((vehicle player) getVariable [QGVAR(networkConnected),false]);

private _orders = (GVAR(curArtillery) getVariable [QGVAR(orders),[]]) + (GVAR(curArtillery) getVariable [QGVAR(localorders),[]]);
private _curOrders = _ctrl getVariable [QGVAR(orders),[]];

If (_curOrders isEqualTo _orders) exitWith {};

_ctrl setVariable [QGVAR(orders),_orders];
{
    private _curOrder = _x;
    private _ID = HASH_GET(_curOrder,"ID");
    private _state = HASH_GET(_curOrder,"state");
    private _index = _ctrl lnbAddRow [_ID,_state];
    If !(_curOrder isEqualType locationNull) then {
        _ctrl lnbSetPicture [[_index,0],"\a3\ui_f\data\igui\cfg\holdactions\holdaction_connect_ca.paa"];
    };
} forEach _orders;
