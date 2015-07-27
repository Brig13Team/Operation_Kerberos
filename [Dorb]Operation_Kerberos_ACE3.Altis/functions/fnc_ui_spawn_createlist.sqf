/*
    Author: Dorbedo

    Description:
    Creates the Spawnlists as Variables attachTo Spawnlists
*/
#include "script_component.hpp"
If (DORB_PLAYERSIDE == east) exitWith {[] spawn FM(ui_spawn_createlist_east);};
private["_spawnliste_ace","_spawnliste_ammo","_spawnliste_bwmat","_spawnliste_drohne","_spawnliste_fahrzeug_bewaffnet",
        "_spawnliste_fahrzeug_unbewaffnet","_spawnliste_fia","_spawnliste_heli","_spawnliste_jet","_spawnliste_logistikheli",
        "_spawnliste_marine","_spawnliste_material","_spawnliste_panzer","_spawnliste_statisch","_spawnliste_submarine","_spawnliste_support",
        "_spawnliste_fahrzeug_rhs","_spawnliste_heli_rhs","_spawnliste_jet_rhs","_spawnliste_panzer_rhs","_spawnliste_statisch_rhs",
        "_class","_genMac","_vClass","_DName","_roles","_weapons","_magazines","_type","_faction","_side","_pic","_icon","_Desc","_autor",
        "_isBase","_isRHS","_DNameRHS","_namearr","_DNameBIS","_DNameBW",
        "_cfgvehicles"
        ];

_namearr = [];
_spawnliste_panzer = [];
_spawnliste_jet = [];
_spawnliste_heli_transport = [];
_spawnliste_heli = [];
_spawnliste_ammo = [];
_spawnliste_marine = [];
_spawnliste_statisch = [];
_spawnliste_fahrzeug_bewaffnet = [];
_spawnliste_fahrzeug_unbewaffnet = [];
_spawnliste_drohne = [];
_spawnliste_support =[];
_spawnliste_material = [];
_spawnliste_submarine = [];
_spawnliste_ace = [];
_spawnliste_bwmat =[];
_spawnliste_fia =[];
_spawnliste_logistikheli =[];
_spawnliste_cse =[];
_spawnliste_fahrzeug_rhs = [];
_spawnliste_heli_rhs = [];
_spawnliste_jet_rhs = [];
_spawnliste_panzer_rhs = [];
_spawnliste_statisch_rhs = [];

_cfgvehicles = configFile >> "cfgvehicles";

