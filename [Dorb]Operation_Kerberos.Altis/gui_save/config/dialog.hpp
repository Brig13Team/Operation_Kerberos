/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) {
    idd = IDD_SAVE_DLG;
    name = "Generic Save";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable ['GVAR(saveMenu)', _this select 0];);
    onUnload = "";

    controlsBackground[] =     {
        dorb_save_CenterBackground,
        dorb_save_BottemBackground,
        dorb_save_ListBackground
    };

    controls[] =    {
        dorb_save_HeaderBackground,
        dorb_save_list,
        dorb_save_edit,
        dorb_save_button1,
        dorb_save_button2,
        dorb_save_button3
    };

    class dorb_save_CenterBackground: RSC(BaseText){
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 2.3;
        w = GUI_GRID_CENTER_W * 20;
        h = GUI_GRID_CENTER_H * 15.7;
//        x = GUI_XW(0,0.25);
//        w = GUI_W(0.5);
//        y = GUI_YH(0,0.16);
//        h = GUI_H(0.535);
        text = "";
        colorBackground[] = COLOR_TABLET_BACKGROUND;
        colorText[] = COLOR_TABLET_MAIN_TEXT;
    };
    class dorb_save_BottemBackground: dorb_save_CenterBackground {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 18.2;
        h = GUI_GRID_CENTER_H * 5;
//        y = GUI_YH(0,0.7);
//        h = GUI_H(0.2);
    };
    class dorb_save_HeaderBackground: dorb_save_CenterBackground {
        idc = IDC_SAVE_HEADER;
        y = GUI_GRID_CENTER_Y;
        h = GUI_GRID_CENTER_H * 2;
//        y = GUI_YH(0,0.1);
//        h = GUI_H(0.055);
        text = "";
        colorText[] = COLOR_TABLET_HEADER_TEXT;
        colorBackground[] = COLOR_TABLET_HEADER;
    };
    class dorb_save_ListBackground: dorb_save_CenterBackground {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 5.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 2.7;
        w = GUI_GRID_CENTER_W * 19;
        h = GUI_GRID_CENTER_H * 14.9;
//        x = GUI_XW(0,0.27);
//        w = GUI_W(0.46);
//        y = GUI_YH(0,0.18);
//        h = GUI_H(0.495);
        colorText[] = COLOR_TABLET_MAIN_TEXT;
        colorBackground[] = COLOR_TABLET_BACKGROUND;
    };
    class dorb_save_button1 : RSC(BaseButton) {
        idc = IDC_SAVE_BTTN1;
        x = GUI_XW(0,0.27);
        w = GUI_W(0.14);
        y = GUI_YH(0,0.8);
        h = GUI_H(0.08);
        colorBackground[] = COLOR_TABLET_MAIN_BTTN;
        colorBackgroundActive[] = COLOR_TABLET_MAIN_BTTN_SELECTED;
        colorFocused[] = COLOR_TABLET_MAIN_BTTN;
        text = ECSTRING(INTERFACE,SAVE_CANCEL);
        action = QUOTE(GVAR(isopened)=false;closeDialog IDD_SAVE_DLG);
    };
    class dorb_save_button2 : dorb_save_button1 {
        idc = IDC_SAVE_BTTN2;
        x = GUI_XW(0,0.43);
        toolTip = "";
        text = ECSTRING(INTERFACE,SAVE_DELETE);
        action = QUOTE([] call FUNC(delete);false);
    };
    class dorb_save_button3 : dorb_save_button1 {
        idc = IDC_SAVE_BTTN3;
        x = GUI_XW(0,0.59);
        toolTip = "";
        text = "";
        action = "";
    };
    class dorb_save_list : RSC(BaseListboxN) {
        idc = IDC_SAVE_LIST;
        access = 2;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 5.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 2.7;
        w = GUI_GRID_CENTER_W * 19;
        h = GUI_GRID_CENTER_H * 14.9;
//        x = GUI_XW(0,0.275);
//        w = GUI_W(0.45);
//        y = GUI_YH(0,0.185);
//        h = GUI_H(0.485);
        rowHeight = GUI_GRID_CENTER_H * 1.2;
        sizeEx = GUI_GRID_CENTER_H * 1;
        columns[] = {0.02};
        onLBSelChanged = QUOTE(_this call FUNC(save_select);false);
    };
    class dorb_save_edit : RSC(BaseEditBox) {
        idc = IDC_SAVE_EDIT;
        x = GUI_XW(0,0.27);
        y = GUI_YH(0,0.72);
        w = GUI_W(0.46);
        h = GUI_H(0.06);
        sizeEx = GUI_GRID_CENTER_H * 1;
        text = "";
    };
};
