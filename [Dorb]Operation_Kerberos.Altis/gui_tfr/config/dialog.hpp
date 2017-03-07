/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) {
    idd = IDD_TFR_DLG;
    name = "Task Force Radio Tool";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(tfrMenu)', _this select 0)]; [ARR_2('GVAR(tfrMenu)', true)] call EFUNC(gui,blur););
    onUnload = QUOTE([ARR_2('GVAR(tfrMenu)',false)] call EFUNC(gui,blur); [ARR_2('GVAR(onOpenEH)', 'onEachFrame')] call BIS_fnc_removeStackedEventHandler;);

    controlsBackground[] = {
        dorb_tfr_body,
        dorb_tfr_body2,
        dorb_tfr_body3,
        dorb_tfr_header,
        dorb_tfr_frequenzen,
        dorb_tfr_SR_name,
        dorb_tfr_LR_name,
        //dorb_tfr_DD_name,
        dorb_tfr_SR_name2,
        dorb_tfr_LR_name2,
        //dorb_tfr_DD_name2,
        dorb_tfr_frequenzen_neu,
        dorb_tfr_bodyLB
    };

    controls[] =    {
        dorb_tfr_list,
        dorb_tfr_SR_edit,
        dorb_tfr_LR_edit,
        //dorb_tfr_DD_edit,
        dorb_tfr_SR_disp,
        dorb_tfr_LR_disp,
        //dorb_tfr_DD_disp,
        dorb_tfr_take,
        dorb_tfr_set
    };
    class dorb_tfr_body : RSC(BaseText) {
        x = GUI_GRID_CENTER_X;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 5;
        w = GUI_GRID_CENTER_W * 24;
        h = GUI_GRID_CENTER_H * 20;
        //x = GUI_XW(0,0.1);
        //y = GUI_YH(0,0.2);
        //w = GUI_W(0.5);
        //h = GUI_H(0.52);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };
    class dorb_tfr_body2 : dorb_tfr_body {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 24.3;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 8.8;
        w = GUI_GRID_CENTER_W * 15.7;
        h = GUI_GRID_CENTER_H * 6;
//        x = GUI_XW(0,0.605);
//        y = GUI_YH(0,0.2625);
//        w = GUI_W(0.295);
//        h = GUI_H(0.1975);
    };
    class dorb_tfr_body3 : dorb_tfr_body2 {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 18.9;
        h = GUI_GRID_CENTER_H * 6.1;
//        y = GUI_YH(0,0.5275);
//        h = GUI_H(0.1925);
    };
    class dorb_tfr_bodyLB : dorb_tfr_body {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 1;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 0.5;
        w = GUI_GRID_CENTER_W * 22;
        h = GUI_GRID_CENTER_H * 19;
//        x = GUI_XW(0,0.12);
//        y = GUI_YH(0,0.22);
//        w = GUI_W(0.46);
//        h = GUI_H(0.48);
        colorBackground[] = UI_CL_CTRL_GRAU1;
    };
    class dorb_tfr_header : dorb_tfr_body {
        idc = -1;
        y = GUI_GRID_CENTER_Y;
        h = GUI_GRID_CENTER_H * 4.7;
        w = GUI_GRID_CENTER_W * 40;
//        y = GUI_YH(0,0.1);
//        h = GUI_H(0.09);
//        w = GUI_W(0.8);
        text = ECSTRING(gui_tfr,HEADER);
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_HEADER;
    };
    class dorb_tfr_frequenzen : dorb_tfr_body2 {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 5;
        h = GUI_GRID_CENTER_H * 3.5;
//        x = GUI_XW(0,0.605);
//        y = GUI_YH(0,0.2);
//        w = GUI_W(0.295);
//        h = GUI_H(0.06);
        sizeEx = GUI_GRID_CENTER_H * 2;
//        sizeEx = GUI_H(0.035);
        text = ECSTRING(gui_tfr,FREQ_SQUAD);
        colorBackground[]=UI_CL_HEADER2;
    };
    class dorb_tfr_frequenzen_neu : dorb_tfr_frequenzen {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 15.1;
//        y = GUI_YH(0,0.465);
        text = ECSTRING(gui_tfr,FREQ_NEW);
    };
    class dorb_tfr_SR_name : dorb_tfr_body {
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 24.8;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 9.1;
        w = GUI_GRID_CENTER_W * 3;
        h = GUI_GRID_CENTER_H * 1.6;
//        x = GUI_XW(0,0.62);
//        y = GUI_YH(0,0.28);
//        w = GUI_W(0.03);
//        h = GUI_H(0.04);
//        sizeEx = GUI_H(0.035);
        sizeEx = GUI_GRID_CENTER_H * 1.2;
        text = "SR:";
    };
    class dorb_tfr_LR_name : dorb_tfr_SR_name {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10.6;
        text = "LR:";
    };
    class dorb_tfr_DD_name : dorb_tfr_SR_name {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 12.5;
        text = "DD";
    };
    class dorb_tfr_SR_name2 : dorb_tfr_SR_name {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 19.2;
        text = "SR";
    };
    class dorb_tfr_LR_name2 : dorb_tfr_SR_name {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 21.1;
        text = "LR:";
    };
    class dorb_tfr_DD_name2 : dorb_tfr_SR_name {
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 23;
        text = "DD";
    };
    class dorb_tfr_SR_disp : dorb_tfr_body {
        idc = IDC_TFR_DISP_SR;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 28.8;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 9.1;
        w = GUI_GRID_CENTER_W * 4.5;
        h = GUI_GRID_CENTER_H * 1.6;
//        x = GUI_XW(0,0.66);
//        y = GUI_YH(0,0.28);
//        w = GUI_W(0.07);
//        h = GUI_H(0.04);
//        sizeEx = GUI_H(0.035);
        sizeEx = GUI_GRID_CENTER_H * 1.2;
        text = "";
    };
    class dorb_tfr_LR_disp : dorb_tfr_SR_disp {
        idc = IDC_TFR_DISP_LR;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10.6;
//        y = GUI_YH(0,0.34125);
        text = "";
    };
    class dorb_tfr_DD_disp : dorb_tfr_SR_disp {
        idc = IDC_TFR_DISP_DD;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 12.5;
//        y = GUI_YH(0,0.4025);
        text = "";
    };
    class dorb_tfr_SR_edit : RSC(BaseEditBox) {
        idc = IDC_TFR_EDIT;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 28.8;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 19.2;
        w = GUI_GRID_CENTER_W * 4.5;
        h = GUI_GRID_CENTER_H * 1.6;
//        x = GUI_XW(0,0.66);
//        y = GUI_YH(0,0.545);
//        w = GUI_W(0.07);
//        h = GUI_H(0.038);
//        sizeEx = GUI_H(0.035);
        sizeEx = GUI_GRID_CENTER_H * 1.2;
        textcolor[] = UI_CL_BODY_TEXT;
        text = "";
    };
    class dorb_tfr_LR_edit : dorb_tfr_SR_edit {
        idc = IDC_TFR_EDIT_LR;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 21.1;
//        y = GUI_YH(0,0.60375);
        text = "";
    };
    class dorb_tfr_DD_edit : dorb_tfr_SR_edit {
        idc = IDC_TFR_EDIT_DD;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 23;
//        y = GUI_YH(0,0.6625);
        text = "";
    };
    class dorb_tfr_list : RSC(BaseListboxN) {
        idc = IDC_TFR_LIST;
        access = 2;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 1;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 0.5;
        w = GUI_GRID_CENTER_W * 22;
        h = GUI_GRID_CENTER_H * 19;
//        x = GUI_XW(0,0.12);
//        y = GUI_YH(0,0.22);
//        w = GUI_W(0.46);
//        h = GUI_H(0.48);
//        rowHeight = GUI_H(0.035);
//        sizeEx = GUI_H(0.025);
        rowHeight = GUI_GRID_CENTER_H * 1.2;
        sizeEx = GUI_GRID_CENTER_H * 1;
//        columns[] = {0.0,GUI_W(0.42),GUI_W(0.5)};
        columns[] = {0.0,(GUI_GRID_CENTER_W * 15),(GUI_GRID_CENTER_W * 19)};
    };
    class dorb_tfr_take : RSC(BaseButton) {
        idc = IDC_TFR_TAKE;
        x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 33.5;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 10.35;
        w = GUI_GRID_CENTER_W * 6;
        h = GUI_GRID_CENTER_H * 3.5;
//        x = GUI_XW(0,0.77);
//        y = GUI_YH(0,0.32125);
//        w = GUI_W(0.11);
//        h = GUI_H(0.08);
        text = ECSTRING(gui_tfr,TAKE);
        toolTip = ECSTRING(gui_tfr,TAKE_TOOLTIP);
        sizeEx = GUI_GRID_CENTER_H * 1.2;
//        sizeEx = GUI_H(0.03);
        colorBackground[] = UI_CL_CTRL_WEINROT1;
        colorBackgroundActive[] = UI_CL_CTRL_WEINROT2;
        colorFocused[] = UI_CL_CTRL_WEINROT1;
        action = QUOTE([] call FUNC(setFreq););
    };
    class dorb_tfr_set : dorb_tfr_take {
        idc = IDC_TFR_SET;
        y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 20.45;
//        y = GUI_YH(0,0.58375);
        text = ECSTRING(gui_tfr,SET);
        toolTip = ECSTRING(gui_tfr,SET_TOOLTIP);
        action = QUOTE([] call FUNC(setGroup););
    };
};
