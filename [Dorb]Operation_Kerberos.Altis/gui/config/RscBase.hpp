class RSC(BaseScrollbar) {
    color[]={1,1,1,0.60000002};
    colorActive[]={1,1,1,1};
    colorDisabled[]={1,1,1,0.30000001};
    thumb="\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    arrowEmpty="\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    arrowFull="\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    border="\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    shadow=0;
    scrollSpeed=0.059999999;
    width=0;
    height=0;
    autoScrollEnabled=0;
    autoScrollSpeed=-1;
    autoScrollDelay=5;
    autoScrollRewind=0;
};

class RSC(BaseControlsGroup) {
	type=15;
	idc=-1;
	x=0;
	y=0;
	w=1;
	h=1;
	shadow=0;
	style=16;
	class VScrollbar: RSC(BaseScrollbar) {
		width=0.021;
		autoScrollEnabled=1;
	};
	class HScrollbar: RSC(BaseScrollbar) {
		height=0.028000001;
	};
	class Controls {};
};
class RSC(BaseControlsGroupNoScrollbar) : RSC(BaseControlsGroup) {
    class VScrollbar: VScrollbar {
        width=0;
    };
    class HScrollbar: HScrollbar {
        height=0;
    };
};
class RSC(BaseControlsGroupNoHScrollbar) : RSC(BaseControlsGroup) {
    class HScrollbar: HScrollbar {
        height=0;
    };
};
class RSC(BaseControlsGroupNoVScrollbar) : RSC(BaseControlsGroup) {
    class VScrollbar: VScrollbar {
        width=0;
    };
};

class RSC(BaseStructuredText) {
    idc = -1;
    type = 13;  // defined constant
    style = 0x00;            // defined constant
    colorBackground[] = COLOR_BACKGROUND;
    size = GUI_TEXT_SIZE_MEDIUM;
    text = "";
    class Attributes {
        font = GUI_FONT_NORMAL;
        color = "#000000";
        align = "left";
        valign = "middle";
        shadow = 0;
        shadowColor = "#ff0000";
        size = 1;
    };
};


class RSC(BaseText) {
    idc = -1;
    type = 0;
    style = "0x00";
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    shadow = 0;
    colorShadow[] = COLOR_DISABLED;
    text = "";
    font = FONT_DEFAULT;
    colorText[] = COLOR_FONT;
    colorBackground[] = COLOR_BACKGROUND;
    /*
    tooltipColorText[] = COLOR_DISABLED;
    tooltipColorBox[] = COLOR_DISABLED;
    tooltipColorShade[] = COLOR_DISABLED;
    */
    tooltipColorText[] = COLOR_FONT;
    tooltipColorBox[] = COLOR_BACKGROUND;
    tooltipColorShade[] = COLOR_BACKGROUND;
    access = 0;
};
class RSC(BasePicture) : RSC(BaseText) {
    idc = -1;
    style = "48 + 0x800";
};

class RSC(BaseShortcut) {
    idc = -1;
    type = 1;
    style = "48 + 0x800";
    action = "";
    text = "";

    shadow = 0;
    font = FONT_DEFAULT;
    sizeEx = GUI_TAB_W * 1;

    colorBackground[] = COLOR_BACKGROUND;
    colorBackgroundActive[] = COLOR_BACKGROUND_FOCUSED;
    colorBackgroundDisabled[] = COLOR_DISABLED;
    colorBorder[] = COLOR_DISABLED;
    colorShadow[] = COLOR_DISABLED;

    colorDisabled[] = COLOR_SHORT_DISABLED;
    colorFocused[] = COLOR_SHORT_FOCUSED;
    colorText[] = COLOR_SHORT_TEXT;

    default = 0;

    x = GUI_TAB_X;
    y = GUI_TAB_Y;
    w = GUI_TAB_W * 7;
    h = GUI_TAB_H * 7;

    offsetPressedX = 0;
    offsetPressedY = 0;

    offsetX = 0;
    offsetY = 0;

    borderSize = 0;
    soundEnter[]= {};
    soundPush[]= {};
    soundClick[]= {};
    soundEscape[]= {};


};

class RSC(BaseSwitch) : RSC(BaseControlsGroup) {
    idc = -1;
    x = 0;
    y = 0;
    h = (GUI_TAB_W * 10);
    w = (GUI_TAB_W * 60);

    onMouseEnter = QUOTE([ARR_2(_this,'enter')] call FUNC(switch););
    onMouseExit = QUOTE([ARR_2(_this,'exit')] call FUNC(switch););
    onMouseButtonDown = QUOTE([ARR_2(_this,'click')] call FUNC(switch););

    style = 0;

    text_on = QPATHTOF(ui\switch_on.paa);
    text_off = QPATHTOF(ui\switch_on.paa);


    class VScrollbar {
        color[] = COLOR_DISABLED;
        width = 0;
        autoScrollSpeed = -1;
        autoScrollDelay = 0;
        autoScrollRewind = 0;
    };

