/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

class GVAR(wounds) {
    idd = 600998;
    name = "wounds";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(wounds)', _this select 0)]; [ARR_2('GVAR(wounds)',true)] call FUNC(disp_blur););
    onUnload = QUOTE([ARR_2('GVAR(wounds)',false)] call FUNC(disp_blur););

    controlsBackground[] = {
        wounds_Background
    };

    class wounds_Background: dorb_gui_pictureBase {
        x = safezoneX + GUI_GRID_W;
        y = safezoneY + GUI_GRID_H;
        w = safezoneW - 2*GUI_GRID_W;
        h = safezoneH - 2*GUI_GRID_H;
        text = "data\wundsystem.paa";
    };
};
class GVAR(treatment) {
    idd = 600999;
    name = "treatment";

    movingEnable = 0;
    enableSimulation = 1;
    fadein = 0;
    fadeout = 0;
    duration = 1000000;
    objects[] = {};
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(treatment)', _this select 0)]; [ARR_2('GVAR(treatment)',true)] call FUNC(disp_blur););
    onUnload = QUOTE([ARR_2('GVAR(treatment)',false)] call FUNC(disp_blur););

    controlsBackground[] = {
        treatment_Background
    };

    class treatment_Background: dorb_gui_pictureBase {
        x = safezoneX + GUI_GRID_W;
        y = safezoneY + GUI_GRID_H;
        w = safezoneW - 2*GUI_GRID_W;
        h = safezoneH - 2*GUI_GRID_H;
        text = "data\versorgung.paa";
    };
};
