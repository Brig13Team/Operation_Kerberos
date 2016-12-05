/*
 *  Author: Dorbedo
 *
 *  Description:
 *      internal function to return big Data from a pipe
 *
 *  Parameter(s):
 *      0 : STRING - Key from a open pipe
 *
 *  Returns:
 *      ANY - The big value
 *
 */
#include "script_component.hpp"

_this params ["_key"];
private _return = "";
private "_pipe";
while {true} do {
    _pipe = "extDB3" callExtension format["5:%1",_key];
    If (_pipe isEqualTo "") exitWith {};
        _result = _result + _pipe;
};
call compile _result;
