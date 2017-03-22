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

        header_text,
        header_picture,

        spare_back1,
        spare_back2,
        spare_back3,

        Itemlist,
        Radiolist,

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
        colorBackground[] = COLOR_DISABLED;
        //colorSelectBackground[] = {RAL9022,1};
        //colorSelectBackground2[] = {RAL9022,1};
        colorSelectBackground[] = COLOR_DISABLED;
        colorSelectBackground2[] = COLOR_DISABLED;
        colorText[] = {RAL9005,1};
        colorDisabled[] = {RAL9005,0.5};
        colorSelect[] = {RAL9010,1};
        colorSelect2[] = {RAL9010,1};
        colorPictureSelected[] = {1,1,1,1};
        colorPictureDisabled[] = {1,1,1,0.5};
        colorPictureRight[] = {1,1,1,0.5};
        colorPictureRightSelected[] = {1,1,1,1};
        colorPictureRightDisabled[] = {1,1,1,0.5};
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
        colorBackground[] = COLOR_DISABLED;
        colorSelectBackground[] = {RAL9022,1};
        colorSelectBackground2[] = {RAL9022,1};
        colorText[] = {RAL9005,1};
        colorDisabled[] = {RAL9005,0.5};
        colorSelect[] = {RAL9010,1};
        colorSelect2[] = {RAL9010,1};
        colorPictureSelected[] = {1,1,1,1};
        colorPictureDisabled[] = {1,1,1,0.5};
        colorPictureRight[] = {1,1,1,0.5};
        colorPictureRightSelected[] = {1,1,1,1};
        colorPictureRightDisabled[] = {1,1,1,0.5};
    };
    class spare_back1: RSC(BaseText) {
        idc = IDC_ACRE_MENU_BACK_1;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        text = "";
        colorBackground[] = {RAL9002,1};
        colorText[] = COLOR_DISABLED;
    };
    class header_text : RSC(BaseText) {
        idc = IDC_ACRE_MENU_HEADER_TEXT;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_DISABLED;
    };
    class header_picture : RSC(BasePicture) {
        idc = IDC_ACRE_MENU_HEADER_PIC;
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_DISABLED;
    };

    class spare_back2: spare_back1 {
        idc = IDC_ACRE_MENU_BACK_2;
    };
    class spare_back3: spare_back1 {
        idc = IDC_ACRE_MENU_BACK_3;
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

                colorSelect[]={RAL9005,1};
                colorText[]={RAL9005,1};
                colorBackground[]={RAL9018,1};
                colorSelectBackground[]={RAL9010,1};
                colorScrollbar[]={RAL9022,1};
                colorActive[]={RAL9018,1};
                colorDisabled[]={RAL9002,0.25};
                colorTextRight[]={RAL9018,1};
                colorSelectRight[]={RAL9010,1};
                colorSelect2Right[]={RAL9010,1};
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
        color[] = {RAL9005,1};
        colorScrollbar[] = {RAL9005,1};
        colorSelect[] = {RAL9005,1};
        colorSelect2[] = {RAL9005,1};
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = {RAL9002,1};
        colorSelectBackground2[] = {RAL9002,1};
        colorText[] = {RAL9005,1};
        colorBackground[] = {RAL9002,1};
    };
    class treeview : RSC(BaseTree) {
        idc = IDC_ACRE_MENU_TREE;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        colorBackground[] = {RAL9002,1};
        colorArrow[] = {RAL9005,1};
        colorText[] = {RAL9005,1};
        colorSelect[] = {RAL9022,1};
        multiselectEnabled = 0;
        class ScrollBar : ScrollBar {
            color[] = {RAL9005,1};
		};
        colorPicture[]={1,1,1,1};
        colorPictureSelected[]={1,1,1,1};
        colorPictureDisabled[]={1,1,1,0.25};
        colorPictureRight[]={1,1,1,1};
        colorPictureRightSelected[]={1,1,1,1};
        colorPictureRightDisabled[]={1,1,1,0.25};
        //hiddenTexture = __EVAL(MISSION_ROOT + 'EPAAPATH(icon,add_b_nb)');
        //expandedTexture = __EVAL(MISSION_ROOT + 'EPAAPATH(icon,dec_b_nb)');
        hiddenTexture = MPATH(data\gui\tree\add_b_nb.paa);
        expandedTexture = MPATH(data\gui\tree\dec_b_nb.paa);
    };
};
