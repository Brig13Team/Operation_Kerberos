/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) {
    idd = 600240;
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

    class dorb_save_CenterBackground: dorb_gui_backgroundBase {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 2.3;
        w = GUI_GRID_CENTER_W * 20;
        h = GUI_GRID_CENTER_H * 15.7;
//        x = GUI_XW(0,0.25);
//        w = GUI_W(0.5);
//        y = GUI_YH(0,0.16);
//        h = GUI_H(0.535);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };
    class dorb_save_BottemBackground: dorb_save_CenterBackground {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 18.2;
        h = GUI_GRID_CENTER_H * 5;
//        y = GUI_YH(0,0.7);
//        h = GUI_H(0.2);
    };
    class dorb_save_HeaderBackground: dorb_save_CenterBackground {
        idc = 600246;
        y = GUI_GRID_CENTER_Y;
        h = GUI_GRID_CENTER_H * 2;
//        y = GUI_YH(0,0.1);
//        h = GUI_H(0.055);
        text = "";
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_HEADER;
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
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_CTRL_GRAU2;
    };
    class dorb_save_button1 : dorb_gui_button {
        idc = 600242;
        x = GUI_XW(0,0.27);
        w = GUI_W(0.14);
        y = GUI_YH(0,0.8);
        h = GUI_H(0.08);
        colorBackground[] = UI_CL_CTRL_WEINROT1;
        colorBackgroundActive[] = UI_CL_CTRL_WEINROT2;
        colorFocused[] = UI_CL_CTRL_WEINROT1;
        text = ECSTRING(INTERFACE,SAVE_CANCEL);
        action = QUOTE(GVAR(save_isopened)=false;closeDialog 600240);
    };
    class dorb_save_button2 : dorb_save_button1 {
        idc = 600243;
        x = GUI_XW(0,0.43);
        toolTip = "";
        text = ECSTRING(INTERFACE,SAVE_DELETE);
        action = QUOTE([] call FUNC(save_delete);false);
    };
    class dorb_save_button3 : dorb_save_button1 {
        idc = 600244;
        x = GUI_XW(0,0.59);
        toolTip = "";
        text = "";
        action = "";
    };
    class dorb_save_list : dorb_gui_listboxN {
        idc = 600241;
        access = 2;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 5.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 2.7;
        w = GUI_GRID_CENTER_W * 19;
        h = GUI_GRID_CENTER_H * 14.9;
//        x = GUI_XW(0,0.275);
//        w = GUI_W(0.45);
//        y = GUI_YH(0,0.185);
//        h = GUI_H(0.485);
        rowHeight = GUI_H(0.035);
        sizeEx = GUI_H(0.03);
        columns[] = {0.02};
        onLBSelChanged = QUOTE(_this call FUNC(save_select);false);
    };
    class dorb_save_edit : dorb_gui_editBase {
        idc = 600245;
        x = GUI_XW(0,0.27);
        y = GUI_YH(0,0.72);
        w = GUI_W(0.46);
        h = GUI_H(0.06);
        sizeEx = GUI_H(0.04);
        textcolor[] = UI_CL_BODY_TEXT;
        text = "";
    };
};