for "_i" from 0 to (count _cfgvehicles)-1  do {
    _vehicle    = _cfgvehicles select _i;
    if (isClass _vehicle) then {
        _class      = configName(_vehicle);
        _genMac     = getText(configFile >> "cfgvehicles" >> _class >> "_generalMacro");
        _vClass     = getText(configFile >> "cfgvehicles" >> _class >> "vehicleClass");
        _DName      = getText(configFile >> "cfgvehicles" >> _class >> "displayName");
        _roles      = getText(configFile >> "cfgvehicles" >> _class >> "availableForSupportTypes");
        _weapons    = getText(configFile >> "cfgvehicles" >> _class >> "weapons");
        _magazines  = getText(configFile >> "cfgvehicles" >> _class >> "magazines");
        _type       = getText(configFile >> "cfgvehicles" >> _class >> "textSingular");
        _faction    = getText(configFile >> "cfgvehicles" >> _class >> "faction");
        _side       = getnumber(configFile >> "cfgvehicles" >> _class >> "side");
        _pic        = getText(configFile >> "cfgvehicles" >> _class >> "picture");
        _icon       = getText(configFile >> "cfgvehicles" >> _class >> "Icon");
        _Desc       = getText(configFile >> "cfgvehicles" >> _class >> "Library" >> "libTextDesc");
        _autor      = getText(configFile >> "cfgvehicles" >> _class >> "author");

        _filter     = toArray("BASE");
        _isBase     =
        {
                _result = false;
                _int = 0;
                {
                        if((_x == _filter select 0) && (_int == 0)) then
                        {
                                _int = 1;
                        };
                        if((_x == _filter select 1) && (_int == 1)) then
                        {
                                _int = 2;
                        };
                        if((_x == _filter select 2) && (_int == 2)) then
                        {
                                _int = 3;
                        };
                        if((_x == _filter select 3) && (_int == 3)) then
                        {
                                _result = true;
                        };
                }foreach (toArray (toUpper(_class)));
                _result;
        };

        _isRHS      =
        {
            _faction in [   "rhs_faction_usmc_d","rhs_faction_usmc_wd",
                            "rhs_faction_usarmy_d","rhs_faction_usarmy_wd",
                            "rhs_faction_usaf"
                            ];
        };

        _DNameRHS =
        {
            _result = _DName;
            _namearr = [_class,"_"] call BIS_fnc_splitString;
            //LOG_1(_namearr);
            if (("wd" in _namearr)or("w" in _namearr)) then {
                _result = _result + " Woodland";
            };
            if ("d" in _namearr) then {
                _result = _result + " Desert";
            };
            _result;
        };

        _isRHSBase =
        {
            If (_vClass=="") then {false}else{
                _namearr = [_vClass,"_"] call BIS_fnc_splitString;
                if ((_namearr select ((count _namearr) -1))in["base","Base"]) then {true}else{false};
            };
        };

        _DNameBIS =
        {
            _result = _DName;
            _result;
        };

        _DNameBW =
        {
            _result = _DName;
            _namearr = [_vClass,"_"] call BIS_fnc_splitString;
            if ("Tropen" in _namearr) then {
                _result = _result + " Tropen";
            };
            if ("Fleck" in _namearr) then {
                _result = _result + " Fleck";
            };
            _result;
        };

        if (_genMac !="" && (_type != "") && (_DName != "") && (_DName != _type) && (!(call(_isBase)))&& (!(call(_isRHSBase))) && (call(_isRHS))) then {
            if (_Class isKindOf "Air") then {

                if (_vClass in ["rhs_vehclass_helicopter"]) then {
                    _spawnliste_heli_rhs pushBack [_class,_pic ,"RHS", (call(_DNameRHS)), _DName, _icon];
                } else {
                    _spawnliste_jet_rhs pushBack [_class,_pic ,"RHS", (call(_DNameRHS)), _DName, _icon];
                };
            };
            if (_vClass in ["rhs_vehclass_ifv","rhs_vehclass_tank","rhs_vehclass_artillery"])then {
                _spawnliste_panzer_rhs pushBack [_class,_pic ,"RHS", (call(_DNameRHS)), _DName, _icon];
            };
            if (_vClass in ["rhs_vehclass_car","rhs_vehclass_truck","rhs_vehclass_MRAP"]) then {
                _spawnliste_fahrzeug_rhs pushBack [_class,_pic ,"RHS", (call(_DNameRHS)), _DName, _icon];
            };
            if (_vClass=="Static") then {
                _spawnliste_statisch_rhs pushBack [_class,_pic ,"RHS", (call(_DNameRHS)), _DName, _icon];
            };
        };

        if (_genMac !="" && _pic!="" && _genMac==_class && (_type != "") && (_type != _class) && (_DName != _class) && (_DName != "")
            && (_DName != _type)/* && (!("FakeWeapon" in _weapons))*/ && (!(call(_isBase)))) then {

            if((_vClass=="Air")and (!(_class iskindof "ParachuteBase"))and(_side==1)or((_class=="I_Heli_light_03_unarmed_F"))or((_class=="I_Heli_light_03_F"))) then {
                        //and(!(_class=="B_Heli_Transport_03_F"))
                if ((_class isKindOf "Helicopter")) then {

                    _spawnliste_heli pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

                } else {

                    _spawnliste_jet pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

                };
            };

            if((_Class isKindOf "Heli_Transport_04_base_F")or(_Class isKindOf "Heli_Transport_02_base_F")) then {

                _spawnliste_logistikheli pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

            if(((_vClass=="Armored"))and(_side==1)and(!(_class=="B_MBT_01_TUSK_F"))and(!(_class=="B_MBT_01_cannon_F"))and(!(_class=="B_APC_Tracked_01_rcws_F"))and(!(_class isKindOf "B_APC_Wheeled_01_base_F"))) then {

                _spawnliste_panzer pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

            if(_vClass=="BWA3_VehClass_Tracked_Tropen") then {

                _spawnliste_panzer pushBack [_class,_pic ,"BW", (call(_DNameBW)), _DName, _icon];

            };

            if(_vClass=="BWA3_VehClass_Tracked_Fleck") then {

                _spawnliste_panzer pushBack [_class,_pic ,"BW", (call(_DNameBW)), _DName, _icon];

            };

            if((_vClass=="Support")and(_side==1)) then {

                _spawnliste_support pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

            if((_side==1)and(_vClass=="Static")) then {

                _spawnliste_statisch pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

            if ((_vClass=="Ammo")or(_Class isKindOf "Slingload_01_Base_F")) then {

                _spawnliste_ammo pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

            if(((_vClass=="Autonomous")and(_side==1)and !(_class=="B_UGV_01_F"))or(_class=="B_UAV_02_CAS_F")) then {

                _spawnliste_drohne pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

            if((_side==1)and(_vClass=="Car")) then {

                if(count(_weapons)==0||count(_magazines)==0) then {

                    _spawnliste_fahrzeug_unbewaffnet pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

                } else {

                    _spawnliste_fahrzeug_bewaffnet pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

                };
            };


            if((_side==1)and(_Class isKindOf "Ship")) then {

                _spawnliste_marine pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

            };

        };

        if(_vClass=="BWA3_VehClass_Wheeled_Tropen") then {

            _spawnliste_fahrzeug_bewaffnet pushBack [_class,_pic ,"BW", (call(_DNameBW)), _DName, _icon];

        };

        if(_vClass=="BWA3_VehClass_Wheeled_Fleck") then {

            _spawnliste_fahrzeug_bewaffnet pushBack [_class,_pic ,"BW", (call(_DNameBW)), _DName, _icon];

        };


        if (((_vClass=="Ammo")and(_autor=="BWMod"))) then {

            _spawnliste_bwmat pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

        };

        if ((_class=="ACE_medicalSupplyCrate")or(_class=="ACE_medicalSupplyCrate_advanced")or(_class=="ACE_Box_Misc")or(_class=="ACE_Box_Ammo")or(_class=="B_Truck_01_medical_F")) then {

            _spawnliste_ace  pushBack       [_class,_pic ,"ACE",_DName, _DName, _icon];

        };

        if((_vClass=="Submarine")and(!(call(_isBase)))and(_side==1)) then {

            _spawnliste_submarine pushBack  [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

        };

        if((_genMac !="") and (_genMac !=_class)  and (_vClass=="Car")and(!(call(_isBase)))and(_side==1)and(_pic!="")and(_type != "")and(_type != _class)and(_DName != _class)and(_DName != "")and(_DName != _type)) then {

        _spawnliste_fia pushBack [_class,_pic ,"BIS", (call(_DNameBIS)), _DName, _icon];

        };

    };
};

_drohnenliste   = _spawnliste_drohne;
_luftliste      = _spawnliste_heli + _spawnliste_heli_rhs + _spawnliste_jet + _spawnliste_jet_rhs;
_fahrzeugliste  = _spawnliste_fia + _spawnliste_fahrzeug_bewaffnet + _spawnliste_fahrzeug_unbewaffnet + _spawnliste_support + _spawnliste_panzer + _spawnliste_fahrzeug_rhs + _spawnliste_panzer_rhs;
_logistikliste  = _spawnliste_heli_transport + _spawnliste_support + _spawnliste_fahrzeug_unbewaffnet + _spawnliste_bwmat + _spawnliste_statisch + _spawnliste_ammo + _spawnliste_fia + _spawnliste_logistikheli + _spawnliste_ace + _spawnliste_statisch_rhs;
_marineliste    = _spawnliste_marine + _spawnliste_submarine;

SETPVAR(fahrzeuge,DORB_SPAWNLIST,_fahrzeugliste);
SETPVAR(drohnen,DORB_SPAWNLIST,_drohnenliste);
SETPVAR(luftfahrzeuge,DORB_SPAWNLIST,_luftliste);
SETPVAR(marine,DORB_SPAWNLIST,_marineliste);
SETPVAR(logistik,DORB_SPAWNLIST,_logistikliste);

SETPVAR(fahrzeuge,DORB_SPAWNPOINT,"veh_spawn");
SETPVAR(drohnen,DORB_SPAWNPOINT,"drone_spawn");
SETPVAR(luftfahrzeuge,DORB_SPAWNPOINT,"air_spawn");
SETPVAR(marine,DORB_SPAWNPOINT,"boat_spawn");
SETPVAR(logistik,DORB_SPAWNPOINT,"logistic_spawn");
