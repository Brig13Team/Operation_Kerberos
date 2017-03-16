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
    x = GUI_ECHIDNA_X;
    y = GUI_ECHIDNA_Y;
    w = GUI_ECHIDNA_W * 40;
    h = GUI_ECHIDNA_H * 27.5;
    */

    class Button_1 : RSC(BaseButton) {
        idc = IDC_ACRE_MENU_BTTN1;
        x = GUI_ECHIDNA_X + 0.5*GUI_ECHIDNA_W;
        y = GUI_ECHIDNA_Y + 0.5*GUI_ECHIDNA_H;
        w = GUI_ECHIDNA_W * 5;
        h = GUI_ECHIDNA_H * 5;
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
    class Button_2 : Button_1 {
        idc = IDC_ACRE_MENU_BTTN2;
        y = GUI_ECHIDNA_Y + 6*GUI_ECHIDNA_H;
    };
    class Button_3 : Button_1 {
        idc = IDC_ACRE_MENU_BTTN3;
        y = GUI_ECHIDNA_Y + 11.5*GUI_ECHIDNA_H;
    };
    class Button_4 : Button_1 {
        idc = IDC_ACRE_MENU_BTTN4;
        y = GUI_ECHIDNA_Y + 17*GUI_ECHIDNA_H;
    };
    class Button_5 : Button_1 {
        idc = IDC_ACRE_MENU_BTTN5;
        y = GUI_ECHIDNA_Y + 22.5*GUI_ECHIDNA_H;
    };
    class Itemlist : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_ITEMLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };
    class RadioList : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_RADIOLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };
    class properties : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ACRE_MENU_PROPERTIES;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        class controls {
            class PresetList : RSC(BaseComboBox) {

            };

            class transmitt : RSC(BaseButton) {

            };
        };
    };
    class properties_list : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_PROPERTIESLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };
    class treeview : RSC(BaseTree) {
        idc = IDC_ACRE_MENU_TREE;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };
};
