/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class RSC(BaseEchnida) {
    idd = IDD_ECHNIDA_MAIN;
    name = "Echnida";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE( uiNamespace setVariable [ARR_2('EGVAR(gui_echnida,dialog)',_this select 0)]; [ARR_2('EGVAR(gui_echnida,dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad););
    onUnload = QUOTE([ARR_2('EGVAR(gui_echnida,dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_echnida,OnUnLoad););

    controlsBackground[] = {};

    controls[] = {
        background_device,
        background_display,
        background_logo,
        background_taskbar,
        clock,
        menu_button
    };

    class background_device: RSC(BasePicture) {
        idc = IDC_ECHNIDA_BACKGROUND_DEVICE;
        x = GUI_ECHIDNA_X - GUI_ECHIDNA_W * 7;
        y = GUI_ECHIDNA_Y - GUI_ECHIDNA_H * 12.03;
        w = GUI_ECHIDNA_WAbs + GUI_ECHIDNA_W * 14;
        h = GUI_ECHIDNA_HAbs + GUI_ECHIDNA_H * 24;
        text = QEPAAPATH(echidna,background_tablet);
        style = "48";
    };
    class background_display: RSC(BaseText) {
        idc = IDC_ECHNIDA_BACKGROUND_DISPLAY;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        text = "";
        colorBackground[] = COLOR_ECHIDNA_DISPLAY_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_DISPLAY_TEXT;
    };
    class background_logo: RSC(BasePicture) {
        idc = IDC_ECHNIDA_BACKGROUND_LOGO;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        text = QEPAAPATH(logo,logo_512w);
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_ECHIDNA_DISPLAY_LOGO;
    };
    class background_taskbar: RSC(BaseText) {
        idc = IDC_ECHNIDA_BACKGROUND_TASKBAR;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 27.5;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 2.5;
        colorBackground[] = COLOR_ECHIDNA_TASKBAR_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_TASKBAR_TEXT;
    };

    class clock: RSC(BaseStructuredText) {
        idc = IDC_ECHNIDA_TASKBAR_CLOCK;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_WAbs - GUI_ECHIDNA_W * 5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 27.5;
        w = GUI_ECHIDNA_W * 4;
        h = GUI_ECHIDNA_H * 2;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_ECHIDNA_TASKBAR_TEXT;
        style = "0x02";
        size = GUI_ECHIDNA_H * 0.9;
        text = "";
        class attributes : attributes {
            align = "center";
            size = GUI_ECHIDNA_H * 0.9;
        };
    };
    class menu_button: RSC(BaseButton) {
        idc = IDC_ECHNIDA_TASKBAR_MENU_BUTTON;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 27.5;
        w = GUI_ECHIDNA_W * 2.5;
        h = GUI_ECHIDNA_H * 2.5;
        style = "48+0x800";
        sizeEx = GUI_ECHIDNA_H * 1.5;
        text = "";
        colorBackground[] = COLOR_ECHIDNA_TASKBAR_BACKGROUND;
        colorBackgroundActive[] = COLOR_ECHIDNA_TASKBAR_BACKGROUND;
        colorFocused[] = COLOR_ECHIDNA_TASKBAR_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_TASKBAR_TEXT;
        colorDisabled[] = COLOR_DISABLED;
        colorBackgroundDisabled[] = COLOR_DISABLED;
        onButtonClick = QUOTE(_this call FUNC(openMetro););
        offsetX = 0;
        offsetY = 0;
        offsetPressedX = 0;
        offsetPressedY = 0;
    };
};

class APP(dialog) : RSC(BaseEchnida) {
    controls[] = {
        background_display,
        background_logo,
        background_taskbar,
        clock,
        menu_button,
        metro_back,
        metro,
        metro_side,
        background_device
    };
    class metro_back: RSC(BaseText) {
        idc = IDC_ECHNIDA_METRO_BACK;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = COLOR_ECHIDNA_METRO_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_METRO_BACKGROUND;
    };
    class metro_side: RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ECHNIDA_METRO_SIDE_GRP;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        class controls {
            class metro_side: RSC(BaseText) {
                idc = IDC_ECHNIDA_METRO_SIDE_BACK;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                text = "";
                colorBackground[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
                colorText[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
            };
            class shutdown: RSC(BaseButton) {
                idc = IDC_ECHNIDA_METRO_SIDE_SHUTDOWN;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                style = "48+0x800";
                sizeEx = GUI_ECHIDNA_H * 1.5;
                text = "";
                colorBackground[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
                colorBackgroundActive[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
                colorFocused[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
                colorText[] = COLOR_ECHIDNA_TASKBAR_TEXT;
                colorDisabled[] = COLOR_DISABLED;
                colorBackgroundDisabled[] = COLOR_DISABLED;
                //onButtonClick = QUOTE(_this call FUNC(close););
                offsetX = 0;
                offsetY = 0;
                offsetPressedX = 0;
                offsetPressedY = 0;
            };
        };
    };
    class metro : RSC(BaseControlsGroupNoVScrollbar) {
        idc = IDC_ECHNIDA_METRO_GRP;
        /*
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        */
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        class VScrollbar : VScrollbar {
            color[] = COLOR_ECHIDNA_METRO_SCROLLBAR;
            colorBackGround[] = COLOR_ECHIDNA_METRO_SCROLLBAR;
            colorActive[] = COLOR_ECHIDNA_METRO_BACKGROUND;
            colorDisabled[] = COLOR_ECHIDNA_METRO_BACKGROUND;
            width=0;
            height = GUI_ECHIDNA_METRO_BTTN_DIST;
            autoScrollEnabled = 1;
        };
        class controls {
            class back: RSC(BaseText) {
                idc = IDC_ECHNIDA_METRO_BACK_HELPER;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                text = "";
                colorBackground[] = COLOR_DISABLED;
                colorText[] = COLOR_DISABLED;
            };
            class Button_1 : RSC(BaseButton) {
                idc = IDC_ECHNIDA_METRO_BTTN1;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                sizeEx = GUI_ECHIDNA_H;
                text = "";
                style = "48+0x800";
                colorBackground[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_BACKGROUND;
                colorBackgroundActive[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_BACKGROUND;
                colorFocused[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT;
                colorText[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT;
                colorDisabled[] = COLOR_DISABLED;
                colorBackgroundDisabled[] = COLOR_DISABLED;
            };
            class Button_2: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN2;};
            class Button_3: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN3;};
            class Button_4: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN4;};
            class Button_5: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN5;};
            class Button_6: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN6;};
            class Button_7: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN7;};
            class Button_8: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN8;};
            class Button_9: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN9;};
            class Button_10: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN10;};
            class Button_11: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN11;};
            class Button_12: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN12;};
            class Button_13: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN13;};
            class Button_14: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN14;};
            class Button_15: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN15;};
            class Button_16: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN16;};
            class Button_17: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN17;};
            class Button_18: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN18;};
            class Button_19: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN19;};
            class Button_20: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN20;};
            class Button_21: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN21;};
            class Button_22: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN22;};
            class Button_23: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN23;};
            class Button_24: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN24;};
            class Button_25: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN25;};
            class Button_26: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN26;};
            class Button_27: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN27;};
            class Button_28: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN28;};
            class Button_29: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN29;};
            class Button_30: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN30;};
            class Button_31: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN31;};
            class Button_32: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN32;};
            class Button_33: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN33;};
            class Button_34: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN34;};
            class Button_35: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN35;};
            class Button_36: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN36;};
            class Button_37: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN37;};
            class Button_38: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN38;};
            class Button_39: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN39;};
            class Button_40: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN40;};
            class Button_41: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN41;};
            class Button_42: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN42;};
            class Button_43: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN43;};
            class Button_44: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN44;};
            class Button_45: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN45;};
            class Button_46: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN46;};
            class Button_47: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN47;};
            class Button_48: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN48;};
            class Button_49: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN49;};
            class Button_50: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN50;};
            class Button_51: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN51;};
            class Button_52: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN52;};
            class Button_53: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN53;};
            class Button_54: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN54;};
            class Button_55: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN55;};
            class Button_56: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN56;};
            class Button_57: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN57;};
            class Button_58: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN58;};
            class Button_59: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN59;};
            class Button_60: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN60;};
            class Button_61: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN61;};
            class Button_62: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN62;};
            class Button_63: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN63;};
            class Button_64: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN64;};
            class Button_65: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN65;};
            class Button_66: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN66;};
            class Button_67: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN67;};
            class Button_68: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN68;};
            class Button_69: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN69;};
            class Button_70: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN70;};
            class Button_71: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN71;};
            class Button_72: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN72;};
            class Button_73: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN73;};
            class Button_74: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN74;};
            class Button_75: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN75;};
            class Button_76: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN76;};
            class Button_77: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN77;};
            class Button_78: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN78;};
            class Button_79: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN79;};
            class Button_80: Button_1 {idc=IDC_ECHNIDA_METRO_BTTN80;};
        };
    };
};
