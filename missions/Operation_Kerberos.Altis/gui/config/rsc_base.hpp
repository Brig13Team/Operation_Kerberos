
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
    text = __EVAL(MISSION_ROOT + 'COMPONENT\data\buttons\button_256_normal.paa');
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

class RSC(BaseCheckBox) {
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
    textureChecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureChecked_ca.paa";
    textureUnchecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureUnchecked_ca.paa";
    textureFocusedChecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureChecked_ca.paa";
    textureFocusedUnchecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureUnchecked_ca.paa";
    textureHoverChecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureChecked_ca.paa";
    textureHoverUnchecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureUnchecked_ca.paa";
    texturePressedChecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureChecked_ca.paa";
    texturePressedUnchecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureUnchecked_ca.paa";
    textureDisabledChecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureChecked_ca.paa";
    textureDisabledUnchecked="\a3\3DEN\Data\Controls\ctrlCheckbox\baseline_textureUnchecked_ca.paa";
    tooltipColorText[] = {1, 1, 1, 1};
    tooltipColorBox[] = {1, 1, 1, 1};
    tooltipColorShade[] = {0, 0, 0, 0.64999998};
    soundEnter[] = {"", 0.1, 1};
    soundPush[] = {"", 0.1, 1};
    soundClick[] = {"", 0.1, 1};
    soundEscape[] = {"", 0.1, 1};
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

class RSC(BaseLoadingbar) {
    type = 8;
    style = 0;
    colorFrame[] = COLOR_BASE_GREY;
    colorBar[] = COLOR_BASE_GREY_LIGHT;
    texture = "#(argb,8,8,3)color(1,1,1,1)";
    w = 1;
    h = 0.03;
};

class RSC(BaseListbox) {
    access = 0;
    idc = 5;
    type = 5;
    style="0x00 + 0x10";
    default = 0;
    enable = 1;
    show = 1;
    fade = 0;
    blinkingPeriod = 0;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    colorBackground[] = {0.2,0.2,0.2,1};
    colorSelectBackground[] = {1,0.5,0,1};
    colorSelectBackground2[] = {0,0,0,1};
    sizeEx = (pixelH * pixelGrid * 3);
    font = FONT_DEFAULT;
    shadow = 0;
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.5};
    colorSelect[] = {1,1,1,1};
    colorSelect2[] = {1,1,1,1};
    colorShadow[] = {0,0,0,0.5};
    colorPicture[] = {1,0.5,0,1};
    colorPictureSelected[] = {1,1,1,1};
    colorPictureDisabled[] = {1,1,1,0.5};
    colorPictureRight[] = {1,0.5,0,1};
    colorPictureRightSelected[] = {1,1,1,1};
    colorPictureRightDisabled[] = {1,1,1,0.5};
    tooltip = "";
    tooltipColorShade[] = {0,0,0,1};
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    period = 1;
    rowHeight  =  (pixelH * pixelGrid * 4);
    itemSpacing = 0;
    maxHistoryDelay = 1;
    canDrag = 0;
    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.090000004,1};
    class ListScrollBar {
        width = 0;
        height = 0;
        scrollSpeed = 0.0099999998;
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        color[] = {1,1,1,1};
    };
};

#define NOISE(NUMBER) class strip##NUMBER : stripe1 {idc = IDC_LOADING_NOISE0##NUMBER ;}
#define NOISEW(NUMBER) class strip##NUMBER : stripe1 {idc = IDC_LOADING_NOISE0##NUMBER ;colorBackground[] = {ARR_2(RAL9010,0.35)};}

class RSC(BaseNoise) : RSC(BaseControlsGroupNoScrollbar) {
    idc = IDC_LOADING_NOISE;
    x = "safezoneXAbs";
    y = "safezoneY";
    w = "safezoneWAbs";
    h = "safezoneH";
    class controls {
        class stripe1 : RSC(BaseText) {
            idc = IDC_LOADING_NOISE1;
            x = 0;
            y = 0;
            w = 0;
            h = 0;
            colorBackground[] = {0.1568627,0.1568627,0.1568627,0.35};
        };
        NOISE(01);
        NOISE(02);
        NOISE(03);
        NOISE(04);
        NOISE(05);
        NOISE(06);
        NOISE(07);
        NOISE(08);
        NOISE(09);
        NOISE(10);
        NOISE(11);
        NOISE(12);
        NOISE(13);
        NOISE(14);
        NOISE(15);
        NOISE(16);
        NOISE(17);
        NOISE(18);
        NOISE(19);
        NOISE(20);
        NOISE(21);
        NOISE(22);
        NOISE(23);
        NOISE(24);
        NOISE(25);
        NOISE(26);
        NOISE(27);
        NOISE(28);
        NOISE(29);
        NOISEW(30);
        NOISEW(31);
        NOISEW(32);
        NOISEW(33);
        NOISEW(34);
        NOISEW(35);
        NOISEW(36);
        NOISEW(37);
        NOISEW(38);
        NOISEW(39);
        NOISEW(40);
        NOISEW(41);
        NOISEW(42);
        NOISEW(43);
        NOISEW(44);
        NOISEW(45);
        NOISEW(46);
        NOISEW(47);
        NOISEW(48);
        NOISEW(49);
        NOISEW(50);
    };
};

