/*
    Author: Dorbedo

    Description:
        changes the HC

*/
#include "script_component.hpp"
CHECK(!hasInterface)

_this params [["_target",[],[[],objNull,grpNull],[2,3]],["_text","",[""]],["_color2","",[""]],["_type2","",[""]],["_dir",0,[0]]];
ISNILS(GVARMAIN(debug_marker),[]);

private["_color","_type","_mark","_position"];


if (IS_ARRAY(_target)) then {
    _color = "ColorOPFOR";
    _type = "hd_dot";
    _position = _target;
}else{
    private["_pre","_post"];
    If (IS_GROUP(_target)) then {_target = (leader _target);};

    _position = getPos _target;
    _color = switch (side _target) do {
        case (west) :         {"ColorBLUFOR"};
        case (east) :         {"ColorOPFOR"};
        case (resistance) : {"ColorIndependent"};
        case (civilian) :     {"ColorCivilian"};
        default {"ColorBlack"}
    };
    _pre = switch (side _target) do {
        case (east) : {"o_"};
        case (resistance) : {"n_"};
        default {"b_"};
    };
    _post = switch (true) do {
        case ((typeOf vehicle _target) in ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"]): {"hq"};
        case (([typeOf _target,"vehicleClass",""] call EFUNC(common,getCfgVehicles)) in ["MenSniper","MenRecon"]) : {"recon"};
        case (([typeOf _target,"engineer",0] call EFUNC(common,getCfgVehicles)) == 1): {"maint"};
        case ((vehicle _target isKindOf "MBT_01_arty_base_F")or(vehicle _target isKindOf "MBT_01_mlrs_base_F")) : {"art"};
        case ((vehicle _target isKindOf "Wheeled_Apc_F")or(vehicle _target isKindOf "APC_Tracked_02_base_F")or(vehicle _target isKindOf "APC_Tracked_03_base_F")) : {"mech_inf"};
        case (vehicle _target isKindOf "Tank") : {"armor"};
        case (vehicle _target isKindOf "Car") : {"motor_inf";};
        case ((vehicle _target isKindOf "Ship")or(vehicle _target isKindOf "Submarine")) : {"naval"};
        case (([typeOf _target,"vehicleClass",""] call EFUNC(common,getCfgVehicles)) == "Autonomous") : {"uav"};
        case (vehicle _target isKindOf "Plane") : {"plane"};
        case (vehicle _target isKindOf "Air") : {"air"};
        case (vehicle _target isKindOf "Man") : {"inf"};
        case (vehicle _target isKindOf "StaticWeapon") : {"support"};
        default {"unknown"};
    };
    _type = _pre + _post;
};
CHECK(_position isEqualTo [])
_mark = createMarkerLocal [format["DEBUGMARKER_%1",(count GVARMAIN(debug_marker))],_position];
GVARMAIN(debug_marker) pushBack _mark;
_mark setMarkerShapeLocal "ICON";
If !(_color2 isEqualTo "") then {_color=_color2;};
_mark setMarkerColorLocal _color;
If !(_type2 isEqualTo "") then {_type=_type2;};
_mark setMarkerTypeLocal _type;
If !(_text isEqualTo "") then {
    _mark setMarkerTextLocal _text;
};
_mark setMarkerDir _dir;
true
