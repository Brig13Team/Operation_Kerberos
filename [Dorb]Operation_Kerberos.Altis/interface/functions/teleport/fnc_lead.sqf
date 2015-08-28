/*
    Author: Dorbedo

    Description:
        Teleports Caller to his Squadleader

*/
#include "script_component.hpp"
SCRIPT(teleport_lead);
PARAMS_2(_host,_caller);
private["_position","_platzanzahl","_nearestEnemy"];
_position = [];

if (leader _caller == _caller) exitWith {["STR_DORB_TELEPORT",["STR_DORB_TELEPORT_LEAD_FAIL","STR_DORB_TELEPORT_LEAD_ISLEADER"]] call FUNC(disp_info);};

if ((vehicle _caller) == _caller) then {
    _nearestEnemy = _caller findNearestEnemy (leader _caller);
    if (((leader _caller) distance _nearestEnemy)<350) then {
        ["STR_DORB_TELEPORT",["STR_DORB_TELEPORT_LEAD_FAIL","STR_DORB_TELEPORT_LEAD_NEARENEMY"]] call FUNC(disp_info);
    }else{
        /// in vehicle
        If ((vehicle (leader _caller)) != (leader _caller)) then {
            _platzanzahl = (vehicle (leader _caller)) emptyPositions "cargo";
            If (_platzanzahl<1) then {
                ["STR_DORB_TELEPORT",["STR_DORB_TELEPORT_LEAD_FAIL","STR_DORB_TELEPORT_LEAD_NOPLACE"]] call FUNC(disp_info);
            }else{
                _caller moveInCargo (vehicle (leader _caller));
            };
        }else{
            If (isTouchingGround (leader _caller)) then {
                _position = (getPos (leader _caller)) findEmptyPosition [1,15,"B_crew_F"];
                if (!(_position isEqualTo [])) then {
                    private "_stance";
                    _stance = stance (leader _caller);
                    If (_stance in ["STAND","CROUCH","PRONE"]) then {
                        _caller playActionNow _stance;
                    };
                    _caller setPos _position;
                };
            }else{
                ["STR_DORB_TELEPORT",["STR_DORB_TELEPORT_LEAD_FAIL","STR_DORB_TELEPORT_LEAD_INAIR"]] call FUNC(disp_info);
            };
        };
    };
};
false