/*
    Author: Dorbedo

    Description:
        Teleports Caller to his Squadleader

*/
#define INCLUDE_GUI
#include "script_component.hpp"

private _caller = player;
private["_position","_platzanzahl","_nearestEnemy","_time"];
_position = [];

if (leader _caller == _caller) exitWith {
    [LSTRING(LEAD_FAIL),LSTRING(LEAD_ISLEADER),"red"] call EFUNC(gui,message);
};

private _serverkey = missionNamespace getVariable [QGVARMAIN(missionkeyServer),"ERROR"];
private _missionkey = missionNamespace getVariable [QGVARMAIN(missionkey),"ERROR"];
private _missiontime = missionNamespace getVariable [QGVARMAIN(missiontime),CBA_missiontime];

If ((_serverkey == _missionkey)&&{(_missiontime - CBA_missiontime + 1200) > 0}) exitWith {
    [
        LSTRING(TELEPORT),
        format [localize LSTRING(LEAD_WAIT),
            floor ((_missiontime - CBA_missiontime + 1200) / 60),
            floor ((_missiontime - CBA_missiontime + 1200) mod 60)
        ],
        "red"
    ] call EFUNC(gui,message);

};

private _isTeleported = false;

if ((vehicle _caller) == _caller) then {
    _nearestEnemy = _caller findNearestEnemy (leader _caller);
    if (((leader _caller) distance _nearestEnemy)<350) then {
        [LSTRING(LEAD_FAIL),LSTRING(LEAD_NEARENEMY),"red"] call EFUNC(gui,message);
    }else{
        /// in vehicle
        If ((vehicle (leader _caller)) != (leader _caller)) then {
            _platzanzahl = (vehicle (leader _caller)) emptyPositions "cargo";
            If (_platzanzahl<1) then {
                [LSTRING(LEAD_FAIL),LSTRING(LEAD_NOPLACE),"red"] call EFUNC(gui,message);
            }else{
                _caller moveInCargo (vehicle (leader _caller));
                _isTeleported = true;
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
                    _isTeleported = true;
                };
            }else{
                [LSTRING(LEAD_FAIL),LSTRING(LEAD_INAIR),"red"] call EFUNC(gui,message);
            };
        };
    };
};

if (_isTeleported) then {
    GVARMAIN(missionkey) = _serverkey;
    GVARMAIN(missiontime) = CBA_missiontime;
};
