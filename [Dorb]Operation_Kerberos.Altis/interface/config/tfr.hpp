/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"

class GVAR(tfr) {
    idd = 700200;
    name = "Task Force Radio Tool";
    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(tfrMenu)', _this select 0)]; [ARR_2('GVAR(tfrMenu)', true)] call FUNC(disp_blur););
    onUnload = QUOTE([ARR_2('GVAR(tfrMenu)',false)] call FUNC(disp_blur); [ARR_2('GVAR(tfr_onOpenEH)', 'onEachFrame')] call BIS_fnc_removeStackedEventHandler;);

    controlsBackground[] = {
        dorb_tfr_body,
        dorb_tfr_body2,
        dorb_tfr_body3,
        dorb_tfr_header,
        dorb_tfr_frequenzen,
        dorb_tfr_SR_name,
        dorb_tfr_LR_name,
        //dorb_tfr_DD_name
        dorb_tfr_SR_name2,
        dorb_tfr_LR_name2,
        //dorb_tfr_DD_name2
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
    class dorb_tfr_body : dorb_gui_backgroundBase {
        x = GUI_XW(0,0.1);
        y = GUI_YH(0,0.2);
        w = GUI_W(0.5);
        h = GUI_H(0.52);
        text = "";
        colorBackground[] = UI_CL_BODY;
        colorText[] = UI_CL_BODY_TEXT;
    };
    class dorb_tfr_body2 : dorb_tfr_body {
        x = GUI_XW(0,0.605);
        y = GUI_YH(0,0.2625);
        w = GUI_W(0.295);
        h = GUI_H(0.1975);
    };
    class dorb_tfr_body3 : dorb_tfr_body2 {
        y = GUI_YH(0,0.5275);
        h = GUI_H(0.1925);
    };
    class dorb_tfr_bodyLB : dorb_tfr_body {
        x = GUI_XW(0,0.12);
        y = GUI_YH(0,0.22);
        w = GUI_W(0.46);
        h = GUI_H(0.48);
        colorBackground[] = UI_CL_CTRL_GRAU1;
    };
    class dorb_tfr_header : dorb_tfr_body {
        idc = -1;
        y = GUI_YH(0,0.1);
        h = GUI_H(0.09);
        w = GUI_W(0.8);
        text = ECSTRING(INTERFACE,TFR_HEADER);
        colorText[] = UI_CL_HEADER_TEXT;
        colorBackground[] = UI_CL_HEADER;
    };
    class dorb_tfr_frequenzen : dorb_tfr_body {
        x = GUI_XW(0,0.605);
        y = GUI_YH(0,0.2);
        w = GUI_W(0.295);
        h = GUI_H(0.06);
        sizeEx = GUI_H(0.035);
        text = ECSTRING(INTERFACE,TFR_FREQ_SQUAD);
        colorBackground[]=UI_CL_HEADER2;
    };
    class dorb_tfr_frequenzen_neu : dorb_tfr_frequenzen {
        y = GUI_YH(0,0.465);
        text = ECSTRING(INTERFACE,TFR_FREQ_NEW);
    };
    class dorb_tfr_SR_name : dorb_tfr_body {
        x = GUI_XW(0,0.62);
        y = GUI_YH(0,0.28);
        w = GUI_W(0.03);
        h = GUI_H(0.04);
        sizeEx = GUI_H(0.035);
        text = "SR:";
    };
    class dorb_tfr_LR_name : dorb_tfr_SR_name {
        y = GUI_YH(0,0.34125);
        text = "LR:";
    };
    class dorb_tfr_DD_name : dorb_tfr_SR_name {
        y = GUI_YH(0,0.4025);
        text = "DD";
    };
    class dorb_tfr_SR_name2 : dorb_tfr_SR_name {
        y = GUI_YH(0,0.545);
        text = "SR";
    };
    class dorb_tfr_LR_name2 : dorb_tfr_SR_name {
        y = GUI_YH(0,0.60375);
        text = "LR:";
    };
    class dorb_tfr_DD_name2 : dorb_tfr_SR_name {
        y = GUI_YH(0,0.6625);
        text = "DD";
    };
    class dorb_tfr_SR_disp : dorb_tfr_body {
        idc = 700202;
        x = GUI_XW(0,0.66);
        y = GUI_YH(0,0.28);
        w = GUI_W(0.07);
        h = GUI_H(0.04);
        sizeEx = GUI_H(0.035);
        text = "";
    };
    class dorb_tfr_LR_disp : dorb_tfr_SR_disp {
        idc = 700203;
        y = GUI_YH(0,0.34125);
        text = "";
    };
    class dorb_tfr_DD_disp : dorb_tfr_SR_disp {
        idc = 700204;
        y = GUI_YH(0,0.4025);
        text = "";
    };
    class dorb_tfr_SR_edit : dorb_gui_editBase {
        idc = 700205;
        x = GUI_XW(0,0.66);
        y = GUI_YH(0,0.545);
        w = GUI_W(0.07);
        h = GUI_H(0.038);
        sizeEx = GUI_H(0.035);
        textcolor[] = UI_CL_BODY_TEXT;
        text = "";
    };
    class dorb_tfr_LR_edit : dorb_tfr_SR_edit {
        idc = 700206;
        y = GUI_YH(0,0.60375);
        text = "";
    };
    class dorb_tfr_DD_edit : dorb_tfr_SR_edit {
        idc = 700207;
        y = GUI_YH(0,0.6625);
        text = "";
    };
    class dorb_tfr_list : dorb_gui_listboxN {
        idc = 700201;
        access = 2;
        x = GUI_XW(0,0.12);
        y = GUI_YH(0,0.22);
        w = GUI_W(0.46);
        h = GUI_H(0.48);
        rowHeight = GUI_H(0.035);
        sizeEx = GUI_H(0.025);
        columns[] = {0.0,GUI_W(0.42),GUI_W(0.5)};
    };
    class dorb_tfr_take : dorb_gui_button {
        idc = 700208;
        x = GUI_XW(0,0.77);
        y = GUI_YH(0,0.32125);
        w = GUI_W(0.11);
        h = GUI_H(0.08);
        text = ECSTRING(INTERFACE,TFR_TAKE);
        toolTip = ECSTRING(INTERFACE,TFR_TAKE_TOOLTIP);
        sizeEx = GUI_H(0.03);
        colorBackground[] = UI_CL_CTRL_WEINROT1;
        colorBackgroundActive[] = UI_CL_CTRL_WEINROT2;
        colorFocused[] = UI_CL_CTRL_WEINROT1;
        action = QUOTE([] call FUNC(tfr_setFreq););
    };
    class dorb_tfr_set : dorb_tfr_take {
        idc = 700209;
        y = GUI_YH(0,0.58375);
        text = ECSTRING(INTERFACE,TFR_SET);
        toolTip = ECSTRING(INTERFACE,TFR_SET_TOOLTIP);
        action = QUOTE([] call FUNC(tfr_setGroup););
    };
};
