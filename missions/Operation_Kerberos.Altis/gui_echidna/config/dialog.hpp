/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class RSC(BaseEchidna) {
    idd = IDD_ECHIDNA_MAIN;
    name = "Echidna";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

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
        idc = IDC_ECHIDNA_BACKGROUND_DEVICE;
        x = GUI_ECHIDNA_X - GUI_ECHIDNA_W * 7;
        y = GUI_ECHIDNA_Y - GUI_ECHIDNA_H * 12.03;
        w = GUI_ECHIDNA_WAbs + GUI_ECHIDNA_W * 14;
        h = GUI_ECHIDNA_HAbs + GUI_ECHIDNA_H * 24;
        text = QEPAAPATH(echidna,background_tablet);
        style = "48";
    };
    class background_display: RSC(BaseText) {
        idc = IDC_ECHIDNA_BACKGROUND_DISPLAY;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        text = "";
        colorBackground[] = COLOR_ECHIDNA_DISPLAY_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_DISPLAY_TEXT;
    };
    class background_logo: RSC(BasePicture) {
        idc = IDC_ECHIDNA_BACKGROUND_LOGO;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        text = QEPAAPATH(logo,logo_512w);
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_ECHIDNA_DISPLAY_LOGO;
    };
    class background_taskbar: RSC(BaseText) {
        idc = IDC_ECHIDNA_BACKGROUND_TASKBAR;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 27.5;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 2.5;
        colorBackground[] = COLOR_ECHIDNA_TASKBAR_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_TASKBAR_TEXT;
    };

    class clock: RSC(BaseStructuredText) {
        idc = IDC_ECHIDNA_TASKBAR_CLOCK;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_WAbs - GUI_ECHIDNA_W * 5;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 27.75;
        w = GUI_ECHIDNA_W * 4;
        h = GUI_ECHIDNA_H * 2;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_ECHIDNA_TASKBAR_TEXT;
        style = "0x02";
        size = GUI_ECHIDNA_H * 1.9;
        text = "";
        class attributes : attributes {
            align = "center";
            size = 1;
        };
    };
    class menu_button: RSC(BaseButton) {
        idc = IDC_ECHIDNA_TASKBAR_MENU_BUTTON;
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

class RSC(Echidna) : RSC(BaseEchidna) {
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
        idc = IDC_ECHIDNA_METRO_BACK;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = COLOR_ECHIDNA_METRO_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_METRO_BACKGROUND;
    };
    class metro_side: RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ECHIDNA_METRO_SIDE_GRP;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        class controls {
            class metro_side: RSC(BaseText) {
                idc = IDC_ECHIDNA_METRO_SIDE_BACK;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                text = "";
                colorBackground[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
                colorText[] = COLOR_ECHIDNA_METRO_SIDE_BACKGROUND;
            };
            class shutdown: RSC(BaseButton) {
                idc = IDC_ECHIDNA_METRO_SIDE_SHUTDOWN;
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
        idc = IDC_ECHIDNA_METRO_GRP;
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
                idc = IDC_ECHIDNA_METRO_BACK_HELPER;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                text = "";
                colorBackground[] = COLOR_DISABLED;
                colorText[] = COLOR_DISABLED;
            };
            #define COLOR_HELPER(VAR) colorBackground[]={ \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_R)',0.666667)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_G)',0.25098)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_B)',1)])),1}; \
                colorBackgroundActive[]={ \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_R)',0.666667)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_G)',0.25098)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_B)',1)])),1}; \
                colorFocused[]={ \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_R)',0.666667)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_G)',0.25098)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_B)',1)])),1}; \
                colorBackgroundDisabled[]={ \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_R)',0.666667)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_G)',0.25098)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),VAR,RGB_B)',1)])),0.7}

            #define COLOR_HELPER_PIC(NUMBER) colorBackground[] = {0,0,0,1}; \
                    colorText[]={ \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),NUMBER,RGB_R)',0.666667)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),NUMBER,RGB_G)',0.25098)])), \
                    QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),NUMBER,RGB_B)',1)])),1} \



            #define BUTTON_HELPER(NUMBER,COLOR) class TRIPLES(button,NUMBER,background) : RSC(BasePicture) { \
                idc = -(IDC_ECHIDNA_METRO_BTTN + NUMBER); \
                x = 0;y = 0;w = 0;h = 0; \
                text = QEPAAPATH(buttons,button_256_normal); \
                shadow = 0; \
                style = "48"; \
                colorShadow[] = COLOR_DISABLED; \
                font = FONT_DEFAULT; \
                COLOR_HELPER_PIC(NUMBER); \
            }; \
            class DOUBLES(button,NUMBER) : RSC(BaseButton) { \
                idc = IDC_ECHIDNA_METRO_BTTN + NUMBER; \
                x = 0;y = 0;w = 0;h = 0; \
                sizeEx = GUI_ECHIDNA_H * 0.7; \
                text = ""; \
                style = "48+0x800"; \
                colorBackground[]= COLOR_DISABLED; \
                colorBackgroundActive[]= COLOR_DISABLED; \
                colorFocused[]= COLOR_DISABLED; \
                colorBackgroundDisabled[]= COLOR_DISABLED; \
                colorText[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT; \
                colorDisabled[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT_DISABLED; \
                shadow = 0; \
                colorShadow[] = COLOR_DISABLED; \
                offsetX = 0; \
                offsetY = 0; \
                offsetPressedX = 0; \
                offsetPressedY = 0; \
            }

            BUTTON_HELPER(1,1);
            BUTTON_HELPER(2,2);
            BUTTON_HELPER(3,3);
            BUTTON_HELPER(4,4);
            BUTTON_HELPER(5,5);
            BUTTON_HELPER(6,6);
            BUTTON_HELPER(7,7);
            BUTTON_HELPER(8,8);
            BUTTON_HELPER(9,9);
            BUTTON_HELPER(10,10);
            BUTTON_HELPER(11,11);
            BUTTON_HELPER(12,12);
            BUTTON_HELPER(13,13);
            BUTTON_HELPER(14,14);
            BUTTON_HELPER(15,15);
            BUTTON_HELPER(16,16);
            BUTTON_HELPER(17,17);
            BUTTON_HELPER(18,18);
            BUTTON_HELPER(19,19);
            BUTTON_HELPER(20,20);
            BUTTON_HELPER(21,21);
            BUTTON_HELPER(22,22);
            BUTTON_HELPER(23,23);
            BUTTON_HELPER(24,24);
            BUTTON_HELPER(25,25);
            BUTTON_HELPER(26,1);
            BUTTON_HELPER(27,2);
            BUTTON_HELPER(28,3);
            BUTTON_HELPER(29,4);
            BUTTON_HELPER(30,5);
            BUTTON_HELPER(31,6);
            BUTTON_HELPER(32,7);
            BUTTON_HELPER(33,8);
            BUTTON_HELPER(34,9);
            BUTTON_HELPER(35,10);
            BUTTON_HELPER(36,11);
            BUTTON_HELPER(37,12);
            BUTTON_HELPER(38,13);
            BUTTON_HELPER(39,14);
            BUTTON_HELPER(40,15);
            BUTTON_HELPER(41,16);
            BUTTON_HELPER(42,17);
            BUTTON_HELPER(43,18);
            BUTTON_HELPER(44,19);
            BUTTON_HELPER(45,20);
            BUTTON_HELPER(46,21);
            BUTTON_HELPER(47,22);
            BUTTON_HELPER(48,23);
            BUTTON_HELPER(49,24);
            BUTTON_HELPER(50,25);/*
            BUTTON_HELPER(51,1);
            BUTTON_HELPER(52,2);
            BUTTON_HELPER(53,3);
            BUTTON_HELPER(54,4);
            BUTTON_HELPER(55,5);
            BUTTON_HELPER(56,6);
            BUTTON_HELPER(57,7);
            BUTTON_HELPER(58,8);
            BUTTON_HELPER(59,9);
            BUTTON_HELPER(60,10);
            BUTTON_HELPER(61,11);
            BUTTON_HELPER(62,12);
            BUTTON_HELPER(63,13);
            BUTTON_HELPER(64,14);
            BUTTON_HELPER(65,15);
            BUTTON_HELPER(66,16);
            BUTTON_HELPER(67,17);
            BUTTON_HELPER(68,18);
            BUTTON_HELPER(69,19);
            BUTTON_HELPER(70,20);
            BUTTON_HELPER(71,21);
            BUTTON_HELPER(72,22);
            BUTTON_HELPER(73,23);
            BUTTON_HELPER(74,24);
            BUTTON_HELPER(75,25);
            BUTTON_HELPER(76,1);
            BUTTON_HELPER(77,2);
            BUTTON_HELPER(78,3);
            BUTTON_HELPER(79,4);
            BUTTON_HELPER(80,5);*/


            /*
            class Button_1 : RSC(BaseButton) {
                idc = IDC_ECHIDNA_METRO_BTTN1;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                sizeEx = GUI_ECHIDNA_H;
                text = "";
                style = "48+0x800";
                COLOR_HELPER(1);
                colorText[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT;
                colorDisabled[] = COLOR_ECHIDNA_METRO_BTTN_DEFAULT_TEXT_DISABLED;
                shadow = 0;
                offsetX = 0;
                offsetY = 0;
                offsetPressedX = 0;
                offsetPressedY = 0;
            };
            class Button_2 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN2; COLOR_HELPER(2);};
            class Button_3 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN3; COLOR_HELPER(3);};
            class Button_4 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN4; COLOR_HELPER(4);};
            class Button_5 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN5; COLOR_HELPER(5);};
            class Button_6 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN6; COLOR_HELPER(6);};
            class Button_7 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN7; COLOR_HELPER(7);};
            class Button_8 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN8; COLOR_HELPER(8);};
            class Button_9 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN9; COLOR_HELPER(9);};
            class Button_10 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN10; COLOR_HELPER(10);};
            class Button_11 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN11; COLOR_HELPER(11);};
            class Button_12 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN12; COLOR_HELPER(12);};
            class Button_13 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN13; COLOR_HELPER(13);};
            class Button_14 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN14; COLOR_HELPER(14);};
            class Button_15 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN15; COLOR_HELPER(15);};
            class Button_16 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN16; COLOR_HELPER(16);};
            class Button_17 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN17; COLOR_HELPER(17);};
            class Button_18 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN18; COLOR_HELPER(18);};
            class Button_19 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN19; COLOR_HELPER(19);};
            class Button_20 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN20; COLOR_HELPER(20);};
            class Button_21 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN21; COLOR_HELPER(21);};
            class Button_22 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN22; COLOR_HELPER(22);};
            class Button_23 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN23; COLOR_HELPER(23);};
            class Button_24 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN24; COLOR_HELPER(24);};
            class Button_25 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN25; COLOR_HELPER(25);};
            class Button_26 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN26; COLOR_HELPER(1);};
            class Button_27 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN27; COLOR_HELPER(2);};
            class Button_28 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN28; COLOR_HELPER(3);};
            class Button_29 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN29; COLOR_HELPER(4);};
            class Button_30 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN30; COLOR_HELPER(5);};
            class Button_31 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN31; COLOR_HELPER(6);};
            class Button_32 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN32; COLOR_HELPER(7);};
            class Button_33 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN33; COLOR_HELPER(8);};
            class Button_34 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN34; COLOR_HELPER(9);};
            class Button_35 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN35; COLOR_HELPER(10);};
            class Button_36 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN36; COLOR_HELPER(11);};
            class Button_37 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN37; COLOR_HELPER(12);};
            class Button_38 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN38; COLOR_HELPER(13);};
            class Button_39 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN39; COLOR_HELPER(14);};
            class Button_40 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN40; COLOR_HELPER(15);};
            class Button_41 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN41; COLOR_HELPER(16);};
            class Button_42 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN42; COLOR_HELPER(17);};
            class Button_43 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN43; COLOR_HELPER(18);};
            class Button_44 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN44; COLOR_HELPER(19);};
            class Button_45 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN45; COLOR_HELPER(20);};
            class Button_46 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN46; COLOR_HELPER(21);};
            class Button_47 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN47; COLOR_HELPER(22);};
            class Button_48 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN48; COLOR_HELPER(23);};
            class Button_49 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN49; COLOR_HELPER(24);};
            class Button_50 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN50; COLOR_HELPER(25);};
            class Button_51 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN51; COLOR_HELPER(1);};
            class Button_52 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN52; COLOR_HELPER(2);};
            class Button_53 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN53; COLOR_HELPER(3);};
            class Button_54 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN54; COLOR_HELPER(4);};
            class Button_55 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN55; COLOR_HELPER(5);};
            class Button_56 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN56; COLOR_HELPER(6);};
            class Button_57 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN57; COLOR_HELPER(7);};
            class Button_58 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN58; COLOR_HELPER(8);};
            class Button_59 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN59; COLOR_HELPER(9);};
            class Button_60 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN60; COLOR_HELPER(10);};
            class Button_61 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN61; COLOR_HELPER(11);};
            class Button_62 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN62; COLOR_HELPER(12);};
            class Button_63 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN63; COLOR_HELPER(13);};
            class Button_64 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN64; COLOR_HELPER(14);};
            class Button_65 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN65; COLOR_HELPER(15);};
            class Button_66 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN66; COLOR_HELPER(16);};
            class Button_67 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN67; COLOR_HELPER(17);};
            class Button_68 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN68; COLOR_HELPER(18);};
            class Button_69 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN69; COLOR_HELPER(19);};
            class Button_70 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN70; COLOR_HELPER(20);};
            class Button_71 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN71; COLOR_HELPER(21);};
            class Button_72 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN72; COLOR_HELPER(22);};
            class Button_73 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN73; COLOR_HELPER(23);};
            class Button_74 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN74; COLOR_HELPER(24);};
            class Button_75 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN75; COLOR_HELPER(25);};
            class Button_76 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN76; COLOR_HELPER(1);};
            class Button_77 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN77; COLOR_HELPER(2);};
            class Button_78 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN78; COLOR_HELPER(3);};
            class Button_79 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN79; COLOR_HELPER(4);};
            class Button_80 : Button_1 {idc=IDC_ECHIDNA_METRO_BTTN80; COLOR_HELPER(5);};
            */
        };
    };
};
class APP(dialog) : RSC(Echidna) {};
