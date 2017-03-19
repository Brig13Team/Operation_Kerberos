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


        Itemlist,
        Radiolist,

        properties_back,
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
    /*
    class backGroundLeft: RSC(BaseText) {
        idc = IDC_ACRE_MENU_BACK_LEFT;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_DISABLED;
    };
    */

    #define COLOR_HELPER_PIC(NUMBER) colorBackground[] = {0,0,0,1}; \
            colorText[]={ \
            QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),NUMBER,RGB_R)',0.666667)])), \
            QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),NUMBER,RGB_G)',0.25098)])), \
            QUOTE((missionNamespace getvariable [ARR_2('TRIPLES(GVAR(METRO_BUTTON),NUMBER,RGB_B)',1)])),1} \

    #define BUTTON_HELPER(NUMBER,COLOR) class TRIPLES(menubutton,NUMBER,background) : RSC(BasePicture) { \
        idc = -(IDC_ACRE_MENU_BTTN + NUMBER); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QEPAAPATH(buttons,button_256_normal); \
        shadow = 0; \
        style = "48"; \
        colorShadow[] = COLOR_DISABLED; \
        font = FONT_DEFAULT; \
        COLOR_HELPER_PIC(NUMBER); \
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

    BUTTON_HELPER(1,1);
    BUTTON_HELPER(2,2);
    BUTTON_HELPER(3,3);
    BUTTON_HELPER(4,4);
    BUTTON_HELPER(5,5);
    BUTTON_HELPER(6,6);


/*
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
*/
    class Itemlist : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_ITEMLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        access = 1;
        canDrag = 1;
        rowHeight = 4.5*GUI_ECHIDNA_H;
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

            /*
            class combo : RSC(BaseComboBox) {
                idc = IDC_ACRE_MENU_PROPERTIES_COMBO;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
            };
            */

            class text_1 : RSC(BaseText) {
                idc = IDC_ACRE_MENU_PROPERTIES_TEXT_1;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
            };
            class text_2 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_2;};
            class text_3 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_3;};
            class text_4 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_4;};
            class text_5 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_5;};
            class text_6 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_6;};
            class text_7 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_7;};
            class text_8 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_8;};
            class text_9 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_9;};
            class text_10 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_10;};
            class text_11 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_11;};
            class text_12 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_12;};
            class text_13 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_13;};
            class text_14 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_14;};
            class text_15 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_15;};
            class text_16 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_16;};
            class text_17 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_17;};
            class text_18 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_18;};
            class text_19 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_19;};
            class text_20 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_20;};
            class text_21 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_21;};
            class text_22 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_22;};
            class text_23 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_23;};
            class text_24 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_24;};
            class text_25 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_25;};
            class text_26 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_26;};
            class text_27 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_27;};
            class text_28 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_28;};
            class text_29 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_29;};
            class text_30 : text_1 {idc = IDC_ACRE_MENU_PROPERTIES_TEXT_30;};


            class edit_1 : RSC(BaseEdit) {
                idc = IDC_ACRE_MENU_PROPERTIES_EDIT_1;
                x = 1;
                y = 1;
                w = 1;
                h = 1;
            };
            class edit_2 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_2;};
            class edit_3 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_3;};
            class edit_4 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_4;};
            class edit_5 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_5;};
            class edit_6 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_6;};
            class edit_7 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_7;};
            class edit_8 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_8;};
            class edit_9 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_9;};
            class edit_10 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_10;};
            class edit_11 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_11;};
            class edit_12 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_12;};
            class edit_13 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_13;};
            class edit_14 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_14;};
            class edit_15 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_15;};
            class edit_16 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_16;};
            class edit_17 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_17;};
            class edit_18 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_18;};
            class edit_19 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_19;};
            class edit_20 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_20;};
            class edit_21 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_21;};
            class edit_22 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_22;};
            class edit_23 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_23;};
            class edit_24 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_24;};
            class edit_25 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_EDIT_25;};

            class bool_1 : RSC(BaseCheckBox) {
                idc = IDC_ACRE_MENU_PROPERTIES_BOOL_1;
                x = 0;
                y = 0;
                w = 0;
                h = 0;
            };
            class bool_2 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_BOOL_2;};
            class bool_3 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_BOOL_3;};
            class bool_4 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_BOOL_4;};
            class bool_5 : edit_1 {idc = IDC_ACRE_MENU_PROPERTIES_BOOL_5;};
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
