#define INCLUDE_DIALOG
#include "script_component.hpp"

/*extern*/ class RscButton;

class GVAR(dlgBase) {
    idd = -1;
    name = "";
    onLoad = "";
    onUnload = "";
    class controlsBackground {
        class TabletPicture {
            idc = IDC_TABLET_BACKGROUND;
            shadow = 0;
            colorText[]={1,1,1,1};
            tooltipColorText[]={1,1,1,1};
        	tooltipColorBox[]={1,1,1,1};
        	tooltipColorShade[]={0,0,0,0.64999998};
            x = GUI_TAB_BACK_X;
            y = GUI_TAB_BACK_Y;
            w = GUI_TAB_BACK_W;
            h = GUI_TAB_BACK_H;
            //text = QPATHTOF(ui\tablet_background.paa);
            text = "tab_acre\data\tablet_background.paa"
        };
        class displayArea {
            idc = IDC_TABLET_BACKGROUND;
            shadow = 0;
            colorText[] = {1,1,1,1};
            tooltipColorText[]={1,1,1,1};
            tooltipColorBox[]={1,1,1,1};
            tooltipColorShade[]={0,0,0,0.64999998};
            x = GUI_TAB_X;
            y = GUI_TAB_Y;
            w = GUI_TAB_W;
            h = GUI_TAB_H;
        };
    };
    class objects {};
    class controls {};
};

class GVAR(Shortcut_Base) {
    idc = -1;
    type = 1;
    style = "48 + 0x800";
    action = "";
    borderSize = 0;
    colorBackground = COLOR_DISABLED;
    colorBackgroundActive = COLOR_DISABLED;
    colorBackgroundDisabled = COLOR_DISABLED;
    colorBorder = COLOR_DISABLED;
    colorShadow = COLOR_DISABLED;

    colorDisabled = COLOR_SHORT_DISBLED;
    colorFocused = COLOR_SHORT_FOCUSED;
    colorText = COLOR_SHORT_TEXT;
    default = false;

    x = GUI_TAB_X;
    y = GUI_TAB_Y;
    w = GUI_TAB_W * 7;
    h = GUI_TAB_H * 7;

    offsetPressedX = 0;
    offsetPressedY = 0;

    offsetX = 0;
    offsetY = 0;

    soundEnter[]= {};
    soundPush[]= {};
    soundClick[]= {};
    soundEscape[]= {};

    text = "";
    toolTip = "";

    class attributes {
        font = "";
        shadow = 0;
        align = "center";
        color = "#000000";
    };
};
