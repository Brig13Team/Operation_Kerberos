/*
    Author: Dorbedo
*/

#define CBA_OFF
#include "script_component.hpp"
class APP(dialog) : RSC(echidna) {
    idd = IDD_ECHIDNA_ARSENAL;
    controlsBackground[] = {
        background_taskbar,
        background_display,
        display_background
    };
    controls[] = {
        clock,
        menu_button,

        display_background,
        properties_list,
        loadButton,

        metro_back,
        metro,
        metro_side,
        background_device
    };

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););

    class display_background: RSC(BaseText) {
        idc = -1;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        text = "";
        colorBackground[] = {RAL9010,1};
        colorText[] = COLOR_DISABLED;
    };
    class properties_list : RSC(BaseListbox) {
        access = 1;
        idc = IDC_ECHIDNA_ARSENAL_LIST;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H;
        w = GUI_ECHIDNA_W * 38;
        h = GUI_ECHIDNA_H * 23;
        sizeEx = GUI_ECHIDNA_H;
        rowHeight = GUI_ECHIDNA_H;
        tooltip = "";
        color[] = {RAL9005,1};
        colorScrollbar[] = {RAL9005,1};
        colorSelect[] = {RAL9005,1};
        colorSelect2[] = {RAL9005,1};
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = {RAL9002,1};
        colorSelectBackground2[] = {RAL9002,1};
        colorText[] = {RAL9005,1};
        colorBackground[] = {RAL7047,1};
    };
    class loadButton : RSC(BaseButton) {
        idc = IDC_ECHIDNA_ARSENAL_BTTN;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 34;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 25;
        w = GUI_ECHIDNA_W * 5;
        h = GUI_ECHIDNA_H * 2;
        text = "load";
    };
};
