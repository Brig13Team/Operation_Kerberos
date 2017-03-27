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
//TRACE("orders");

private _display = uiNamespace getVariable [QEGVAR(gui_Echidna,dialog),(findDisplay IDD_ECHIDNA_MAIN)];
private _ctrlGrp = _display displayCtrl IDC_ARTILLERY_NETWORK;
private _orderlist = _ctrlGrp controlsGroupCtrl IDC_ARTILLERY_NETWORK_ORDERLIST;

private _networkConnected = ((vehicle player) getVariable [QGVAR(networkConnected),false]);

private "_orders";
If (GVAR(curArtillery) getVariable [QGVAR(networkConnected),false]) then {
    _orders = (GVAR(curArtillery) getVariable [QGVAR(orders),[]]) + (GVAR(curArtillery) getVariable [QGVAR(localorders),[]]);
}else{
    _orders = (GVAR(curArtillery) getVariable [QGVAR(localorders),[]]);
};

private _curOrders = _orderlist getVariable [QGVAR(orders),[]];

If (_curOrders isEqualTo _orders) exitWith {};

_orderlist setVariable [QGVAR(orders),_orders];
lnbClear _orderlist;
{
    private _curOrder = _x;
    private _ID = HASH_GET_DEF(_curOrder,"ID","XX");
    private _state = HASH_GET_DEF(_curOrder,"state",0);
    private _index = _orderlist lnbAddRow [format["%1",_ID],format["%1",_state],""];
    TRACEV_3(_curOrder,_ID,_index);
    If !(_curOrder isEqualType locationNull) then {
        _orderlist lnbSetPicture [[_index,0],"\a3\ui_f\data\igui\cfg\holdactions\holdaction_connect_ca.paa"];
    };
} forEach _orders;
//TRACEV_1(_orders);
