#include "script_component.hpp"


If (!hasInterface) then {
    [
        QGVAR(teamfire),{
            _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]],["_damage",-1,[0]]];
            private _frame = diag_frameNo;
            diag_log format["TEAMFIRE(%4): %1 of team %2 at %3",name _target,group _target,getPos _target,_frame];
            diag_log format["TEAMFIRE(%4): shot by %1 of team %2 at %3",name _shooter,group _shooter,getPos _shooter,_frame];
            diag_log format["TEAMFIRE(%4): Damage=%1 |Weapon=%2 |Vehicle=%3",_damage,currentWeapon _shooter,typeOf (vehicle _shooter),_frame];
        }
    ] call CBA_fnc_addEventHandler;
}else{
    [
        QGVAR(teamfire),{
            if (serverCommandAvailable "#logout") then {
                _this params [["_target",objNull,[objNull]],["_shooter",objNull,[objNull]],["_damage",-1,[0]]];
                systemchat format["Teambeschuss: %1 / %2 beschossen von %3 / %4   Damage=%5",_target,name _target,_shooter,name _shooter,_damage];
            };
        }
    ] call CBA_fnc_addEventHandler;
};