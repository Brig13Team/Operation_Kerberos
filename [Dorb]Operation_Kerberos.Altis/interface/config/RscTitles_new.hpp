/*
Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class  RscTitles {

    class GVAR(message_1) {
        idd = 770110;
        x = DORB_GUI_MSG_X;
        y = DORB_GUI_MSG_Y;
        w = DORB_GUI_MSG_W;
        h = DORB_GUI_MSG_H;
        fade = 1;
        duration = 15;
        onLoad = QUOTE(with missionnameSpace do {disableSerialization; GVAR(msg_cur) - [_this select 0];GVAR(msg_cur) pushBack (_this select 0);};); /// pushbackunique is wrong at this point -> the new control needs to be at the last position
        class controls {
            class background : dorb2_gui_new_RscText {
                idc = 770111;
                x = DORB_GUI_MSG_X;
                y = DORB_GUI_MSG_Y;
                w = DORB_GUI_MSG_W;
                h = DORB_GUI_MSG_H;
                colorBackground[]   = DORB_GUI_COL_BACKGROUND;
                text = "";
            };
            class stripe : dorb2_gui_new_RscText {
                idc = 770112;
                x = DORB_GUI_MSG_X;
                y = DORB_GUI_MSG_Y;
                w = DORB_GUI_MSG_COL;
                h = DORB_GUI_MSG_HEAD + DORB_GUI_MSG_TEXT;
                colorBackground[]   = {RAL6018,1};
                text = "";
            };
            class header : dorb2_gui_new_RscStructuredText {
                idc = 770113;
                x = DORB_GUI_MSG_X + DORB_GUI_MSG_COL;
                y = DORB_GUI_MSG_Y;
                w = DORB_GUI_MSG_W;
                h = DORB_GUI_MSG_HEAD;
                text = "ERROR: No Header";
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = { RAL7047 ,1};
                class Attributes : Attributes {
                    shadow = 0;
                    font = GUI_FONT_BOLD;
                };
            };
            class content : dorb2_gui_new_RscStructuredText {
                idc = 770114;
                x = DORB_GUI_MSG_X + DORB_GUI_MSG_COL;
                y = (DORB_GUI_MSG_Y + DORB_GUI_MSG_HEAD);
                w = DORB_GUI_MSG_W;
                h = DORB_GUI_MSG_TEXT;
                text = "ERROR: No Text";
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = {RAL7047,1};
                size = GUI_TEXT_SIZE_SMALL;
                class Attributes : Attributes {
                    shadow = 0;
                    font = GUI_FONT_THIN;
                };
            };
        };
    };
    class GVAR(message_2) : GVAR(message_1) {idd = 770120;};
    class GVAR(message_3) : GVAR(message_1) {idd = 770130;};
    class GVAR(message_4) : GVAR(message_1) {idd = 770140;};
    class GVAR(message_5) : GVAR(message_1) {idd = 770150;};
    class GVAR(message_6) : GVAR(message_1) {idd = 770160;};
    class GVAR(message_7) : GVAR(message_1) {idd = 770170;};
    class GVAR(message_8) : GVAR(message_1) {idd = 770180;};
    class GVAR(message_9) : GVAR(message_1) {idd = 770190;};
    
    class GVAR(disp_timer) {
        duration = 61;
        idd = 700103;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(disp_timer)', _this select 0)];);
        class controlsBackground {
            class dorb_disp_header : dorb_gui_backgroundBase {
                text = "";
                idc = 700104;
                sizeEx = GUI_H(0.03);
                style = ST_CENTER;
                x = safeZoneX + safeZoneW - (safeZoneW * 0.032);
                y = safeZoneY + safezoneH * 0.19;
                w = GUI_W(0.03);
                h = GUI_H(0.035);
                colorText[] = UI_CL_BODY_TEXT;
                colorBackground[] = UI_CL_BODY;
            };
        };
    };
    class GVAR(disp_progressbar) {
        duration = 1e+011;
        idd = 700105;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(disp_progressbar)', _this select 0)];);
        class controls {
            class Progress {
                idc=6;
                type = 8;
                style = 0;
                colorFrame[] = UI_CL_BODY_TEXT;
                colorBar[] = UI_CL_BODY;
                texture = "#(argb,8,8,3)color(1,1,1,1)";
                x = safezoneX + safezoneW * 0.3;
                y = safeZoneY + GUI_H(0.1);
                w = safezoneW * 0.4;
                h = GUI_H(0.02);
            };
        };
    };
};