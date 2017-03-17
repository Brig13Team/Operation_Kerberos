/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"
class APP(dialog) : RSC(echidna) {

    controlsBackground[] = {
        background_taskbar,
        background_display
    };
    controls[] = {
        clock,
        menu_button,

        Button_1,
        Button_2,
        Button_3,
        Button_4,
        Button_5,
        Itemlist,
        Radiolist,
        properties,
        properties_list,
        treeview,

        metro_back,
        metro,
        metro_side,
        background_device
    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

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
                idc = IDC_ACRE_MENU_PROPERTIES + 1;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
            };

            class transmitt : RSC(BaseButton) {
                idc = IDC_ACRE_MENU_PROPERTIES + 2;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
            };
        };
    };
    class properties_list : RSC(BaseListboxN) {
        idc = IDC_ACRE_MENU_PROPERTIESLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        columns[] = {-0.01};
    };
    class treeview : RSC(BaseTree) {
        idc = IDC_ACRE_MENU_TREE;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
    };
};
