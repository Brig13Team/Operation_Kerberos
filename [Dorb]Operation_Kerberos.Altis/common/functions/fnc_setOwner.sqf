/*
    Author: Dorbedo

    Description:
        sets the Owner of an object/group

    Parameter(s):
        0 : OBJECT/GROUP - Object to change
        1 : OBJECT/SCALAR/BOOL - Target

    Returns:
        (executed on client)
            none
        (executed on server)
            BOOL - owner changed
*/
#include "script_component.hpp"
_this params [["_object",objNull,[objNull]],["_target",objNull,[objNull,0,true]]];

If (!isServer) then {
    [QGVAR(changeOwner),[_object,_target]] call CBA_fnc_serverEvent;
};

If (IS_BOOL(_target)) then {_target = 0;};
If (IS_OBJECT(_target)) then {_target = owner _target;};

If (IS_GROUP(_object)) then {
    If !((groupowner _object) == _target) then {
        _object setGroupOwner _targetOwner;
    };
}else{
    If !((owner _object) == _target) then {
        _object setOwner _target;
    };
};
