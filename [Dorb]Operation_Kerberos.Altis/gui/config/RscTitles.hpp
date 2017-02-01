/*
Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class RscTitles {
    class APP(message_1) {
        idd = IDD_MSG_MESSAGE_1;
        x = GUI_MSG_X;
        y = GUI_MSG_Y;
        w = GUI_MSG_W;
        h = GUI_MSG_H;
        fade = 1;
        duration = 15;
        onLoad = QUOTE(with missionnameSpace do {disableSerialization; GVAR(msg_cur) - [_this select 0];GVAR(msg_cur) pushBack (_this select 0);};); /// pushbackunique is wrong at this point -> the new control needs to be at the last position
        class controls {
            class background : RSC(BaseText) {
                idc = IDC_MSG_background;
                x = GUI_MSG_X;
                y = GUI_MSG_Y;
                w = GUI_MSG_W;
                h = GUI_MSG_H;
                colorBackground[] = COLOR_MSG_BACKGROUND;
                text = "";
            };
            class stripe : RSC(BaseText) {
                idc = IDC_MSG_stripe;
                x = GUI_MSG_X;
                y = GUI_MSG_Y;
                w = GUI_MSG_COL;
                h = GUI_MSG_HEAD + GUI_MSG_TEXT;
                colorBackground[]   = {RAL6018,1};
                text = "";
            };
            class header : RSC(BaseStructuredText) {
                idc = IDC_MSG_header;
                x = GUI_MSG_X + GUI_MSG_COL;
                y = GUI_MSG_Y;
                w = GUI_MSG_W;
                h = GUI_MSG_HEAD;
                text = "ERROR: No Header";
                shadow = 0;
                colorBackground[] = {0,0,0,0};
                colorText[] = { RAL7047 ,1};
                class Attributes : Attributes {
                    shadow = 0;
                    font = GUI_FONT_BOLD;
                    align = "left";
                    valign = "top";
                };
            };
            class content : RSC(BaseStructuredText) {
                idc = IDC_MSG_content;
                x = GUI_MSG_X + GUI_MSG_COL;
                y = (GUI_MSG_Y + GUI_MSG_HEAD);
                w = GUI_MSG_W;
                h = GUI_MSG_TEXT;
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
    class APP(message_2) : APP(message_1) {idd = IDD_MSG_MESSAGE_2;};
    class APP(message_3) : APP(message_1) {idd = IDD_MSG_MESSAGE_3;};
    class APP(message_4) : APP(message_1) {idd = IDD_MSG_MESSAGE_4;};
    class APP(message_5) : APP(message_1) {idd = IDD_MSG_MESSAGE_5;};
    class APP(message_6) : APP(message_1) {idd = IDD_MSG_MESSAGE_6;};
    class APP(message_7) : APP(message_1) {idd = IDD_MSG_MESSAGE_7;};
    class APP(message_8) : APP(message_1) {idd = IDD_MSG_MESSAGE_8;};
    class APP(message_9) : APP(message_1) {idd = IDD_MSG_MESSAGE_9;};

    class APP(timer) {
        duration = 61;
        idd = IDD_TIMER;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(timer)', _this select 0)];);
        class controlsBackground {
            class header : RSC(BaseText) {
                text = "";
                idc = IDD_TIMER_TEXT;
                sizeEx = GUI_GRID_H;
                style = ST_CENTER;
                x = safeZoneX + safeZoneW - (safeZoneW * 0.032);
                y = safeZoneY + safezoneH * 0.19;
                w = GUI_GRID_W * 1.2;
                h = GUI_GRID_H * 1.2;
                colorText[] = UI_CL_BODY_TEXT;
                colorBackground[] = UI_CL_BODY;
            };
        };
    };
    class APP(progressbar) {
        duration = 1e+011;
        idd = IDD_PROGRESSBAR;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(progressbar)', _this select 0)];);
        class controls {
            class Progress {
                idc = IDC_PROGRESSBAR_BAR;
                type = 8;
                style = 0;
                colorFrame[] = UI_CL_BODY_TEXT;
                colorBar[] = UI_CL_BODY;
                texture = "#(argb,8,8,3)color(1,1,1,1)";
                x = GUI_GRID_X + GUI_GRID_WAbs * 0.1;
                y = GUI_GRID_Y;
                w = GUI_GRID_WAbs * 0.8;
                h = GUI_GRID_H * 0.5;
            };
        };
    };
    class APP(loadingbar) {
        duration = 1e+011;
        idd = IDD_LOADINGBAR;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(loadingbar)', _this select 0)];);
        class controls {
            class backGround : RSC(BaseText) {
                idc = -1;
                x = GUI_LOADINGBAR_X;
                y = GUI_LOADINGBAR_Y;
                w = GUI_LOADINGBAR_W;
                h = GUI_LOADINGBAR_H;
            };
            class header : RSC(BaseText) {
                idc = IDC_LOADINGBAR_HEADER;
                x = GUI_LOADINGBAR_HEADER_X;
                y = GUI_LOADINGBAR_HEADER_Y;
                w = GUI_LOADINGBAR_HEADER_W;
                h = GUI_LOADINGBAR_HEADER_H;
                sizeEx = 1.2 * GUI_GRID_H;
                text = CSTRING(LOADINGBAR);
            };
            class symbol : RSC(BasePicture) {
                idc = IDC_LOADINGBAR_SYMBOL;
                x = GUI_LOADINGBAR_SYMBOL_X;
                y = GUI_LOADINGBAR_SYMBOL_Y;
                w = GUI_LOADINGBAR_SYMBOL_W;
                h = GUI_LOADINGBAR_SYMBOL_H;
                text = "a3\ui_f\data\igui\cfg\simpletasks\types\download_ca.paa";
            };
            class progress : RSC(BaseLoadingbar) {
                idc = IDC_LOADINGBAR_BAR;
                x = GUI_LOADINGBAR_BAR_X;
                y = GUI_LOADINGBAR_BAR_Y;
                w = GUI_LOADINGBAR_BAR_W;
                h = GUI_LOADINGBAR_BAR_H;
                colorFrame[] = COLOR_BACKGROUND;
                texture = QPAAPATH(progressbar_texture);
            };
            class arrow : RSC(BasePicture) {
                idc = IDC_LOADINGBAR_ARROW;
                x = GUI_LOADINGBAR_ARROW_X;
                y = GUI_LOADINGBAR_ARROW_Y;
                w = GUI_LOADINGBAR_ARROW_W;
                h = GUI_LOADINGBAR_ARROW_H;
                text = "a3\ui_f\data\gui\rsc\rscdisplaydlccontentbrowser\platform_ca.paa";
            };
            class state : RSC(BaseText) {
                idc = IDC_LOADINGBAR_STATE;
                x = GUI_LOADINGBAR_STATE_X;
                y = GUI_LOADINGBAR_STATE_Y;
                w = GUI_LOADINGBAR_STATE_W;
                h = GUI_LOADINGBAR_STATE_H;
                sizeEx = 0.6  * GUI_GRID_H;
                text = "0 %";
                style = "0x01";
                colorText[] = COLOR_BACKGROUND;
                colorBackground[] = COLOR_DISABLED;
            };
        };
    };
};
