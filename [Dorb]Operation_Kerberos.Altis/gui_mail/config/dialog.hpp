/*
    Author: Dorbedo
*/
#define INCLUDE_GUI
#define CBA_OFF
#include "script_component.hpp"

class APP(dialog) : RSC(Echidna) {
    idd = IDD_ECHIDNA_MAIN;
    controlsBackground[] = {
        background_taskbar,
        background_display,
        mail_Logo
    };
    controls[] = {
        clock,
        menu_button,
        folder_list,
        mail_list,
        header_mail_list,
        header_sender,
        header_date,
        header_subject,
        content,
        metro_back,
        metro,
        metro_side,
        background_device
    };
    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_Echidna,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this spawn EFUNC(gui_echidna,OnLoad);_this spawn FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_Echidna,OnUnLoad););
    class background_display: background_display {
        idc = -1;
        x = GUI_ECHIDNA_X;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 40;
        h = GUI_ECHIDNA_H * 27.5;
        text = "";
        colorBackground[] = COLOR_ECHIDNA_MAIL_DISPLAY_BACKGROUND;
        colorText[] = COLOR_DISABLED;
    };
    class mail_Logo : RSC(BasePicture) {
        idc = -1;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H;
        w = GUI_ECHIDNA_W * 3;
        h = GUI_ECHIDNA_H * 3;
        text = QEPAAPATH(echidna,mail);
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_ECHIDNA_MAIL_HEADER_TEXT;
    };
    class folder_list : RSC(BaseListbox) {
        idc = IDC_ECHIDNA_MAIL_FOLDER;
        style="0x00 + 0x10";
        default = 1;
        enable = 1;
        blinkingPeriod = 0;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 4.5;
        w = GUI_ECHIDNA_W * 6;
        h = GUI_ECHIDNA_H * 23;

        colorBackground[] = COLOR_ECHIDNA_MAIL_FOLDER_BACKGROUND;
        colorSelectBackground[] = COLOR_ECHIDNA_MAIL_FOLDER_BACKGROUND_SELECTED;
        colorSelectBackground2[] = COLOR_ECHIDNA_MAIL_FOLDER_BACKGROUND_SELECTED;

        sizeEx = (pixelH * pixelGrid * 3);
        font = FONT_DEFAULT;
        shadow = 0;

        colorText[] = COLOR_ECHIDNA_MAIL_FOLDER_TEXT;
        colorDisabled[] = COLOR_ECHIDNA_MAIL_FOLDER_TEXT_DISABLED;
        colorSelect[] = COLOR_ECHIDNA_MAIL_FOLDER_TEXT_SELECTED;
        colorSelect2[] = COLOR_ECHIDNA_MAIL_FOLDER_TEXT_SELECTED;
        colorShadow[] = COLOR_DISABLED;

        colorPicture[] = COLOR_ECHIDNA_MAIL_FOLDER_PICTURE;
        colorPictureSelected[] = COLOR_ECHIDNA_MAIL_FOLDER_PICTURE_SELECTED;
        colorPictureDisabled[] = COLOR_ECHIDNA_MAIL_FOLDER_PICTURE_DISABLED;

        tooltip = "";
        tooltipColorShade[] = COLOR_ECHIDNA_MAIL_FOLDER_TOOLTIP_BACKGROUND;
        tooltipColorText[] = COLOR_ECHIDNA_MAIL_FOLDER_TOOLTIP_TEXT;
        tooltipColorBox[] = COLOR_ECHIDNA_MAIL_FOLDER_TOOLTIP_BOX;

        period = 1;
        rowHeight  =  (pixelH * pixelGrid * 4);
        itemSpacing = 0;
        maxHistoryDelay = 1;
        canDrag = 0;

        soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.090000004,1};
        class ListScrollBar : ListScrollBar {
            width = "pixelH * pixelGrid";
            height = 0;
            scrollSpeed = 0.0099999998;
            arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
            arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
            border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
            thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
            color[] = COLOR_ECHIDNA_MAIL_FOLDER_SCROLLBAR;
        };
    };

    class header_mail_list : RSC(BaseText) {
        idc = IDC_ECHIDNA_MAIL_LIST_HEADER;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 7;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 11;
        h = GUI_ECHIDNA_H * 3;
        colorBackground[] = COLOR_ECHIDNA_MAIL_MAIL_BACKGROUND;
        colorText[] = COLOR_ECHIDNA_MAIL_MAIL_TEXT;
        text = "Posteingang";
    };

    class mail_list : folder_list {
        idc = IDC_ECHIDNA_MAIL_LIST;

        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 7;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 3;
        w = GUI_ECHIDNA_W * 11;
        h = GUI_ECHIDNA_H * 24.5;

        colorBackground[] = COLOR_ECHIDNA_MAIL_MAIL_BACKGROUND;
        colorSelectBackground[] = COLOR_ECHIDNA_MAIL_MAIL_BACKGROUND_SELECTED;
        colorSelectBackground2[] = COLOR_ECHIDNA_MAIL_MAIL_BACKGROUND_SELECTED;

        colorText[] = COLOR_ECHIDNA_MAIL_MAIL_TEXT;
        colorDisabled[] = COLOR_ECHIDNA_MAIL_MAIL_TEXT_DISABLED;
        colorSelect[] = COLOR_ECHIDNA_MAIL_MAIL_TEXT_SELECTED;
        colorSelect2[] = COLOR_ECHIDNA_MAIL_MAIL_TEXT_SELECTED;

        colorPicture[] = COLOR_ECHIDNA_MAIL_MAIL_PICTURE;
        colorPictureSelected[] = COLOR_ECHIDNA_MAIL_MAIL_PICTURE_DISABLED;
        colorPictureDisabled[] = COLOR_ECHIDNA_MAIL_MAIL_PICTURE_DISABLED;
    };
    class header_sender : RSC(BaseText) {
        idc = IDC_ECHIDNA_MAIL_HEADER_SENDER;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 18;
        y = GUI_ECHIDNA_Y;
        w = GUI_ECHIDNA_W * 22;
        h = GUI_ECHIDNA_H * 2;
        colorBackground[] = COLOR_ECHIDNA_MAIL_CONTENT_BACKGROUND_SENDER;
        text = "sender";
    };
    class header_date : header_sender {
        idc = IDC_ECHIDNA_MAIL_HEADER_DATE;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 2;
        h = GUI_ECHIDNA_H * 1;
        colorBackground[] = COLOR_ECHIDNA_MAIL_CONTENT_BACKGROUND_DATE;
        text = "date";
    };
    class header_subject : header_sender {
        idc = IDC_ECHIDNA_MAIL_HEADER;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 3;
        h = GUI_ECHIDNA_H * 1;
        colorBackground[] = COLOR_ECHIDNA_MAIL_CONTENT_BACKGROUND_SUBJECT;
        text = "header";
    };
    class content : RSC(BaseStructuredText) {
        idc = IDC_ECHIDNA_MAIL_CONTENT;
        x = GUI_ECHIDNA_X + GUI_ECHIDNA_W * 18;
        y = GUI_ECHIDNA_Y + GUI_ECHIDNA_H * 4;
        w = GUI_ECHIDNA_W * 22;
        h = GUI_ECHIDNA_H * 23.5;
        colorBackground[] = COLOR_ECHIDNA_MAIL_CONTENT_BACKGROUND_CONTENT;
        text = "content";
    };
};
