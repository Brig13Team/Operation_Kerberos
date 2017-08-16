/*
    Author: Dorbedo

    Description:
        AO orte + Sortierung

*/
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

If (worldName == "Altis") then {
    for "_i" from 0 to ((count _cfgOrte)-1) do {
        _ort         = _cfgOrte select _i;
        _name         = getText(_ort >> "name");
        _position    = getArray(_ort >> "position");
        _typ        = getText(_ort >> "type");
        If ((_position distance (getmarkerpos GVARMAIN(RESPAWNMARKER)) > 2000)&&(_position distance (getMarkerPos "respawn_west_land") > 2000)) then {
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
            If (!(_name in ["Fournos","Monisi","Pyrgi","Atsalis","Bomos","Savri","Makrynisi","Sagonisi"]) and (_name != "")) exitWith {
                _loc_sonst pushBack [_name,_position];
            };
        };
    };
};

If (worldName == "australia") then {
    for "_i" from 0 to ((count _cfgOrte)-1) do {
        _ort         = _cfgOrte select _i;
        _name         = getText(_ort >> "name");
        _position    = getArray(_ort >> "position");
        _typ        = getText(_ort >> "type");
        If ((_position distance (getmarkerpos GVARMAIN(RESPAWNMARKER)) > 2000)) then {
            If ((_typ in ["NameCityCapital","NameCity","NameVillage"])and(_name != "Sagonisi")) exitWith {
                _loc_civ pushBack [_name,_position];
            };
            If ((surfaceIsWater _position)and(_name != "Edessa")) exitWith {
                _loc_water pushBack [_name,_position];
            };
            If ((_name in ["MILITARY","Militär","military"])||(_typ in ["myairportblue","myairportgreen"])) exitWith {
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
            If (!(_name in ["Fournos","Monisi","Pyrgi","Atsalis","Bomos","Savri","Makrynisi","Sagonisi"]) and (_name != "") and (!(_typ in ["myshipwreck"])) and (!((configName _ort) in ["garden_island","rottnest_island","Kangaroo_island","King_island","moreton_island","groote_Eylandt","flinders_island"]))) exitWith {
                _loc_sonst pushBack [_name,_position];
            };
        };
    };
};

// N'Ziwasogo
If (worldName == "pja305") then {
    for "_i" from 0 to ((count _cfgOrte)-1) do {
        _ort         = _cfgOrte select _i;
        _name         = getText(_ort >> "name");
        _position    = getArray(_ort >> "position");
        _typ        = getText(_ort >> "type");
        If ((_position distance (getmarkerpos GVARMAIN(RESPAWNMARKER)) > 2000)) then {
            If ((_typ in ["NameCityCapital","NameCity","NameVillage"])and(!(_name in ["Bafata","Waku Kungo"]))) exitWith {
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
            If ((_name != "")) exitWith {
                _loc_sonst pushBack [_name,_position];
            };
        };
    };
    {_loc_sonst pushBack _x;}forEach[
        ["Hutan Buluh"    ,[3603.13,19506.9,0.00151825]],
        ["Linguehoie"    ,[5413.13,18229.4,0.00183868]],
        ["Souroune"        ,[5301.86,9580.19,0.00154877]],
        ["Dialakaya"    ,[15089.4,17583.1,0.00207138]],
        ["Bombaye"        ,[13385,16452.2,0.00128174]],
        ["Kambita"        ,[12432.2,16051.9,0.00131607]],
        ["Banga"        ,[9015.63,19100.6,0.00141907]],
        ["Koukama"        ,[10903.1,18508.1,0.00141525]],
        ["Seretiti"        ,[9154.53,7773.26,0.00143051]],
        ["Diohoe"        ,[9683.45,7823.6,0.00143814]],
        ["Laliala"        ,[6835.63,8811.88,0.00141907]],
        ["Yorgora"        ,[5861.24,14744.5,0.00141525]],
        ["Dabirouto"    ,[7860.63,15363.1,0.00144196]],
        ["Gaigou"        ,[16033.7,11961,0.00147247]]
        ];
    {_loc_mil pushBack _x;}forEach[
        ["Timbobo"        ,[9619.47,14998.1,0.0014267]],
        ["Trgiasa"        ,[18241.7,10136,0.00149345]],
        ["Marandoso"    ,[12905.1,13419,0.00144577]],
        ["Miside Daribo",[17644,13977.9,0.00143814]],
        ["Dongola"        ,[8449.37,11376.7,0.00165558]],
        ["Gula"            ,[3488.23,10505.5,0.00143814]],
        ["Gado"            ,[3833.13,16603.1,0.00158691]]
    ];
};

If (worldName == "Panthera3") then {
    for "_i" from 0 to ((count _cfgOrte)-1) do {
        _ort         = _cfgOrte select _i;
        _name         = getText(_ort >> "name");
        _position    = getArray(_ort >> "position");
        _typ        = getText(_ort >> "type");
        If ((_position distance (getmarkerpos GVARMAIN(RESPAWNMARKER)) > 2000)) then {
            If (((_typ in ["NameCityCapital","NameCity","NameVillage","FlatAreaCitySmall","CityCenter"])and(!((configName _ort) in ["dino2","dino13","dino3","dino6","vatra"])))||((configName _ort) in ["TaffGrove","klavze","kneza","cavepredil",
                                                                                                                                                            "bovec","Tolmin","kranjskagora","dovje",
                                                                                                                                                            "mojstrana","lesce","begunje","Studor",
                                                                                                                                                            "zuma","Rockburn","Foxhill","skooma","Belley",
                                                                                                                                                            "fisher","smugden","zelezniki","drazgose",
                                                                                                                                                            "kranjskagora","kropa","ribcevlaz","idrsko","suzid",
                                                                                                                                                            "bdobrava","breg","bohbistrica"

                                                                                                                                                            ])) exitWith {
                _loc_civ pushBack [_name,_position];
            };
            If ((surfaceIsWater _position)and(_name != "Edessa")) exitWith {
                _loc_water pushBack [_name,_position];
            };
            If ((_typ in ["StrongpointArea","Airport","NameMarine","BorderCrossing"])||(_ort in ["borjana"])) exitWith {
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
            If ((_name != "")) exitWith {
                _loc_sonst pushBack [_name,_position];
            };
        };
    };
    {_loc_civ pushBack _x;}forEach[
        ["Porto Ritmo South"    ,[8625.15,1938.24]],
        ["Porto Ritmo North"    ,[9019.02,2756.4]]
    ];
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

[_loc_civ,_loc_ind,_loc_mil,_loc_water,_loc_sonst]