class RSC(loadingScreen) {
    idd = IDD_LOADING;
    onLoad = QUOTE(_this call FUNC(onLoadLoadingScreen););
    class controlsBackground {
        class black : RSC(BaseText) {
            colorBackground[] = COLOR_LOADING_BACKGROUND;
            x = safezoneXAbs;
            y = safezoneY;
            w = safezoneWAbs;
            h = safezoneH;
        };
    };
    class controls {
        class noise : RSC(BaseNoise) {};
        class progress : RSC(BaseLoadingbar) {
            idc = IDD_LOADING_PROGRESS;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 12;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 25;
            w = GUI_GRID_CENTER_W * 16;
            h = GUI_GRID_CENTER_H * 1;
            colorFrame[] = COLOR_LOADING_PROGRESS;
            colorBar[] = COLOR_LOADING_PROGRESSFRAME;
            texture = "#(argb,8,8,3)color(0.34,0.65,0.22,1)";
        };
        class backgroundcircle : RSC(BasePicture) {
            colorBackground[] = COLOR_LOADING_BACKGROUND;
            colorText[] = COLOR_LOADING_CIRCLEIN;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 10;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 5;
            w = GUI_GRID_CENTER_W * 20;
            h = GUI_GRID_CENTER_H * 20;
            text = QUOTE(COMPONENT\data\loadingscreen\loading_backIn.paa);
        };
        class circle : backgroundcircle {
            idc = IDD_LOADING_CIRCLE;
            colorText[] = COLOR_LOADING_CIRCLE;
            text = QUOTE(COMPONENT\data\loadingscreen\loading_circle.paa);
        };
        class backgroundLogo : backgroundcircle {
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 13;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 8;
            w = GUI_GRID_CENTER_W * 14;
            h = GUI_GRID_CENTER_H * 14;
            colorBackground[] = COLOR_LOADING_BACKGROUND;
            colorText[] = COLOR_LOADING_LOGO;
            text = QUOTE(COMPONENT\data\logo\logo_512w.paa);
        };
        class title : RSC(BaseText) {
            idc = IDD_LOADING_TITLE;
            colorText[] = COLOR_LOADING_TITLE;
            colorBackground[] = COLOR_DISABLED;
            x = GUI_GRID_CENTER_X;
            y = GUI_GRID_CENTER_Y;
            w = GUI_GRID_CENTER_W * 40;
            h = GUI_GRID_CENTER_H * 5;
            style = 0x02;
            text = "L o a d i n g  . . .";
            sizeEx = GUI_GRID_CENTER_H * 4;
            font = FONT_THIN;
        };
        class description : RSC(BaseText) {
            idc = IDD_LOADING_DESCRIPTION;
            colorText[] = COLOR_LOADING_TITLE;
            colorBackground[] = COLOR_DISABLED;
            x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_W * 12;
            y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_H * 25;
            w = GUI_GRID_CENTER_W * 16;
            h = GUI_GRID_CENTER_H * 1;
            sizeEx = GUI_GRID_CENTER_H * 0.92;
            //font = FONT_BOLD;
            style = 0x02;
            text = "";
        };
    };
};

class RSC(BaseCombobox) {
    access = 0;
    type = 4;
    style = 0x00;
    h = 0.05;
    wholeHeight = 0.25;
    colorSelect[] = {0.6,0.6,0.6,1};
    colorText[] = {1,1,1,1};
    colorBackground[] = {0.2,0.2,0.2,1};
    colorScrollbar[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.5};
    font = "TahomaB";
    sizeEx = 0.04;
    soundSelect[] = {"",0.1,1};
    soundExpand[] = {"",0.1,1};
    soundCollapse[] = {"",0.1,1};
    maxHistoryDelay = 1.0;
    shadow = 0;
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    class ComboScrollBar {
        color[] = {1,1,1,0.6};
        colorActive[] = {1,1,1,1};
        colorDisabled[] = {1,1,1,0.3};
        thumb = "#(argb,8,8,3)color(1,1,1,1)";
        arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
        arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
        border = "#(argb,8,8,3)color(1,1,1,1)";
        shadow = 0;
    };
};

class RSC(BaseTree) {
    idc = -1;
    type = 12;
    style = 0;
    default = 0;
    enable = 1;
    show = 1;
    fade = 0;
    blinkingPeriod = 0;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    rowHeight=0.043909099;
    sizeEx = (pixelH * pixelGrid * 3);
    font = FONT_DEFAULT;
    shadow = 0;

    colorDisabled[] = COLOR_DISABLED; // not used
    colorArrow[] = COLOR_DISABLED; // not used

    borderSize=0;
    colorBorder[] = COLOR_DISABLED;
    colorLines[]={0,0,0,0};

    colorBackground[] = {0.2,0.2,0.2,1};
    colorText[] = {1,1,1,1};

    colorSelectBackground[]={0,0,0,0.5};
    colorSelectText[] = {1,1,1,1};
    colorSelect[] = {1,0.5,0,1};

    colorMarked[] = {1,0.5,0,0.5};
    colorMarkedSelected[] = {1,0.5,0,1};
    colorMarkedText[] = {1,1,1,1};

    colorPicture[]={1,1,1,1};
    colorPictureSelected[]={0,0,0,1};
    colorPictureDisabled[]={1,1,1,0.25};
    colorPictureRight[]={1,1,1,1};
    colorPictureRightSelected[]={0,0,0,1};
    colorPictureRightDisabled[]={1,1,1,0.25};

    colorSearch[]={
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
    };

    tooltip = "";
    tooltipColorShade[] = {0,0,0,1};
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    multiselectEnabled = 1;
    expandOnDoubleclick = 1;
    hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
    expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
    maxHistoryDelay = 1;
    disableKeyboardSearch = 1;
    class ScrollBar {
        width = 0;
        height = 0;
        scrollSpeed = 0.0099999998;
        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
        color[] = {1,1,1,1};
    };
};
