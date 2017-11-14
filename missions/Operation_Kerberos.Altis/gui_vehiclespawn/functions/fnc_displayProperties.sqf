/**
 * Author: Dorbedo
 * display the properties
 *
 * Arguments:
 * 0: <STRING> type of propertie
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define GUI_DISP_PROPW getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "w")
#define GUI_DISP_PROP_TEXT(COY) [GUI_DISP_W*2,GUI_DISP_H*COY,(GUI_DISP_PROPW-GUI_DISP_W*5)/2,GUI_DISP_W*4]
#define GUI_DISP_PROP_VAL(COY) [GUI_DISP_PROPW/2+GUI_DISP_W*1,GUI_DISP_H*COY,(GUI_DISP_PROPW-GUI_DISP_W*7)/2,GUI_DISP_W*4]
#define INCROW _row = _row + 4.5;


params [["_option",GVAR(option_current),[""]]];

GVAR(option_current) = _option;

private _display = uiNamespace getVariable [QEGVAR(gui_main,dialog),(findDisplay IDD_GUI_VEHICLESPAWN)];
private _ctrlGroup = _display displayCtrl IDC_GUI_VEHICLESPAWN_PROPERTIES;
{
    ctrlDelete _x;
} forEach (_ctrlGroup getVariable ["controls",[]]);
_ctrlGroup setVariable ["controls",[]];
private _ctrlBackground = _ctrlGroup controlsGroupCtrl IDC_GUI_MAIN_METRO_BACK;
_ctrlBackground ctrlSetPosition [
    0,
    0,
    getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "w"),
    getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "h")
];
_ctrlBackground ctrlCommit 0;




private _idc = IDC_GUI_VEHICLESPAWN_PROPERTIES_START;
If (GVAR(curVeh) isEqualTo "") then {_option = "noVehicle"};

private _fnc_getWeapons = {
    _this params ["_unittype"];
    private _turrets = "true" configClasses (configfile >> "CfgVehicles" >> _unittype >> "turrets");
    private _weapons = [];
    {
        _weapons append getArray(_x>>"weapons");
        nil;
    } count _turrets;
    _weapons = _weapons select {!((toUpper _x) in ["CMFLARELAUNCHER","ACE_AIR_SAFETY","RHS_WEAP_MASTERSAFE","RHS_LWIRCM_MELB","RHSUSF_WEAP_DUMMYLAUNCHER","RHSAFRF_WEAP_DUMMYLAUNCHER"])};

    private _pylons = "true" configClasses (configfile >> "CfgVehicles" >> _unittype >> "Components" >> "TransportPylonsComponent" >> "pylons");
    private _magazines = [];
    {
        _magazines pushBack getText(_x>>"attachment");
        nil;
    } count _pylons;
    [_weapons,_magazines - [""]];
};

switch _option do {
    case "noVehicle" : {
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(2);
        _ctrl ctrlSetText (localize LSTRING(PROP_NOVEHICLE));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
    };
    default {
        // watermark
        /*
        private _ctrl = _display ctrlCreate [QRSC(BasePicture),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "w")*0.1,
            getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "h")*0.1,
            getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "w")*0.8,
            getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "h")*0.8
        ];
        _ctrl ctrlSetTextColor [1,1,1,0.4];
        _ctrl ctrlSetText GVAR(curModPic);
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        */

        // general informations
        private _row = 2;
        // maxSpeed
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_MAXSPEED));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        private _value = ([GVAR(curVeh),"maxSpeed",0] call EFUNC(common,getCfgVehicles));
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
        _ctrl ctrlSetText format["%1",_value];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        INCROW;

        // ace_cargo
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_CARGOSPACE));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        private _value = ([GVAR(curVeh),"ace_cargo_space",0] call EFUNC(common,getCfgVehicles));
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
        _ctrl ctrlSetText format["%1",_value];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        INCROW;

        // ace_fuel
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_FUELSIZE));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        private _value = ([GVAR(curVeh),"ace_refuel_fuelCapacity",0] call EFUNC(common,getCfgVehicles));
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
        _ctrl ctrlSetText format["%1",_value];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        INCROW;

        // ace_isMEDIC
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_ISMEDIC));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        private _value = ([GVAR(curVeh),"attendant",0] call EFUNC(common,getCfgVehicles))>0;
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
        _ctrl ctrlSetText (localize ([LSTRING(PROP_NO),LSTRING(PROP_YES)] select _value));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        INCROW;

        // ace_isAMMO
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_ISAMMO));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        private _value = ([GVAR(curVeh),"ace_rearm_defaultSupply",0] call EFUNC(common,getCfgVehicles))>0;
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
        _ctrl ctrlSetText (localize ([LSTRING(PROP_NO),LSTRING(PROP_YES)] select _value));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        INCROW;

        // armor
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_ARMOR));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        private _value = ([GVAR(curVeh),"armor",0] call EFUNC(common,getCfgVehicles));
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
        _ctrl ctrlSetText format["%1",_value];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        INCROW;

        // Weapons
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition GUI_DISP_PROP_TEXT(_row);
        _ctrl ctrlSetText (localize LSTRING(PROP_WEAPONS));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        ([GVAR(curVeh)] call _fnc_getWeapons) params ["_weapons","_magazines"];
        TRACEV_2(_weapons,_magazines);
        If !((_weapons isEqualTo [])&&(_magazines isEqualTo [])) then {
            {
                private _value = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
                _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
                _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
                _ctrl ctrlSetText format["%1",_value];
                _ctrl ctrlCommit 0;
                (_ctrlGroup getVariable "controls") pushBack _ctrl;
                INC(_idc);
                INCROW;
            } forEach (_weapons);
            {
                private _value = getText(configFile >> "CfgMagazines" >> _x >> "displayName");
                _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
                _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
                _ctrl ctrlSetText format["%1",_value];
                _ctrl ctrlCommit 0;
                (_ctrlGroup getVariable "controls") pushBack _ctrl;
                INC(_idc);
                INCROW;
            } forEach (_magazines);
        } else {
            _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
            _ctrl ctrlSetPosition GUI_DISP_PROP_VAL(_row);
            _ctrl ctrlSetText (localize LSTRING(PROP_NOWEAPONS));
            _ctrl ctrlCommit 0;
            (_ctrlGroup getVariable "controls") pushBack _ctrl;
            INC(_idc);
        };
        INCROW;


        // background
        private _pos = ctrlPosition _ctrlBackground;
        _pos set[3,(GUI_DISP_H*(_row-5))max(getNumber(missionConfigFile >> QAPP(dialog) >> "properties" >> "h"))];
        _ctrlBackground ctrlSetPosition _pos;
        _ctrlBackground ctrlCommit 0;
    };
    case "options" : {
        // spawn as driver
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropSwitch),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*2,
            GUI_DISP_H*5,
            GUI_DISP_W*6,
            GUI_DISP_H*3
        ];
        _ctrl cbSetChecked GVAR(option_spawnAsDriver);
        _ctrl ctrladdEventHandler ["CheckedChanged",{GVAR(option_spawnAsDriver) = (_this select 1) > 0;}];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);

        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*10,
            GUI_DISP_H*4,
            GUI_DISP_PROPW - GUI_DISP_W*12,
            GUI_DISP_H*5
        ];
        _ctrl ctrlSetText (localize LSTRING(PROP_SPAWNASDRIVER));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);


        // spawn empty
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropSwitch),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*2,
            GUI_DISP_H*(5+7),
            GUI_DISP_W*6,
            GUI_DISP_H*3
        ];
        _ctrl cbSetChecked GVAR(option_spawnEmtpy);
        _ctrl ctrladdEventHandler ["CheckedChanged",{GVAR(option_spawnEmtpy) = (_this select 1) > 0;}];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);

        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*10,
            GUI_DISP_H*(4+7),
            GUI_DISP_PROPW - GUI_DISP_W*12,
            GUI_DISP_H*5
        ];
        _ctrl ctrlSetText (localize LSTRING(PROP_SPAWNEMPTY));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);


        // remove spare parts (ace)
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropSwitch),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*2,
            GUI_DISP_H*(5+14),
            GUI_DISP_W*6,
            GUI_DISP_H*3
        ];
        _ctrl cbSetChecked GVAR(option_noSpareParts);
        _ctrl ctrladdEventHandler ["CheckedChanged",{GVAR(option_noSpareParts) = (_this select 1) > 0;}];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*10,
            GUI_DISP_H*(4+14),
            GUI_DISP_PROPW - GUI_DISP_W*12,
            GUI_DISP_H*5
        ];
        _ctrl ctrlSetText (localize LSTRING(PROP_NOSPAREPARTS));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);


        // spawn without Ammo
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropSwitch),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*2,
            GUI_DISP_H*(5+21),
            GUI_DISP_W*6,
            GUI_DISP_H*3
        ];
        _ctrl cbSetChecked GVAR(option_noAmmo);
        _ctrl ctrladdEventHandler ["CheckedChanged",{GVAR(option_noAmmo) = (_this select 1) > 0;}];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);

        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*10,
            GUI_DISP_H*(4+21),
            GUI_DISP_PROPW - GUI_DISP_W*12,
            GUI_DISP_H*5
        ];
        _ctrl ctrlSetText (localize LSTRING(PROP_NOAMMO));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);


        // Open ACE3 Pylon Dialog
        private _ctrl = _display ctrlCreate [QRSC(SpawnPropSwitch),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*2,
            GUI_DISP_H*(5+28),
            GUI_DISP_W*6,
            GUI_DISP_H*3
        ];
        _ctrl cbSetChecked GVAR(option_openPylon);
        _ctrl ctrladdEventHandler ["CheckedChanged",{GVAR(option_openPylon) = (_this select 1) > 0;}];
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);

        _ctrl = _display ctrlCreate [QRSC(SpawnPropText),_idc,_ctrlGroup];
        _ctrl ctrlSetPosition [
            GUI_DISP_W*10,
            GUI_DISP_H*(4+28),
            GUI_DISP_PROPW - GUI_DISP_W*12,
            GUI_DISP_H*5
        ];
        _ctrl ctrlSetText (localize LSTRING(PROP_OPENPYLON));
        _ctrl ctrlCommit 0;
        (_ctrlGroup getVariable "controls") pushBack _ctrl;
        INC(_idc);
    };
};
