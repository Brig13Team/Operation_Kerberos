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
