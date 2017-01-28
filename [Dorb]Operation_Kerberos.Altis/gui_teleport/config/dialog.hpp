/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(tabletBase) {
    idd = IDD_TELEPORT_DLG;
    name = "Teleporter";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(teleportMenu)', _this select 0)]; [ARR_2('GVAR(teleportMenu)',true)] call EFUNC(gui,blur); _this spawn FUNC(onLoad););
    onUnload = QUOTE([ARR_2('GVAR(teleportMenu)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_tablet,OnUnLoad););

    controlsBackground[] = {
        background_Picture,
        background_Display,
        background_Header,
        teleport_CenterBackground,
        teleport_HeaderBackground

    };
    controls[] =    {
        clock,
        notifications,
        teleport_bttn1,
        teleport_bttn2,
        teleport_bttn3,
        teleport_bttn4,
        teleport_bttn5,
        teleport_bttn6,
        teleport_bttn7
    };

    #define TELEPORT_SPALTE1 GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 2.5
    #define TELEPORT_SPALTE2 GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 15
    #define TELEPORT_SPALTE3 GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 27.5
    #define TELEPORT_REIHE1 GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 6
    #define TELEPORT_REIHE2 GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 12
    #define TELEPORT_REIHE3 GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 18

    class teleport_CenterBackground: RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 3;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 22;
        style = "0x02";
        font = GUI_FONT_BOLD;
        text = "";
        colorText[] = COLOR_TABLET_MAIN_TEXT;
        colorBackground[] = COLOR_TABLET_BACKGROUND;
    };
    class teleport_HeaderBackground: teleport_CenterBackground {
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 40;
        h = GUI_GRID_CENTER_H * 3;
        text = "Teleporter";
        sizeEx = GUI_GRID_CENTER_H * 2;
        colorBackground[] = COLOR_TABLET_HEADER;
    };
    class teleport_bttn1 : RSC(BaseButton) {
        idc = IDD_TELEPORT_BTTN1;
        x = TELEPORT_SPALTE1;
        y = TELEPORT_REIHE1;
        w = GUI_GRID_CENTER_W * 10;
        h = GUI_GRID_CENTER_H * 4;
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
        default = true;
    };
};
