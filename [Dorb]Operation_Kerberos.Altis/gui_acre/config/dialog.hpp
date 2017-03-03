/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"
class APP(dialog) : RSC(echidna) {

    controlsBackground[] =     {
        background_Picture,
        background_Display,
        background_Header
    };

    controls[] =    {
        clock,
        notifications
    };

    /*
    x = GUI_GRID_CENTER_X;
    y = GUI_GRID_CENTER_Y;
    w = GUI_GRID_CENTER_W * 40;
    h = GUI_GRID_CENTER_H * 25;
    */

    class Button_1 : RSC(BaseButton) {
        idc = -1;
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y;
        w = GUI_GRID_CENTER_W * 5;
        h = GUI_GRID_CENTER_H * 5;
        sizeEx = GUI_GRID_CENTER_H;
        text = "\a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa";
        style = "48+0x800";
        colorBackground[] = COLOR_TABLET_MAIN_BTTN;
        colorBackgroundActive[] = COLOR_TABLET_MAIN_BTTN_SELECTED;
        colorFocused[] = COLOR_TABLET_MAIN_BTTN;
        colorText[] = COLOR_TABLET_MAIN_BTTN_TEXT;
        colorDisabled[] = COLOR_TABLET_MAIN_BTTN_TEXT_DISABLED;
        colorBackgroundDisabled[] = COLOR_TABLET_MAIN_BTTN_DISABLED;
    };
    class Button_2 : Button_1 {idc = IDC_TABLET_BTTN2;};
    class Button_3 : Button_1 {idc = IDC_TABLET_BTTN3;};
    class Button_4 : Button_1 {idc = IDC_TABLET_BTTN4;};
    class Button_5 : Button_1 {idc = IDC_TABLET_BTTN5;};
};
