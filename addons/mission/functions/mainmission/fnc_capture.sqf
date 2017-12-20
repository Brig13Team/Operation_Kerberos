/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      init mission "capture"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x allowFleeing 0;
    _x addEventHandler ["Killed", LINKFUNC(statemachine_decreaseCounter)];
} forEach _targets;

[
    {
        _this params [["_mission",locationNull,[locationNull]],"_handle"];
        If !([_mission] call FUNC(statemachine_isActiveMission)) exitWith {
            [_handle] call CBA_fnc_removePerFrameHandler;
        };
        private _objects = _mission getVariable ["objects",[]];
        {
            If ((!isNull _x)&&{alive _x}&&{vehicle _x == _x}) then {
                If ((_x distance2D (getMarkerPos GVARMAIN(rescuemarker)))<5) then {
                    [_x] call FUNC(statemachine_increaseCounter);
                    deleteVehicle _x;
                }else{
                    // commander surrendors if there are are more players near him then own units
                    If !(_x getVariable [QGVAR(isSurrendering), false]) then {
                        private _nearUnits = _x nearEntities ["Man", 35];
                        If ((GVARMAIN(playerside) countSide _nearUnits)>(GVARMAIN(side) countSide _nearUnits)) then {
                            ["ace_captives_setSurrendered",[_x,true],_x] call CBA_fnc_targetEvent;
                        };
                    }else{
                        // if he is not handcuffed, he will rejoin the battle
                        if !(_unit getVariable [QGVAR(isHandcuffed), false]) then {
                            private _nearUnits = _x nearEntities ["Man", 25];
                            If ((GVARMAIN(playerside) countSide _nearUnits)<(GVARMAIN(side) countSide _nearUnits)) then {
                                ["ace_captives_setSurrendered",[_x,false],_x] call CBA_fnc_targetEvent;
                            };
                        };
                    };
                };
            };
        } forEach _objects;
    },
    30,
    _mission
] call CBA_fnc_addPerFrameHandler;
