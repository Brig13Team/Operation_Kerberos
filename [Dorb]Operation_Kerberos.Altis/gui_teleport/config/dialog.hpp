/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_TELEPORT_DLG;
    name = "Teleporter";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    controlsBackground[] = {
        background_taskbar,
        background_display,
        teleport_CenterBackground,
        teleport_HeaderBackground
    };
    controls[] = {
        clock,
        menu_button,
        teleport_bttn1,
        teleport_bttn2,
        teleport_bttn3,
        teleport_bttn4,
        teleport_bttn5,
        teleport_bttn6,
        teleport_bttn7,
        metro_back,
        metro,
        metro_side,
        background_device
    };

    #define TELEPORT_SPALTE1 GUI_ECHIDNA_X + GUI_ECHIDNA_W * 2.5
    #define TELEPORT_SPALTE2 GUI_ECHIDNA_X + GUI_ECHIDNA_W * 15
    #define TELEPORT_SPALTE3 GUI_ECHIDNA_X + GUI_ECHIDNA_W * 27.5
    #define TELEPORT_REIHE1 GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 6
    #define TELEPORT_REIHE2 GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 12
    #define TELEPORT_REIHE3 GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 18

    class teleport_CenterBackground: RSC(BaseText) {
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        style = "0x02";
        font = GUI_FONT_BOLD;
        text = "";
        colorText[] = COLOR_TABLET_MAIN_TEXT;
        colorBackground[] = COLOR_TABLET_BACKGROUND;
    };
    class teleport_HeaderBackground: teleport_CenterBackground {
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 3;
        text = "Teleporter";
        sizeEx = GUI_ECHIDNA_H * 2;
        colorBackground[] = COLOR_TABLET_HEADER;
    };
    class teleport_bttn1 : RSC(BaseButton) {
        idc = IDD_TELEPORT_BTTN1;
        x = TELEPORT_SPALTE1;
        y = TELEPORT_REIHE1;
        w = GUI_ECHIDNA_W * 10;
        h = GUI_ECHIDNA_H * 4;
        sizeEx = GUI_GRID_CENTER_H;
        text = "";
        colorBackground[] = COLOR_TABLET_MAIN_BTTN;
        colorBackgroundActive[] = COLOR_TABLET_MAIN_BTTN_SELECTED;
        colorFocused[] = COLOR_TABLET_MAIN_BTTN;
        colorText[] = COLOR_TABLET_MAIN_BTTN_TEXT;
    };
    class teleport_bttn2 : teleport_bttn1 {
        idc = IDD_TELEPORT_BTTN2;
        y = TELEPORT_REIHE2;
    };
    class teleport_bttn3 : teleport_bttn1 {
        idc = IDD_TELEPORT_BTTN3;
        x = TELEPORT_SPALTE2;
        y = TELEPORT_REIHE1;
    };
    class teleport_bttn4 : teleport_bttn3 {
        idc = IDD_TELEPORT_BTTN4;
        y = TELEPORT_REIHE2;
    };
    class teleport_bttn5 : teleport_bttn1 {
        idc = IDD_TELEPORT_BTTN5;
        x = TELEPORT_SPALTE3;
        y = TELEPORT_REIHE1;
    };
    class teleport_bttn6 : teleport_bttn5 {
        idc = IDD_TELEPORT_BTTN6;
        y = TELEPORT_REIHE2;
    };
    class teleport_bttn7 : teleport_bttn1 {
        idc = IDD_TELEPORT_BTTN7;
        x = TELEPORT_SPALTE2;
        y = TELEPORT_REIHE3;
    };
};
