
class RSC(BaseStructuredText) {
//    idc = -1;
    type = 13;
    style = "0x00";
    colorBackground[] = COLOR_BACKGROUND;
    size = TEXT_SIZE_MEDIUM;
    text = "";
    class Attributes {
        font = FONT_DEFAULT;
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
    sizeEx = TEXT_SIZE_MEDIUM;
    shadow = 0;
    colorShadow[] = COLOR_DISABLED;
    text = "";
    font = FONT_DEFAULT;
    colorText[] = COLOR_FONT;
    colorBackground[] = COLOR_BACKGROUND;
    tooltipColorText[] = COLOR_FONT;
    tooltipColorBox[] = COLOR_BACKGROUND;
    tooltipColorShade[] = COLOR_BACKGROUND;
    access = 0;
};

class RSC(BasePicture) : RSC(BaseText) {
    style = "48+0x800";
};

class RSC(BasePictureNoScale) : RSC(BaseText) {
    style = "48";
};

class RSC(BaseButton) {
    access = 0;
    type = 1;
    style = "0x02";
    text = "";
    font = FONT_DEFAULT;
    sizeEx = GUI_DISP_H*2;
    colorText[] = {1,1,1,1};
    colorDisabled[] = COLOR_DISABLED;
    colorBackground[] = {0,0,0,1};
    colorBackgroundActive[] = {0,1,0,0.7};
    colorFocused[] = {0,1,0,1};
    colorBackgroundDisabled[] = COLOR_DISABLED;
    offsetX = 0.004;
    offsetY = 0.004;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    colorShadow[] = COLOR_DISABLED;
    shadow = 0;
    colorBorder[] = COLOR_DISABLED;
    borderSize = 0;
    soundEnter[] = {"",0.1,1};
    soundPush[] = {"",0.1,1};
    soundClick[] = {"",0.1,1};
    soundEscape[] = {"",0.1,1};
    onButtonClick = "";
};

class RSC(BaseButtonPicture) : RSC(BaseButton) {
    style = "48+0x800";
};

class RSC(BaseScrollbar) {
    color[] = {1,1,1,0.60000002};
    colorActive[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.30000001};
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

class RSC(AnimBttn_background) : RSC(BasePicture) {
    idc = -1;
    x = 0;
    y = 0;
    w = GUI_DISP_W*10;
    h = GUI_DISP_H*10;
    text = __EVAL(MISSION_ROOT + 'gui\data\buttons\button_256_normal.paa');
    shadow = 0;
    colorShadow[] = COLOR_DISABLED;
    font = FONT_DEFAULT;
    colorText[] = {0.66667,0.25098,1,1};
};

class RSC(AnimBttn) : RSC(BaseButton) {
    idc = -1;
    x = 0;
    y = 0;
    w = GUI_DISP_W*10;
    h = GUI_DISP_H*10;
    sizeEx = GUI_DISP_H*2;
    text = "";
    style = "48+0x800";
    colorBackground[]= COLOR_DISABLED;
    colorBackgroundActive[]= COLOR_DISABLED;
    colorFocused[]= COLOR_DISABLED;
    colorBackgroundDisabled[]= COLOR_DISABLED;
    colorDisabled[] = COLOR_DISABLED;
    colorText[] = COLOR_ANIMBTTN_TEXT;
    shadow = 0;
    colorShadow[] = COLOR_DISABLED;
    font = FONT_DEFAULT;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
};

class RSC(AnimTextBttn) : RSC(AnimBttn) {
    style = "0x02";
};

class RSC(ControlsTable) {
    idc = -1;
    x = GUI_DISP_X;
    y = GUI_DISP_Y;
    w = GUI_DISP_WAbs;
    h = GUI_DISP_HAbs;

    type = 19;
    style = 0x10;

    lineSpacing = 0;
    rowHeight = GUI_DISP_H*2;
    headerHeight = GUI_DISP_H*2;

    firstIDC = 42000;
    lastIDC = 44999;

