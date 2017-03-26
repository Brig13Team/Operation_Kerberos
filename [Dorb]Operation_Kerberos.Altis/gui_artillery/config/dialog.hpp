/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    controlsBackground[] = {
        background_taskbar,
        background_display
    };
    controls[] = {
        clock,
        menu_button,

        artilleryProperties,
        shootingLocation,
        shootingparameter,
        network,
        FIRE_bttn,

        metro_back,
        metro,
        metro_side,
        background_device
    };
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    class background_display : background_display {
        idc = -1;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        colorBackground[] = {RAL9017,1};
    };
    class artilleryProperties : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_PROPERTIES;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 0.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 26.5;
        class controlsBackground {
            class artilleryData_bgrd : RSC(BaseText) {
                idc = -1;
                x = 0;
                y = 0;
                w = GUI_ECHIDNA_W * 10;
                h = GUI_ECHIDNA_H * 13;
                colorBackground[] = {RAL9017,1};
            };
            class ammunitionData_bgrd : artilleryData_bgrd {
                x = 0;
                y = GUI_ECHIDNA_H * 13.5;
                w = GUI_ECHIDNA_W * 10;
                h = GUI_ECHIDNA_H * 13;
            };
        };
        class objects {};
        class controls {
            class artilleryData : RSC(BaseListboxN) {
                idc = IDC_ARTILLERY_PROPERTIES_ARTILLERY;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 9;
                h = GUI_ECHIDNA_H * 12;
            };
            class ammunitionData : RSC(BaseListboxN) {
                idc = IDC_ARTILLERY_PROPERTIES_AMMUNITION;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 14;
                w = GUI_ECHIDNA_W * 9;
                h = GUI_ECHIDNA_H * 12;
                onMouseEnter = "systemChat str ['onMouseEnter',_this]; false";
            };
        };
    };

    class shootingLocation : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_LOCATION;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 11;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 18;
        h = GUI_ECHIDNA_H * 7.5;
        class controlsBackground {
            class background: RSC(BaseText) {
                idc = -1;
                x = 0;
                y = 0;
                w = GUI_ECHIDNA_W * 18;
                h = GUI_ECHIDNA_H * 7.5;
                colorBackground[] = {RAL9017,1};
            };
        };
        class objects {};
        class controls {
            class useCurrent_check : RSC(BaseCheckBox) {
                idc = IDC_ARTILLERY_LOCATION_USECURRENT;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 1;
                h = GUI_ECHIDNA_H * 1;
                checked=0;
            };
            class useCurrent_name : RSC(BaseText) {
                x = GUI_ECHIDNA_W * 2;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 15;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(location_use);
            };
            class easting_name : RSC(BaseText) {
                idc = -IDC_ARTILLERY_LOCATION_EAST;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 3;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(location_east);
            };
            class easting_edit : RSC(BaseEdit) {
                idc = IDC_ARTILLERY_LOCATION_EAST;
                x = GUI_ECHIDNA_W * 9;
                y = GUI_ECHIDNA_H * 3;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
                text = "0000";
            };
            class northing_name : easting_name {
                idc = -IDC_ARTILLERY_LOCATION_NORTH;
                y = GUI_ECHIDNA_H * 4.5;
            };
            class northing_edit : easting_edit {
                idc = IDC_ARTILLERY_LOCATION_NORTH;
                y = GUI_ECHIDNA_H * 4.5;
                text = "0000";
            };
            class altitude_name : easting_name {
                idc = -IDC_ARTILLERY_LOCATION_ALT;
                y = GUI_ECHIDNA_H * 6;
                text = CSTRING(location_altitude);
            };
            class altitude_edit : easting_edit {
                idc = IDC_ARTILLERY_LOCATION_ALT;
                y = GUI_ECHIDNA_H * 6;
                text = "0000";
            };
        };
    };
    class shootingparameter : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_PARAMS;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 11;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 18;
        h = GUI_ECHIDNA_H * 7.5;
        class controlsBackground {
            class background: RSC(BaseText) {
                idc = IDC_ARTILLERY_PARAMS;
                x = 0;
                y = 0;
                w = GUI_ECHIDNA_W * 18;
                h = GUI_ECHIDNA_H * 7.5;
            };
        };
        class objects {};
        class controls {
            class mil_name : RSC(BaseText) {
                idc = -IDC_ARTILLERY_PARAMS_MILS;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(mils);
            };
            class mil_edit : RSC(BaseEdit) {
                idc = IDC_ARTILLERY_PARAMS_MILS;
                x = GUI_ECHIDNA_W * 9;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
                text = "1000";
            };
            class elevation_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_ELEVATION;
                y = GUI_ECHIDNA_H * 2;
                text = CSTRING(elevation);
            };
            class elevation_edit : mil_edit {
                idc = IDC_ARTILLERY_PARAMS_ELEVATION;
                y = GUI_ECHIDNA_H * 2;
                text = "45";
            };
            class ammunition_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_AMMO;
                y = GUI_ECHIDNA_H * 3.5;
                text = CSTRING(ammo);
            };
            class ammunition_combo : RSC(BaseCombo) {
                idc = IDC_ARTILLERY_PARAMS_AMMO;
                y = GUI_ECHIDNA_H * 3.5;
            };
            class charge_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_CHARGE;
                y = GUI_ECHIDNA_H * 5;
                text = CSTRING(charge);
            };
            class charge_combo : RSC(BaseCombo) {
                idc = IDC_ARTILLERY_PARAMS_CHARGE;
                y = GUI_ECHIDNA_H * 5;
            };
            class fuze_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_FUZE;
                y = GUI_ECHIDNA_H * 6.5;
                text = CSTRING(ammo);
            };
            class fuze_combo : RSC(BaseCombo) {
                idc = IDC_ARTILLERY_PARAMS_FUZE;
                y = GUI_ECHIDNA_H * 6.5;
            };
        };
    };
    class network : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_NETWORK;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 29.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 19;
        class controlsBackground {
            class background: RSC(BaseText) {
                x = 0;
                y = 0;
                w = GUI_ECHIDNA_W * 10;
                h = GUI_ECHIDNA_H * 19;
                colorBackground[] = {RAL9017,1};
            };
        };
        class objects {};
        class controls {
            class network_name : RSC(BaseText) {
                x = GUI_ECHIDNA_W * 2;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 6;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(network);
            };
            class network_checkbox : RSC(BaseCheckbox) {
                idc = IDC_ARTILLERY_NETWORK_CONNECT;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 1;
                h = GUI_ECHIDNA_H * 1;
                text = "1000";
            };
            class artilleryID_name : RSC(BaseText) {
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 2;
                w = GUI_ECHIDNA_W * 5;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(networkID);
            };
            class artilleryID_edit : RSC(BaseEdit) {
                idc = IDC_ARTILLERY_NETWORK_ID;
                x = GUI_ECHIDNA_W * 5.5;
                y = GUI_ECHIDNA_H * 2;
                w = GUI_ECHIDNA_W * 4;
                h = GUI_ECHIDNA_H * 1;
                text = "XX-0000";
                canModify=0;
            };
            class orderList : RSC(BaseListboxN) {
                idc = IDC_ARTILLERY_NETWORK_ORDERLIST;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 3.5;
                w = GUI_ECHIDNA_W * 9;
                h = GUI_ECHIDNA_H * 10;
            };
            class add_bttn : RSC(BaseButton) {
                idc = IDC_ARTILLERY_NETWORK_ADD;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 17;
                w = GUI_ECHIDNA_W * 2.5;
                h = GUI_ECHIDNA_H * 1.5;
            };
            class delete_bttn : add_bttn {
                idc = IDC_ARTILLERY_NETWORK_DELETE;
                x = GUI_ECHIDNA_W * 3.25;
            };
            class use_bttn : delete_bttn {
                idc = IDC_ARTILLERY_NETWORK_USE;
                x = GUI_ECHIDNA_W * 6;
            };
        };
    };
    class FIRE_bttn : RSC(BaseButton) {
        idc = IDC_ARTILLERY_FIRE;
        text = CSTRING(FIRE);
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 22;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 24;
        w = GUI_ECHIDNA_W * 6;
        h = GUI_ECHIDNA_H * 3;
    };
};
