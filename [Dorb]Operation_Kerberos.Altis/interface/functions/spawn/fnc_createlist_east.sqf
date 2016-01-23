/*
    Author: Dorbedo

    Description:
    Creates the Spawnlists as Variables attachTo Spawnlists
*/
#include "script_component.hpp"
SCRIPT(createlist);
If (GVARMAIN(playerside) == west) exitWith {[] spawn FUNC(spawn_createlist);};

private _namearr = [];
private _spawnlist_cars = [];
private _spawnlist_drone = [];
private _spawnlist_heli_CAS = [];
private _spawnlist_heli_log = [];
private _spawnlist_marine = [];
private _spawnlist_others = [];
private _spawnlist_planes = [];
private _spawnlist_static = [];
private _spawnlist_support = [];
private _spawnlist_tanks = [];


private _cfgvehicles = configFile >> "cfgvehicles";

for "_i" from 0 to (count _cfgvehicles)-1  do {
    private _vehicle    = _cfgvehicles select _i;
    if (isClass _vehicle) then {
        private _class        = configName(_vehicle);
        private _genMac       = getText(configFile >> "cfgvehicles" >> _class >> "_generalMacro");
        private _vClass       = getText(configFile >> "cfgvehicles" >> _class >> "vehicleClass");
        private _dName        = getText(configFile >> "cfgvehicles" >> _class >> "displayName");
        private _supportRoles = getArray(configFile >> "cfgvehicles" >> _class >> "availableForSupportTypes");
        private _weapons      = getText(configFile >> "cfgvehicles" >> _class >> "weapons");
        private _magazines    = getText(configFile >> "cfgvehicles" >> _class >> "magazines");
        private _text         = getText(configFile >> "cfgvehicles" >> _class >> "textSingular");
        private _faction      = getText(configFile >> "cfgvehicles" >> _class >> "faction");
        private _side         = getnumber(configFile >> "cfgvehicles" >> _class >> "side");
        private _pic          = getText(configFile >> "cfgvehicles" >> _class >> "picture");
        private _icon         = getText(configFile >> "cfgvehicles" >> _class >> "Icon");
        private _Desc         = getText(configFile >> "cfgvehicles" >> _class >> "Library" >> "libTextDesc");
        private _autor        = getText(configFile >> "cfgvehicles" >> _class >> "author");
        private _simulation   = getText(configFile >> "cfgvehicles" >> _class >> "simulation");
        
        private _filter     = toArray("BASE");
        private _isBase     = {
            private _result = false;
            private _int = 0;
            {
                if((_x == _filter select 0) && (_int == 0)) then {
                    _int = 1;
                };
                if((_x == _filter select 1) && (_int == 1)) then {
                    _int = 2;
                };
                if((_x == _filter select 2) && (_int == 2)) then {
                    _int = 3;
                };
                if((_x == _filter select 3) && (_int == 3)) then {
                    _result = true;
                };
            }foreach (toArray (toUpper(_class)));
            _result;
        };

        private _isRHS = {
            _faction in [   "rhs_faction_vdv","rhs_faction_vmf","rhs_faction_msv",
                            "rhs_faction_vv","rhs_faction_tv","rhs_faction_vpvo",
                            "rhs_faction_vvs","rhs_faction_vvs_c"
                            ];
        };

        private _dNameRHS = {
            private _result = _dName;
            private _namearr = (toLower(_class)) splitString "_";
            if (("vdv" in _namearr)) then {
                _result = _result + " VDV";
            };
            if (("vmf" in _namearr)) then {
                _result = _result + " VMF";
            };
            if (("msv" in _namearr)) then {
                _result = _result + " MSV";
            };
            if (("vv" in _namearr)) then {
                _result = _result + " VV";
            };
            if (("tv" in _namearr)) then {
                _result = _result + " TV";
            };
            if (("vpvo" in _namearr)) then {
                _result = _result + " VPVO";
            };
            if (("vvs" in _namearr)) then {
                _result = _result + " VVS";
            };
            _result;
        };

        private _isRHSBase = {
            If (_vClass=="") then {false}else{
                private _namearr = _vClass splitString "_";
                (toLower(_namearr select ((count _namearr) -1))) isEqualTo "base";
            };
        };

        private _dNameBIS = {
            private _result = _dName;
            _result;
        };

        private _dNameBW = {
            private _result = _dName;
            private _namearr = _vClass splitString "_";
            if ("Tropen" in _namearr) then {
                _result = _result + " Tropen";
            };
            if ("Fleck" in _namearr) then {
                _result = _result + " Fleck";
            };
            _result;
        };
        
        if (_genMac !="" && (_text != "") && (_dName != "") && (_dName != _text) && (!(call(_isBase)))&& (!(call(_isRHSBase))) && (call(_isRHS))) then {
            if (_Class isKindOf "Air") then {
                if (_simulation in ["helicopterrtd","helicopterx"]) then {
                    If (ISCASVEHICLE(_class)) then {
                        _spawnlist_heli_CAS pushBack [_class,_pic ,"RHS", (call(_dNameRHS)), _dName, _icon];
                    } else {
                        _spawnlist_heli_log pushBack [_class,_pic ,"RHS", (call(_dNameRHS)), _dName, _icon];
                    };
                } else {
                    _spawnlist_planes pushBack [_class,_pic ,"RHS", (call(_dNameRHS)), _dName, _icon];
                };
            };
            if (_vClass in ["rhs_vehclass_ifv","rhs_vehclass_tank","rhs_vehclass_artillery","rhs_vehclass_apc"])then {
                _spawnlist_tanks pushBack [_class,_pic ,"RHS", (call(_dNameRHS)), _dName, _icon];
            };
            if (_vClass in ["rhs_vehclass_car","rhs_vehclass_truck","rhs_vehclass_MRAP"]) then {
                _spawnlist_cars pushBack [_class,_pic ,"RHS", (call(_dNameRHS)), _dName, _icon];
            };
            if (_vClass isEqualTo "Static") then {
                _spawnlist_static pushBack [_class,_pic ,"RHS", (call(_dNameRHS)), _dName, _icon];
            };
            if (_vClass=="Autonomous") then {
                _spawnlist_drone pushBack [_class,_pic ,"RHS", (call(_DNameRHS)), _DName, _icon];
            };
        };
        
        //// BIS - Vehicles
        if (_genMac !="" && _pic!="" && _genMac==_class && (_text != "") && (_text != _class) && (_dName != _class) && (_dName != "")
            && (_dName != _text) && (!(call(_isBase)))) then {
            // unarmed Helicopter
            if((_vClass isEqualTo "Air")and (!(_class iskindof "ParachuteBase"))and(_side==0)) then {
               if (_simulation in ["helicopterrtd","helicopterx"]) then {
                    _spawnlist_heli_log pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
                };
            };
            // Bardelas
            if (((_vClass=="Armored"))and(_side==0) and (_class in ["O_APC_Tracked_02_AA_F"])) then {
                _spawnlist_tanks pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };
            // HEMTT Trucks
            If (((_Class isKindOf "Truck_02_base_F")||(_Class isKindOf "Truck_03_base_F"))&&(!(_class in ["O_Truck_02_transport_F","O_Truck_02_covered_F","O_Truck_03_covered_F","O_Truck_03_transport_F","O_Truck_03_device_F"]))) then {
                _spawnlist_support pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };
            // Slingload
            If (_Class isKindOf "Pod_Heli_Transport_04_base_F") then {
                _spawnlist_support pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };
            
            if((_side==0)and(_vClass=="Static")) then {
                _spawnlist_static pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };
            
            // Drones
            if(((_vClass=="Autonomous")and(_side==0)and !(_class=="B_UGV_01_F"))or(_class=="B_UAV_02_CAS_F")) then {
                _spawnlist_drone pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };
            // Cars
            if ((_side==0)and(_vClass=="Car")and(!((_Class isKindOf "Truck_02_base_F")||(_Class isKindOf "Truck_03_base_F")))) then {
                _spawnlist_cars pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };
            // Ships
            if ((_side==0)and(_Class isKindOf "Ship")) then {
                _spawnlist_marine pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
            };

        };
        // Submarines
        if ((_vClass=="Submarine")and(!(call(_isBase)))and(_side==0)) then {
            _spawnlist_marine pushBack  [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
        };
        
        If (_class == "Land_ChairPlastic_F") then {
            _spawnlist_others pushBack [_class,_pic ,"BIS", (call(_dNameBIS)), _dName, _icon];
        };

    };
};

private _drohnenliste   = _spawnlist_drone;
private _luftliste_CAS  = _spawnlist_heli_CAS + _spawnlist_planes + _spawnlist_heli_log;
private _luftliste_log  = _spawnlist_heli_log;
private _marineliste    = _spawnlist_marine;
private _fahrzeugliste  = _spawnlist_cars + _spawnlist_tanks;
private _logistikliste  = _spawnlist_support + _spawnlist_static + _spawnlist_others;

ISNILS(fahrzeuge,objNull);
ISNILS(drohnen,objNull);
ISNILS(luftfahrzeuge,objNull);
ISNILS(luftfahrzeuge_leicht,objNull);
ISNILS(marine,objNull);
ISNILS(logistik,objNull);
ISNILS(logistik2,objNull);

{
    If (!(isNil (format["%1",(_x select 0)]))) then {
        (_x select 0) setVariable [QGVAR(spawn_list),_x select 2];
        (_x select 0) setVariable [QGVAR(spawn_point),_x select 1];
    };
}forEach [
    [fahrzeuge,"veh_spawn",_fahrzeugliste],
    [drohnen,"drone_spawn",_drohnenliste],
    [luftfahrzeuge,"air_spawn",_luftliste_CAS],
    [luftfahrzeuge_leicht,"air_spawn_light",_luftliste_log],
    [marine,"boat_spawn",_marineliste],
    [logistik,"logistic_spawn",_fahrzeugliste],
    [logistik2,"logistic_spawn2",_logistikliste]
];