    // Colours which are used for animation (i.e. change of colour) of the selected line.
    selectedRowColorFrom[]  = {0.7, 0.85, 1, 0.25};
    selectedRowColorTo[]    = {0.7, 0.85, 1, 0.5};
    // Length of the animation cycle in seconds.
    selectedRowAnimLength = 1.2;

    class VScrollBar: RSC(BaseScrollbar) {
        width = 0.021;
        autoScrollEnabled = 0;
        autoScrollDelay = 1;
        autoScrollRewind = 1;
        autoScrollSpeed = 1;
    };

    class HScrollBar: RSC(BaseScrollbar) {
        height = 0.028;
    };

    // Template for selectable rows
    class RowTemplate {
        class RowBackground {
            controlBaseClassPath[] = {"RscText"};
            columnX = 0;
            columnW = GUI_DISP_W*50;
            controlOffsetY = 0;
        };
        class Column1 {
            controlBaseClassPath[] = {"RscPictureKeepAspect"};
            columnX = 0;
            columnW = GUI_DISP_W*10;
            controlOffsetY = 0;
            controlH = GUI_DISP_H*2;
        };
        class Column2 {
            controlBaseClassPath[] = {"RscText"};
            columnX = GUI_DISP_W*10;
            columnW = GUI_DISP_W*20;
            controlOffsetY = 0;
        };
        class Column3 {
            controlBaseClassPath[] = {"RscButton"};
            columnX = GUI_DISP_W*30;
            columnW = GUI_DISP_W*20;
            controlOffsetY = 0;
        };
    };

    // Template for headers (unlike rows, cannot be selected)
    class HeaderTemplate {
        class HeaderBackground {
            controlBaseClassPath[] = {"RscText"};
            columnX = 0;
            columnW = GUI_DISP_W*50;
            controlOffsetY = 0;
        };
        class Column1 {
            controlBaseClassPath[] = {"RscPictureKeepAspect"};
            columnX = 0;
            columnW = GUI_DISP_W*25;
            controlOffsetY = 0;
            controlH = GUI_DISP_H*2;
        };
        class Column2 {
            controlBaseClassPath[] = {"RscText"};
            columnX = GUI_DISP_W*25;
            columnW = GUI_DISP_W*25;
            controlOffsetY = 0;
        };
    };
};

class RSC(BaseCheckBoxSwitch) {
    idc = -1;
    type = 77;
    deletable = 0;
    style = 0;
    checked = 0;
    x = GUI_DISP_X;
    y = GUI_DISP_Y;
    w = GUI_DISP_W;
    h = GUI_DISP_H;
    color[] = {1, 1, 1, 0.69999999};
    colorFocused[] = {1, 1, 1, 1};
    colorHover[] = {1, 1, 1, 1};
    colorPressed[] = {1, 1, 1, 1};
    colorDisabled[] = {1, 1, 1, 0.2};
    colorBackground[] = {0, 0, 0, 0};
    colorBackgroundFocused[] = {0, 0, 0, 0};
    colorBackgroundHover[] = {0, 0, 0, 0};
    colorBackgroundPressed[] = {0, 0, 0, 0};
    colorBackgroundDisabled[] = {0, 0, 0, 0};
    textureChecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_checked.paa");
    textureUnchecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_unchecked.paa");
    textureFocusedChecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_checked.paa");
    textureFocusedUnchecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_unchecked.paa");
    textureHoverChecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_checked.paa");
    textureHoverUnchecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_unchecked.paa");
    texturePressedChecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_checked.paa");
    texturePressedUnchecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_unchecked.paa");
    textureDisabledChecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_checked.paa");
    textureDisabledUnchecked = __EVAL(MISSION_ROOT + "gui\data\checkbox\checkbox_unchecked.paa");
    tooltipColorText[] = {1, 1, 1, 1};
    tooltipColorBox[] = {1, 1, 1, 1};
    tooltipColorShade[] = {0, 0, 0, 0.64999998};
    soundEnter[] = {"", 0.1, 1};
    soundPush[] = {"", 0.1, 1};
    soundClick[] = {"", 0.1, 1};
    soundEscape[] = {"", 0.1, 1};
};

class RSC(BaseObjectContainer) {
    idc = -1;
    type = 82;
    model = "";
    scale = 1;
    direction[] = {0, -0.35, -0.65};
    up[] = {0, 0.65, -0.35};
    x = 0.5;
    y = 0.5;
    z = 0.2;
    xBack = 0.5;
    yBack = 0.5;
    zBack = 1.2;
    inBack = 1;
    enableZoom = 1;
    zoomDuration = 0.001;
};

class RSC(BaseEditBox) {
    x = GUI_DISP_X;
    y = GUI_DISP_Y;
    w = GUI_DISP_W;
    h = GUI_DISP_H;
    access = 0;
    type = 2;
    style = "0x40+0x00";
    colorBackground[] = COLOR_BASE_BLACK;
    colorText[] = COLOR_BASE_WHITE;
    colorSelection[] = COLOR_BASE_WHITE;
    colorDisabled[] = COLOR_BASE_BLACK;
    font = FONT_DEFAULT;
    sizeEx = GUI_DISP_H;
    autocomplete = "";
    text = "";
    size = GUI_DISP_H;
    shadow = 0;
};

class RSC(BaseListboxN) {
    access = 0;
    type = 102;// 102;
    style = "0x10";
    font = FONT_DEFAULT;
    sizeEx = GUI_GRID_H;
    colorText[] = COLOR_BASE_WHITE;
    colorBackground[] = COLOR_BASE_BLACK;
    canDrag = false;

