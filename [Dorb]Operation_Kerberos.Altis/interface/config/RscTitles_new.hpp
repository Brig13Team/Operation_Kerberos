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
			class header : dorb2_gui_new_RscStructuredText {
				idc = 770111;
				x = DORB_GUI_MSG_X;
				y = DORB_GUI_MSG_Y;
				w = DORB_GUI_MSG_W;
				h = DORB_GUI_MSG_HEAD;
				text = "TestHeader";
				shadow = 0;
				colorBackground[] = DORB_GUI_COL_BACKGROUND;
				colorText[] = { RAL7047 ,1};
				class Attributes : Attributes {
					shadow = 0;
					align = "center";
				};
			};
			class divider : dorb2_gui_new_RscText {
				idc = 770112;
				x = DORB_GUI_MSG_X;
				y = (DORB_GUI_MSG_Y + DORB_GUI_MSG_HEAD);
				w = DORB_GUI_MSG_W;
				h = DORB_GUI_MSG_COL;
				colorBackground[]	= {RAL6018,1};
			};
			class content : dorb2_gui_new_RscStructuredText {
				idc = 770113;
				x = DORB_GUI_MSG_X;
				y = (DORB_GUI_MSG_Y + DORB_GUI_MSG_HEAD + DORB_GUI_MSG_COL);
				w = DORB_GUI_MSG_W;
				h = DORB_GUI_MSG_TEXT;
				text = "Hier kann Text erscheinen";
				shadow = 0;
				colorBackground[] = DORB_GUI_COL_BACKGROUND;
				colorText[] = {RAL7047,1};
				size = GUI_TEXT_SIZE_SMALL;
				class Attributes : Attributes {
					shadow = 0;
				};
			};
		};
	};
	class GVAR(message_2) : GVAR(message_1) {
		idd = 770120;};
	class GVAR(message_3) : GVAR(message_1) {idd = 770130;};
	class GVAR(message_4) : GVAR(message_1) {idd = 770140;};
	class GVAR(message_5) : GVAR(message_1) {idd = 770150;};
	class GVAR(message_6) : GVAR(message_1) {idd = 770160;};
	class GVAR(message_7) : GVAR(message_1) {idd = 770170;};
	class GVAR(message_8) : GVAR(message_1) {idd = 770180;};
	class GVAR(message_9) : GVAR(message_1) {idd = 770190;};
	
    class GVAR(disp_msg) {
        duration = 20;
        idd = 700100;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(disp_msg)', _this select 0)];);
        class controlsBackground {
            class dorb_disp_header : dorb_gui_backgroundBase {
                text = "";
                idc = 700101;
                sizeEx = GUI_H(0.03);
                style = ST_LEFT;
                x = safezoneX + safezoneW * 0.05;
                y = safeZoneY + safezoneH * 0.2;
                w = GUI_W(0.13);
                h = GUI_H(0.035);
                colorText[] = UI_CL_HEADER_TEXT;
                colorBackground[] = UI_CL_HEADER;
            };
            class content: dorb_disp_header {
                idc = 700102;
                y = safeZoneY + safezoneH * 0.2 + GUI_H(0.040);
                sizeEx = GUI_H(0.025);
                colorText[] = UI_CL_BODY_TEXT;
                colorBackground[] = UI_CL_BODY;
            };
        };
    };
    class GVAR(disp_info) {
        duration = 20;
        idd = 700106;
        movingenable = 0;
        onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(disp_info)', _this select 0)];);
        class controlsBackground {
            class dorb_disp_header : dorb_gui_backgroundBase {
                text = "";
                idc = 700109;
                sizeEx = GUI_H(0.03);
                style = ST_LEFT;
                x = safezoneX + safezoneW * 0.05;
                y = safeZoneY + safezoneH * 0.41;
                w = GUI_W(0.13);
                h = GUI_H(0.035);
                colorText[] = UI_CL_HEADER_TEXT;
                colorBackground[] = UI_CL_HEADER;
            };
            class icon_body: dorb_disp_header {
                idc = 700107;
                x = safezoneX + safezoneW * 0.05;
                y = safeZoneY + safezoneH * 0.26;
                w = GUI_W(0.13);
                h = GUI_H(0.15);
                colorText[] = UI_CL_BODY_TEXT;
                colorBackground[] = UI_CL_BODY;
            };
            class icon : dorb_gui_pictureBase{
                idc = 700108;
                text = "";
                style = 48;
                x = safezoneX + safezoneW * 0.06;
                y = safeZoneY + safezoneH * 0.27;
                w = GUI_W(0.10);
                h = GUI_H(0.13);
                colorText[] = UI_CL_HEADER_TEXT;
                colorBackground[] = UI_CL_BODY;
            };
            class content: dorb_disp_header {
                idc = 700110;
                sizeEx = GUI_H(0.025);
                colorText[] = UI_CL_BODY_TEXT;
                colorBackground[] = UI_CL_BODY;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.040);
                style = ST_LEFT;
            };
            class content2: content {
                idc = 700111;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.077);
            };
            class content3: content {
                idc = 700112;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.114);
            };
            class content4: content {
                idc = 700113;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.151);
            };
            class content5: content {
                idc = 700114;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.188);
            };
            class content6: content {
                idc = 700115;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.225);
            };
            class content7: content {
                idc = 700116;
                y = safeZoneY + safezoneH * 0.41 + GUI_H(0.262);
            };
        };
    };
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