/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

#define ARTILLERY_BACKGROUND {RAL7015,1}
#define ARTILLERY_BACKGROUND_CONTENT {RAL9011,1}

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    controlsBackground[] = {
        background_taskbar,
        background_display,
        artilleryProperties_bgrd,
        artilleryProperties_bgrd2,
        shootingLocation_bgrd,
        shootingparameter_bgrd,
        network_bgrd
    };
    controls[] = {
        clock,
        menu_button,

        artilleryProperties,
        shootingLocation,
        shootingparameter,
        network,
        FIRE_bttn,
        time,

        metro_back,
        metro,
        metro_side,
        background_device
    };
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad); [ARR_2('display',_this select 0)] call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    class background_display : background_display {
        idc = -1;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        colorBackground[] = ARTILLERY_BACKGROUND;
    };
    class artilleryProperties_bgrd : RSC(BaseText) {
        idc = -1;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 0.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 13;
        colorBackground[] = ARTILLERY_BACKGROUND_CONTENT;
    };
    class artilleryProperties_bgrd2 : artilleryProperties_bgrd {
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 14;
    };
    class shootingLocation_bgrd: artilleryProperties_bgrd {
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 11;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 18;
        h = GUI_ECHIDNA_H * 7.5;
    };
    class shootingparameter_bgrd: artilleryProperties_bgrd {
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 11;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 11;
        w = GUI_ECHIDNA_W * 18;
        h = GUI_ECHIDNA_H * 9.5;
    };
    class network_bgrd: artilleryProperties_bgrd {
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 29.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 2;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 19;
    };



    class artilleryProperties : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_PROPERTIES;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 0.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 26.5;
        class controls {
            class artilleryData : RSC(BaseListboxN) {
                idc = IDC_ARTILLERY_PROPERTIES_ARTILLERY;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 9;
                h = GUI_ECHIDNA_H * 12;
                columns[] = {-0.01,0.6};
                onLoad = QUOTE([ARR_2('artillerydata',_this select 0)] call FUNC(OnLoad););
            };
            class ammunitionData : RSC(BaseListboxN) {
                idc = IDC_ARTILLERY_PROPERTIES_AMMUNITION;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 14;
                w = GUI_ECHIDNA_W * 9;
                h = GUI_ECHIDNA_H * 12;
                columns[] = {-0.01,0.6};
                onLoad = QUOTE([ARR_2('ammunitiondata',_this select 0)] call FUNC(OnLoad););
            };
        };
    };

    class shootingLocation : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_LOCATION;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 11;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 18;
        h = GUI_ECHIDNA_H * 7.5;
        class controls {
            class useCurrent_check : RSC(BaseCheckBox) {
                idc = IDC_ARTILLERY_LOCATION_USECURRENT;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 1;
                h = GUI_ECHIDNA_H * 1;
                checked=0;
                onLoad = QUOTE([ARR_2('useCurrent',_this select 0)] call FUNC(OnLoad););
                onCheckedChanged = QUOTE(_this call FUNC(onCheckedChangedLoc));
            };
            class useCurrent_name : RSC(BaseText) {
                idc = -IDC_ARTILLERY_LOCATION_USECURRENT;
                x = GUI_ECHIDNA_W * 2;
                y = GUI_ECHIDNA_H * 1.5;
                w = GUI_ECHIDNA_W * 16;
                h = GUI_ECHIDNA_H * 2;
                //text = CSTRING(LOCATION_USE);
                test = "ASdasd";
                style = "0x00";
            };
            class easting_name : RSC(BaseText) {
                idc = -IDC_ARTILLERY_LOCATION_EAST;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 3;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(location_east);
                style = "0x01";
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
                text = CSTRING(location_north);
            };
            class northing_edit : easting_edit {
                idc = IDC_ARTILLERY_LOCATION_NORTH;
                y = GUI_ECHIDNA_H * 4.5;
                text = "0000";
            };
            class altitude_name : easting_name {
                idc = -IDC_ARTILLERY_LOCATION_ALT;
                y = GUI_ECHIDNA_H * 6;
                text = CSTRING(location_alt);
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
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 11;
        w = GUI_ECHIDNA_W * 18;
        h = GUI_ECHIDNA_H * 9.5;
        class controls {
            class mil_name : RSC(BaseText) {
                idc = -IDC_ARTILLERY_PARAMS_MILS;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(mils);
                style = "0x01";
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
            class ammunition_combo : RSC(BaseComboBox) {
                idc = IDC_ARTILLERY_PARAMS_AMMO;
                x = GUI_ECHIDNA_W * 9;
                y = GUI_ECHIDNA_H * 3.5;
                w = GUI_ECHIDNA_W * 8;
                h = GUI_ECHIDNA_H * 1;
            };
            class charge_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_CHARGE;
                y = GUI_ECHIDNA_H * 5;
                text = CSTRING(charge);
            };
            class charge_combo : ammunition_combo {
                idc = IDC_ARTILLERY_PARAMS_CHARGE;
                y = GUI_ECHIDNA_H * 5;
            };
            class fuze_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_FUZE;
                y = GUI_ECHIDNA_H * 6.5;
                text = CSTRING(fuze);
            };
            class fuze_combo : ammunition_combo {
                idc = IDC_ARTILLERY_PARAMS_FUZE;
                y = GUI_ECHIDNA_H * 6.5;
            };
            class tts_name : mil_name {
                idc = -IDC_ARTILLERY_PARAMS_TTS;
                y = GUI_ECHIDNA_H * 8;
                text = CSTRING(tts);
            };
            class tts_combo : mil_edit {
                idc = IDC_ARTILLERY_PARAMS_FUZE;
                y = GUI_ECHIDNA_H * 8;
            };
        };
    };
    class network : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ARTILLERY_NETWORK;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 29.5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 2;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 19;
        class controls {
            class network_name : RSC(BaseText) {
                x = GUI_ECHIDNA_W * 2;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 6;
                h = GUI_ECHIDNA_H * 1;
                text = CSTRING(network);
                style = "0x01";
            };
            class network_checkbox : RSC(BaseCheckbox) {
                idc = IDC_ARTILLERY_NETWORK_CONNECT;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 0.5;
                w = GUI_ECHIDNA_W * 1;
                h = GUI_ECHIDNA_H * 1;
                onLoad = QUOTE([ARR_2('network',_this select 0)] call FUNC(OnLoad););
                onCheckedChanged = QUOTE(_this call FUNC(onCheckedChangedNet));
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
                //onLoad = QUOTE([ARR_2('networkID',_this select 0)] call FUNC(OnLoad););
            };
            class orderList : RSC(BaseListboxN) {
                idc = IDC_ARTILLERY_NETWORK_ORDERLIST;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 3.5;
                w = GUI_ECHIDNA_W * 9;
                h = GUI_ECHIDNA_H * 10;
                columns[] = {-0.01,0.6};
                onLoad = QUOTE([ARR_2('orderlist',_this select 0)] call FUNC(OnLoad););
            };
            class add_bttn : RSC(BaseButton) {
                idc = IDC_ARTILLERY_NETWORK_ADD;
                x = GUI_ECHIDNA_W * 0.5;
                y = GUI_ECHIDNA_H * 17;
                w = GUI_ECHIDNA_W * 2.5;
                h = GUI_ECHIDNA_H * 1.5;
                text = CSTRING(NETWORK_ADD);
                onButtonClick = QUOTE(_this call FUNC(addOrder);true);
            };
            class delete_bttn : add_bttn {
                idc = IDC_ARTILLERY_NETWORK_DELETE;
                x = GUI_ECHIDNA_W * 3.25;
                text = CSTRING(NETWORK_DEL);
                onButtonClick = QUOTE(_this call FUNC(deleteOrder);true);
            };
            class use_bttn : delete_bttn {
                idc = IDC_ARTILLERY_NETWORK_USE;
                x = GUI_ECHIDNA_W * 6;
                text = CSTRING(NETWORK_USE);
                onButtonClick = QUOTE(_this call FUNC(useOrder);true);
            };
        };
    };
    class time: RSC(BaseText) {
        idc = IDC_ARTILLERY_TIME;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 30;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 0.5;
        w = GUI_ECHIDNA_W * 9;
        h = GUI_ECHIDNA_H * 1;
        text = "0000-00";
        style = "0x01";
    };
    class FIRE_bttn : RSC(BaseButton) {
        idc = IDC_ARTILLERY_FIRE;
        text = CSTRING(FIRE);
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 32;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 24;
        w = GUI_ECHIDNA_W * 6;
        h = GUI_ECHIDNA_H * 3;
    };
};