    autoScrollSpeed = -1;
    autoScrollDelay = 5;
    autoScrollRewind = 0;
    arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
    arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
    columns[] = {0.3, 0.6, 0.7};
    color[] = COLOR_BASE_BLACK;
    colorScrollbar[] = {0.753,0.753,0.753,1};
    colorSelect[] = COLOR_BASE_BLACK;
    colorSelect2[] = COLOR_BASE_BLACK;
    colorDisabled[] = COLOR_BASE_BLACK;
    colorSelectBackground[] = {0.863,0.863,0.863,1};
    colorSelectBackground2[] = {0.863,0.863,0.863,1};

    pictureColor[] = COLOR_BASE_WHITE;
    pictureColorSelect[] = {0.301,0.301,0.301,1};
    pictureColorDisabled[] = {0.863,0.863,0.863,1};

    drawSideArrows = 0;
    idcLeft = -1;
    idcRight = -1;
    maxHistoryDelay = 1;
    rowHeight = 0;
    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
    period = 1;
    lineSpacing = 1;
    shadow = 0;
    class ScrollBar {
        arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
        arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
        border = "#(argb,8,8,3)color(1,1,1,1)";
        color[] = COLOR_BASE_BLACK;
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
        color[] = COLOR_BASE_BLACK;
        colorActive[] = {0.863,0.863,0.863,1};
        colorDisabled[] = {0.863,0.863,0.863,1};
        height = 0;
        scrollSpeed = 0.06;
        shadow = 0;
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        width = 0;
    };
};

class RSC(SortButton) : RSC(BaseButtonPicture) {
    w = GUI_DISP_W*4;
    h = GUI_DISP_H*4;
    text = "\a3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa";
    onButtonClick = QUOTE([ARR_2('switch',_this)] call EFUNC(gui,sortButton);true);
    onLoad = QUOTE([ARR_2('switch',_this)] call EFUNC(gui,sortButton);true);
    colorText[] = COLOR_BASE_WHITE;
    colorDisabled[] = COLOR_DISABLED;
    colorBackground[] = COLOR_BASE_BLACK;
    colorBackgroundActive[] = COLOR_BASE_BLACK;
    colorFocused[] = COLOR_BASE_BLACK;
};
