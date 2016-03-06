/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"
CHECK(!hasinterface)

/********************
    Actions
********************/

///// suitcase actions
private _ACE_Action = [QGVAR(objects_carry), localize LSTRING(OBJECTS_CARRY), "", {[_target,player] spawn FUNC(objects_carry);}, {((isNull (_target getVariable [QGVAR(objects_carrier),objNull]))&&(vehicle player == player))}] call ace_interact_menu_fnc_createAction;
["Land_Suitcase_F", 0, ["ACE_MainActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToClass;
_ACE_Action = [QGVAR(objects_drop), localize LSTRING(OBJECTS_DROP), "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa", {[player] call FUNC(objects_drop);}, {((!(isNull (GETVAR(player,GVAR(objects_suitcase),objNull))))&&(vehicle player == player))}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _ACE_Action] call ace_interact_menu_fnc_addActionToObject;

///// Device
private _devicetypes = ["Land_Device_assembled_F","rhs_typhoon_vdv"];
{
    _ACE_Action = [QGVAR(objects_disable), localize LSTRING(OBJECTS_DISABLE), "", {[_target,player] spawn FUNC(objects_disable);}, {[_target] call FUNC(objects_canDisable)}] call ace_interact_menu_fnc_createAction;
    [_x, 0, ["ACE_MainActions"], _ACE_Action] call ace_interact_menu_fnc_addActionToClass;
} forEach _devicetypes;

/********************
    rescue Marker
********************/

if !((getMarkerPos "rescue_marker") isEqualTo [0,0,0]) then {
    private _id = addMissionEventHandler ["draw3D",{ 
        private _root = parsingNamespace getVariable "D_ROOTDIR";
        private _zoom = round(([0.5,0.5] distance worldToScreen positionCameraToWorld [0,1.05,1]) * (getResolution select 5));
        If (player distance (getMarkerPos "rescue_marker")<40)then{
            private _spawnPos = (getMarkerPos "rescue_marker");
            _spawnPos set[2,1.5];
            private _sizeicon = ((rad(2*atan(0.422793 * 30) / (player distance (getMarkerPos "rescue_marker"))))*_zoom*6);
            drawIcon3D [_root+"data\icon\icon_rescue.paa",[1,0,0,1],_spawnPos,_sizeicon*2,_sizeicon*2,0,localize LSTRING(RESCUE_MARKER),0,(_sizeicon*0.015),"PuristaMedium"];
        };
    }];
};

If (isNil QGVAR(sandstormIsActive)) then {GVAR(sandstormIsActive) = false;};
[] spawn FUNC(objects_device_effect_sandstorm_init);

/********************
    Events
********************/

[QGVAR(earthquake),{
    If (!(vehicle player isKindOf "Air")) then {
        _this params ["_strenght"];
        [_rand]spawn BIS_fnc_earthquake;
    };
}] call EFUNC(events,addEventHandler);

[QGVAR(killed_Event),
{
    [LSTRING(KILL),[format [localize LSTRING(KILL_KILLED),_this select 0]],"data\icon\icon_target.paa",true] spawn EFUNC(interface,disp_info);
}] call EFUNC(events,addEventHandler);