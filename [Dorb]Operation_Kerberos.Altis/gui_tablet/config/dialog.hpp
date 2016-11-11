/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class RSC(tabletBase) {
    idd = IDD_TABLET_MAIN;
    name = "Echnida";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE( uiNamespace setVariable [ARR_2('GVAR(dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); [] spawn EFUNC(gui_tablet,OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur););

    controlsBackground[] =     {
        background_Picture,
        background_Display,
        background_Header
    };

    controls[] =    {
        clock,
        notifications
    };

    class background_picture: RSC(BasePicture) {
        x = GUI_GRID_CENTER_X - GUI_GRID_CENTER_W * 5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 12.5 - GUI_GRID_CENTER_W * 25 - GUI_GRID_CENTER_H;
        w = GUI_GRID_CENTER_W * 50;
        h = GUI_GRID_CENTER_W * 50;
    };
    class background_Display: RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 25;
        text = "";
        colorBackground[] = COLOR_TABLET_BACKGROUND;
        colorText[] = COLOR_TABLET_MAIN_TEXT;
    };
    class background_header: RSC(BaseText) {
        y = GUI_GRID_CENTER_Y - GUI_GRID_CENTER_H * 4.5;
        h = GUI_GRID_CENTER_H * 2;
    };

    class clock: background_header {
        idc = IDC_TABLET_TOPBAR_CLOCK;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 35;
        w = GUI_GRID_CENTER_W * 5;
    };
    class notifications: RSC(BaseStructuredText) {
        idc = IDC_TABLET_TOPBAR_NOTIFICATIONS;
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y - GUI_GRID_CENTER_H * 4.5;
        w = GUI_GRID_CENTER_W * 5;
        h = GUI_GRID_CENTER_H * 2;
    };
};

class APP(dialog) : RSC(tabletBase) {

    controlsBackground[] =     {
        background_Picture,
        background_Display,
        background_Header
    };

    controls[] =    {
        clock,
        notifications,
        Button_1,
        Button_2,
        Button_3,
        Button_4,
        Button_5,
        Button_6,
        Button_7,
        Button_8,
        Button_9,
        Button_10,
        Button_11,
        Button_12,
        Button_13,
        Button_14,
        Button_15,
        Button_16,
        Button_17,
        Button_18,
        Button_19,
        Button_20,
        Button_21,
        Button_22,
        Button_23,
        Button_24,
        Button_25,
        Button_26,
        Button_27,
        Button_28
    };

    class Button_1 : RSC(BaseButton) {
        idc = IDC_TABLET_BTTN1;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        sizeEx = GUI_GRID_CENTER_H;
        text = "";
        colorBackground[] = COLOR_TABLET_MAIN_BTTN;
        colorBackgroundActive[] = COLOR_TABLET_MAIN_BTTN_SELECTED;
        colorFocused[] = COLOR_TABLET_MAIN_BTTN;
        colorText[] = COLOR_TABLET_MAIN_BTTN_TEXT;
    };
    /*
    class Button_1 : RSC(BaseShortcutButton) {
        idc = IDC_TABLET_BTTN1;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        sizeEx = GUI_GRID_CENTER_H;
        text = "";
        colorDisabled[] = COLOR_DISABLED;
        colorBackground[] = COLOR_TABLET_MAIN_BTTN;
        colorBackground2[] = COLOR_TABLET_MAIN_BTTN;
        color[] = COLOR_TABLET_MAIN_BTTN;
        color2[] = COLOR_TABLET_MAIN_BTTN;
    };
    */
    class Button_2 : Button_1 {idc = IDC_TABLET_BTTN2;};
    class Button_3 : Button_1 {idc = IDC_TABLET_BTTN3;};
    class Button_4 : Button_1 {idc = IDC_TABLET_BTTN4;};
    class Button_5 : Button_1 {idc = IDC_TABLET_BTTN5;};
    class Button_6 : Button_1 {idc = IDC_TABLET_BTTN6;};
    class Button_7 : Button_1 {idc = IDC_TABLET_BTTN7;};
    class Button_8 : Button_1 {idc = IDC_TABLET_BTTN8;};
    class Button_9 : Button_1 {idc = IDC_TABLET_BTTN9;};
    class Button_10 : Button_1 {idc = IDC_TABLET_BTTN10;};
    class Button_11 : Button_1 {idc = IDC_TABLET_BTTN11;};
    class Button_12 : Button_1 {idc = IDC_TABLET_BTTN12;};
    class Button_13 : Button_1 {idc = IDC_TABLET_BTTN13;};
    class Button_14 : Button_1 {idc = IDC_TABLET_BTTN14;};
    class Button_15 : Button_1 {idc = IDC_TABLET_BTTN15;};
    class Button_16 : Button_1 {idc = IDC_TABLET_BTTN16;};
    class Button_17 : Button_1 {idc = IDC_TABLET_BTTN17;};
    class Button_18 : Button_1 {idc = IDC_TABLET_BTTN18;};
    class Button_19 : Button_1 {idc = IDC_TABLET_BTTN19;};
    class Button_20 : Button_1 {idc = IDC_TABLET_BTTN20;};
    class Button_21 : Button_1 {idc = IDC_TABLET_BTTN21;};
    class Button_22 : Button_1 {idc = IDC_TABLET_BTTN22;};
    class Button_23 : Button_1 {idc = IDC_TABLET_BTTN23;};
    class Button_24 : Button_1 {idc = IDC_TABLET_BTTN24;};
    class Button_25 : Button_1 {idc = IDC_TABLET_BTTN25;};
    class Button_26 : Button_1 {idc = IDC_TABLET_BTTN26;};
    class Button_27 : Button_1 {idc = IDC_TABLET_BTTN27;};
    class Button_28 : Button_1 {idc = IDC_TABLET_BTTN28;};
};
