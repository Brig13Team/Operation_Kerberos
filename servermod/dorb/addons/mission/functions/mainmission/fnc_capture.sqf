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
    _x addEventHandler ["Killed", LINKFUNC(obj__decreaseCounter)];
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
                    [_x] call FUNC(obj__increaseCounter);
                    deleteVehicle _x;
                }else{
                    // behavior of the commander
                    If !(_x getVariable [QGVAR(isSurrendering), false]) then {
                        private _nearUnits = _x nearEntities ["Man", 40];
                        If ((GVARMAIN(playerside) countSide _nearUnits)>(GVARMAIN(side) countSide _nearUnits)) then {
                            ["ace_captives_setSurrendered",[_x,true],_x] call CBA_fnc_targetEvent;
                        };
                    };
                };
            };
        } forEach _objects;
    },
    30,
    _mission
] call CBA_fnc_addPerFrameHandler;
