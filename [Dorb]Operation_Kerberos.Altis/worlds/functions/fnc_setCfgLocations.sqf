/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the map, if no config is provided
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _loc_water=[];
private _loc_civ=[];
private _loc_ind=[];
private _loc_mil=[];
private _loc_sonst=[];
private _cfgOrte=[];

private _mil=0;
private _ind=0;
private _pow=0;
private _quar=0;

private _cfgOrte = configFile >> "CfgWorlds" >> worldName >> "Names";
for "_i" from 0 to ((count _cfgOrte)-1) do {
    _ort         = _cfgOrte select _i;
    _name         = getText(_ort >> "name");
    _position    = getArray(_ort >> "position");
    _typ        = getText(_ort >> "type");
    If (_position distance (getmarkerpos GVARMAIN(RESPAWNMARKER)) > 2500) then {
        If ((_typ in ["NameCityCapital","NameCity","NameVillage"])and(_name != "Sagonisi")) exitWith {
            _loc_civ pushBack [_name,_position];
        };
        If ((surfaceIsWater _position)and(_name != "Edessa")) exitWith {
            _loc_water pushBack [_name,_position];
        };
        If (_name in ["MILITARY","Militär","military"]) exitWith {
            INC(_mil);
            _loc_mil pushBack [FORMAT_2("%1 %2",_name,_mil),_position];
        };
        If (_name in ["FACTORY","Fabrik","factory"]) exitWith {
            INC(_ind);
            _loc_ind pushBack [FORMAT_2("%1 %2",_name,_ind),_position];
        };
        If (_name in ["QUARRY","Steinbruch","quarry"]) exitWith {
            INC(_quar);
            _loc_ind pushBack [FORMAT_2("%1 %2",_name,_quar),_position];
        };
        If (_name in ["POWER PLANT","Kraftwerk","power plant"]) exitWith {
            INC(_pow);
            _loc_ind pushBack [FORMAT_2("%1 %2",_name,_pow),_position];
        };
    };
};

ISNILS(GVARMAIN(loc_debug),false);
If (GVARMAIN(loc_debug)) then {
    private "_mrkr";
    {
        [_x select 1,_x select 0,"ColorCIV","mil_flag"] call EFUNC(common,debug_marker_create);
    }forEach _loc_civ;
    {
        [_x select 1,_x select 0,"ColorBlue","mil_flag"] call EFUNC(common,debug_marker_create);
    }forEach _loc_water;
    {
        [_x select 1,_x select 0,"ColorYellow","mil_flag"] call EFUNC(common,debug_marker_create);
    }forEach _loc_ind;
    {
        [_x select 1,_x select 0,"ColorOrange","mil_flag"] call EFUNC(common,debug_marker_create);
    }forEach _loc_mil;
    {
        [_x select 1,_x select 0,"ColorRed","mil_flag"] call EFUNC(common,debug_marker_create);
    }forEach _loc_sonst;
};

EGVAR(mission,town) = _loc_civ;
EGVAR(mission,industrie) = _loc_ind;
EGVAR(mission,military) = _loc_mil;
EGVAR(mission,water) = _loc_water;
EGVAR(mission,other) = _loc_sonst;