    class HScrollbar {
        color[] = COLOR_DISABLED;
        height = 0;
    };

    class Controls {
        class background : RSC(BaseText) {
            idc = -1000;
            colorText[] = COLOR_DISABLED;
            x = 1;
            y = 1;
            w = 1;
            h = 1;
        };
        class slider : RSC(BasePicture) {
            idc = -1500;
            x = 0;
            y = 0.05;
            w = 0.2;
            h = 0.9;
        };
        class text : RSC(BaseText) {
            idc = -2000;
            x = 0.2;
            y = 0.05;
            w = 0.8;
            h = 0.9;
            sizeEx = 0.9;
            colorBackground[] = COLOR_DISABLED;
        };
    };
};

class RSC(BaseListboxN) {
    access = 0;
    type = 102;// 102;
    style = "0x10";
    font = GUI_FONT_NORMAL;
    sizeEx = IGUI_TEXT_SIZE_MEDIUM;
    colorText[] = {0.098,0.098,0.439,1};
    colorBackground[] = {0.502,0.502,0.502,1};
    canDrag = false;

    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    columns[] = {0.3, 0.6, 0.7};
    color[] = {0.502,0.502,0.502,1};
    colorScrollbar[] = {0.753,0.753,0.753,1};
    colorSelect[] = {0.502,0.502,0.502,1};
    colorSelect2[] = {0.502,0.502,0.502,1};
    colorDisabled[] = {0.502,0.502,0.502,1};
    colorSelectBackground[] = {0.863,0.863,0.863,1};
    colorSelectBackground2[] = {0.863,0.863,0.863,1};

    pictureColor[] = {0.502,0.502,0.502,1}; // Picture color
    pictureColorSelect[] = {0.301,0.301,0.301,1}; // Selected picture color
    pictureColorDisabled[] = {0.863,0.863,0.863,1}; // Disabled picture color

    drawSideArrows = 0;
    idcLeft = -1;
    idcRight = -1;
    maxHistoryDelay = 1;
    rowHeight = 0;
    soundSelect[] = {"", 0.1, 1};
    period = 1;
    lineSpacing = 1;
    shadow = 0;
    class ScrollBar {
        arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
        arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
        border = "#(argb,8,8,3)color(1,1,1,1)";
        color[] = {0.502,0.502,0.502,1};
        colorActive[] = {0.863,0.863,0.863,1};
        colorDisabled[] = {0.863,0.863,0.863,1};
        thumb = "#(argb,8,8,3)color(1,1,1,1)";
    };
    class ListScrollBar {
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        autoScrollDelay = 5;
        autoScrollEnabled = 0;
        autoScrollRewind = 0;
        autoScrollSpeed = -1;
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        color[] = {0.502,0.502,0.502,1};
        colorActive[] = {0.863,0.863,0.863,1};
        colorDisabled[] = {0.863,0.863,0.863,1};
        height = 0;
        scrollSpeed = 0.06;
        shadow = 0;
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        width = 0;
    };
};

class RSC(BaseObject) {
    idc = -1;
    type = 82;
    movingEnable = false;    // true to enable moving dialog with mouse
    enableZoom = 0;
    zoomDuration = 0.001;
    inBack = 1;
    model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
    direction[] = {0,0.5,0.5};
    up[]={0,1,0};
    scale = "0.47 * 0.875 * (SafeZoneW Min SafeZoneH)";
    xBack = 0.5;
    yBack = 0.5;
    zBack = 1.2;
    // x and y are the position on the screen.
    // current x and y put the top left corner of the object into the top left corner of the screen.
    // Use z in addition to scale to fine tune the size/ zoom of the object
    x = (0 * safezoneW + safezoneX);
    y = (0 * safezoneH + safezoneY);
    z = 2;
};

class RSC(BaseButton) {
    access = 0;
    type = 1;
    style = "0x02";
    text = "";
    font = GUI_FONT_NORMAL;
    sizeEx = GUI_GRID_CENTER_H;
    colorText[] = COLOR_TABLET_MAIN_BTTN_TEXT;
    colorDisabled[] = COLOR_DISABLED;
    colorBackground[] = COLOR_TABLET_MAIN_BTTN;
    colorBackgroundActive[] = COLOR_TABLET_MAIN_BTTN_SELECTED;
    colorFocused[] = COLOR_TABLET_MAIN_BTTN_TEXT_SELECTED;
    colorBackgroundDisabled[] = COLOR_DISABLED;
    offsetX = 0.004;
    offsetY = 0.004;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    colorShadow[] = {0,0,0,1};
    shadow = 0;
    colorBorder[] = {0,0,0,1};
    borderSize = 0;
    soundEnter[] = {"",0.1,1};
    soundPush[] = {"",0.1,1};
    soundClick[] = {"",0.1,1};
    soundEscape[] = {"",0.1,1};
    onButtonClick = "";
};
