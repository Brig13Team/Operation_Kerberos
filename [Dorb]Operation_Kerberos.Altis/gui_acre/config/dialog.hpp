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

        display_background,

        display_header,

        Itemlist,
        Radiolist,

        properties_back,
        properties,
        properties_list,

        treeview,

        menubutton_background,
        menubutton_1_background,
        menubutton_2_background,
        menubutton_3_background,
        menubutton_4_background,
        menubutton_5_background,
        menubutton_6_background,
        menubutton_1,
        menubutton_2,
        menubutton_3,
        menubutton_4,
        menubutton_5,
        menubutton_6,

        metro_back,
        metro,
        metro_side,
        background_device
    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    class display_background: RSC(BaseText) {
        idc = IDC_ACRE_MENU_BACK_REST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_DISABLED;
    };
    class menubutton_background: display_background {
        idc = IDC_ACRE_MENU_BACK_LEFT;
    };
    class display_header: display_background {
        idc = IDC_ACRE_MENU_HEADER;
    };


    #define BUTTON_HELPER(NUMBER) class TRIPLES(menubutton,NUMBER,background) : RSC(BasePicture) { \
        idc = -(IDC_ACRE_MENU_BTTN + NUMBER); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QEPAAPATH(buttons,button_256_normal); \
        shadow = 0; \
        style = "48"; \
        colorShadow[] = COLOR_DISABLED; \
        font = FONT_DEFAULT; \
        colorBackground[] = {0,0,0,1}; \
        colorText[] = {0,0,0,1}; \
    }; \
    class DOUBLES(menubutton,NUMBER) : RSC(BaseButton) { \
        idc = IDC_ACRE_MENU_BTTN + NUMBER; \
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

    BUTTON_HELPER(1);
    BUTTON_HELPER(2);
    BUTTON_HELPER(3);
    BUTTON_HELPER(4);
    BUTTON_HELPER(5);
    BUTTON_HELPER(6);

    class Itemlist : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_ITEMLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        access = 1;
        canDrag = 1;
        rowHeight = 4*GUI_ECHIDNA_H;
    };
    class RadioList : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_RADIOLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        canDrag = 1;
        rowHeight = 3*GUI_ECHIDNA_H;
        style = 16;
    };
    class properties_back: RSC(BaseText) {
        idc = IDC_ACRE_MENU_PROPERTIES_BACK;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = {0.2,0.2,0.2,1};
        colorText[] = COLOR_DISABLED;
    };
    class properties : RSC(BaseControlsGroupNoScrollbar) {
        idc = IDC_ACRE_MENU_PROPERTIES;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        class controls {
            class combo : RSC(BaseComboBox) {
                idc = IDC_ACRE_MENU_PROPERTIES_COMBO;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
                wholeHeight = GUI_ECHIDNA_H * 15;
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
