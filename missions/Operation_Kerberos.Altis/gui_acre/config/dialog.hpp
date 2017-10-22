/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"
class APP(dialog) : RSC(guiMenu) {
    idd = IDD_GUI_ACRE;

    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend
    };
    controls[] = {
        headertext,
        clock,
        player_button,
        menu_button,

        display_background,

        spare_back1,
        spare_back2,
        spare_back3,

        watermark,

        Itemlist,
        Radiolist,

        properties,
        properties_list,

        treeview,

        menubutton_background,
        menubutton_background_empty,
        menubutton_1_background,
        menubutton_2_background,
        menubutton_3_background,
        menubutton_4_background,
        menubutton_5_background,
        menubutton_6_background,
        menubutton_7_background,
        menubutton_1,
        menubutton_2,
        menubutton_3,
        menubutton_4,
        menubutton_5,
        menubutton_6,
        menubutton_7
    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad);_this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnLoad););

    class headertext: headertext {
        text = CSTRING(HEADER);
    };

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
    class menubutton_background_empty: menubutton_background {
        idc = IDC_ACRE_MENU_BACK_LEFT2;
    };


    #define BUTTON_HELPER(NUMBER) class TRIPLES(menubutton,NUMBER,background) : RSC(BasePicture) { \
        idc = -(IDC_ACRE_MENU_BTTN + NUMBER); \
        x = 0;y = 0;w = 0;h = 0; \
        text = QUOTE(gui\data\buttons\button_256_normal.paa); \
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
        sizeEx = GUI_DISP_H * 2.1; \
        text = ""; \
        style = "48+0x800"; \
        colorBackground[]= COLOR_DISABLED; \
        colorBackgroundActive[]= COLOR_DISABLED; \
        colorFocused[]= COLOR_DISABLED; \
        colorBackgroundDisabled[]= COLOR_DISABLED; \
        colorText[] = COLOR_MENU_HEADER_MENUBUTTON_TEXT; \
        colorDisabled[] = COLOR_MENU_HEADER_MENUBUTTON_TEXT_DISABLED; \
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
    BUTTON_HELPER(7);

    class Itemlist : RSC(BaseListbox) {
        idc = IDC_ACRE_MENU_ITEMLIST;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        access = 1;
        canDrag = 1;
        rowHeight = GUI_DISP_H*12;
        colorBackground[] = COLOR_DISABLED;
        colorSelectBackground[] = COLOR_DISABLED;
        colorSelectBackground2[] = COLOR_DISABLED;
        colorText[] = COLOR_BASE_BLACK;
        colorDisabled[] = COLOR_BASE_BLACK_DISABLED;
        colorSelect[] = COLOR_BASE_WHITE;
        colorSelect2[] = COLOR_BASE_WHITE;
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
        rowHeight = GUI_DISP_H*9;
        style = 16;
        colorBackground[] = COLOR_DISABLED;
        colorSelectBackground[] = COLOR_BASE_GREY_LIGHT;
        colorSelectBackground2[] = COLOR_BASE_GREY_LIGHT;
        colorText[] = COLOR_BASE_BLACK;
        colorDisabled[] = COLOR_BASE_BLACK_DISABLED;
        colorSelect[] = COLOR_BASE_WHITE;
        colorSelect2[] = COLOR_BASE_WHITE;
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
        colorBackground[] = COLOR_BASE_GREY_LIGHT;
        colorText[] = COLOR_DISABLED;
    };
    class watermark : RSC(BasePicture) {
        idc = IDC_ACRE_MENU_WATERMARK;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
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
                wholeHeight = GUI_DISP_H*45;
                colorSelect[]=COLOR_BASE_BLACK;
                colorText[]=COLOR_BASE_BLACK;
                colorBackground[]=COLOR_BASE_GREY_LIGHT;
                colorSelectBackground[]=COLOR_BASE_WHITE;
                colorScrollbar[]=COLOR_BASE_GREY_LIGHT;
                colorActive[]=COLOR_BASE_GREY_LIGHT;
                colorDisabled[]=COLOR_BASE_GREY_LIGHT_DISABLED;
                colorTextRight[]=COLOR_BASE_GREY_LIGHT;
                colorSelectRight[]=COLOR_BASE_WHITE;
                colorSelect2Right[]=COLOR_BASE_WHITE;
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
        color[] = COLOR_BASE_BLACK;
        colorScrollbar[] = COLOR_BASE_BLACK;
        colorSelect[] = COLOR_BASE_BLACK;
        colorSelect2[] = COLOR_BASE_BLACK;
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = COLOR_BASE_GREY_LIGHT;
        colorSelectBackground2[] = COLOR_BASE_GREY_LIGHT;
        colorText[] = COLOR_BASE_BLACK;
        colorBackground[] = COLOR_BASE_GREY_LIGHT;
    };
    class treeview : RSC(BaseTree) {
        idc = IDC_ACRE_MENU_TREE;
        x = 0;
        y = 0;
        w = 0;
        h = 0;
        colorBackground[] = COLOR_BASE_GREY_LIGHT;
        colorArrow[] = COLOR_BASE_BLACK;
        colorText[] = COLOR_BASE_BLACK;
        colorSelect[] = COLOR_BASE_GREY_LIGHT;
        multiselectEnabled = 0;
        class ScrollBar : ScrollBar {
            color[] = COLOR_BASE_BLACK;
        };
        colorPicture[]={1,1,1,1};
        colorPictureSelected[]={1,1,1,1};
        colorPictureDisabled[]={1,1,1,0.25};
        colorPictureRight[]={1,1,1,1};
        colorPictureRightSelected[]={1,1,1,1};
        colorPictureRightDisabled[]={1,1,1,0.25};
        hiddenTexture = MPATH(gui\data\tree\add_b_nb.paa);
        expandedTexture = MPATH(gui\data\tree\dec_b_nb.paa);
    };
};
