
class BWA3_MagazineDialog {
    idd = IDD_BWA3_MAGAZINEDIALOG;
    name = "$STR_BWA3_Comp_Ace_MagazineDialog";
    enableSimulation = 1;

    class Controls {
        class TextTitlebar: RSC(baseText) {
            idc = IDC_BWA3_MAGAZINEDIALOG_TITLE;
            text = "$STR_BWA3_Comp_Ace_MagazineDialog";
            x = GUI_GRID_CENTER_X + GUI_GRID_W * 8;
            y = GUI_GRID_CENTER_Y;
            w = GUI_GRID_W * 24;
            h = GUI_GRID_H;
            sizeEx = GUI_GRID_H;
            colorBackground[] = {
                "(profileNamespace getVariable ['GUI_BCG_RGB_R', 0.13])",
                "(profileNamespace getVariable ['GUI_BCG_RGB_G', 0.54])",
                "(profileNamespace getVariable ['GUI_BCG_RGB_B', 0.21])",
                1
            };
        };
        class BackgroundDialog: RSC(baseText) {
            idc = IDC_BWA3_MAGAZINEDIALOG_BACK;
            x = GUI_GRID_CENTER_X + GUI_GRID_W * 8;
            y = GUI_GRID_CENTER_Y + GUI_GRID_H;
            w = GUI_GRID_W * 24;
            h = GUI_GRID_H * 15;
            colorBackground[] = {0,0,0,0.5};
            text = "";
        };
        class ButtonApply: RSC(baseButton) {
            idc = 1;
            text = "$STR_ui_debug_but_apply";
            x = GUI_GRID_CENTER_X + GUI_GRID_W * 24;
            y = GUI_GRID_CENTER_Y + GUI_GRID_H * 16;
            w = GUI_GRID_W * 8;
            h = GUI_GRID_H;
        };
        class ButtonClose: ButtonApply {
            idc = 2;
            text = "$STR_disp_cancel";
            x = GUI_GRID_CENTER_X + GUI_GRID_W * 16;
        };
        class ControlsTable {
            idc = IDC_BWA3_MAGAZINEDIALOG_CONTROLSTABLE;
            x = GUI_GRID_CENTER_X + GUI_GRID_W * 9;
            y = GUI_GRID_CENTER_Y + GUI_GRID_H * 2;
            w = GUI_GRID_W * 22;
            h = GUI_GRID_H * 13;

            type = 19;
            style = 0x10;

            lineSpacing = 0.1 * GUI_GRID_H;
            rowHeight = 1.1 * GUI_GRID_H;
            headerHeight = 1.2 * GUI_GRID_H;

            firstIDC = IDC_BWA3_MAGAZINEDIALOG_CONTROLSTABLE_START;
            lastIDC = IDC_BWA3_MAGAZINEDIALOG_CONTROLSTABLE_END;

            selectedRowColorFrom[]  = {0.7, 0.85, 1, 0.25};
            selectedRowColorTo[]    = {0.7, 0.85, 1, 0.5};
            selectedRowAnimLength = 1.2;

            class VScrollBar {
                color[] = {1,1,1,0.6};
                colorActive[] = {1,1,1,1};
                colorDisabled[] = {1,1,1,0.3};
                thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
                arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
                arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
                border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
                shadow = 0;
                scrollSpeed = 0.06;
                width = GUI_GRID_W * 0.8;
                autoScrollEnabled = 0;
                autoScrollDelay = 1;
                autoScrollRewind = 1;
                autoScrollSpeed = 1;
            };
            class HScrollBar: VScrollBar {
                height = 0;
                width = 0;
            };
            class HeaderTemplate {
                class HeaderBackground {
                    controlBaseClassPath[] = {"RscText"};
                    columnX = 0;
                    columnW = GUI_GRID_W * 22;
                    controlOffsetY = 0;
                };
                class Column1 {
                    controlBaseClassPath[] = {"RscText"};
                    columnX = GUI_GRID_W * 3;
                    columnW = GUI_GRID_W * 16;
                    controlOffsetY = 0;
                };
            };
            class RowTemplate {
                class RowBackground {
                    controlBaseClassPath[] = {"RscText"};
                    columnX = 0;
                    columnW = GUI_GRID_W * 22;
                    controlOffsetY = 0;
                };
                class Column1 {
                    controlBaseClassPath[] = {"RscText"};
                    columnX = 0;
                    columnW = 7 * GUI_GRID_W;
                    controlOffsetY = 0;
                };
                class Column2 {
                    controlBaseClassPath[] = {"RscXSliderH"};
                    columnX = 8 * GUI_GRID_W;
                    columnW = 11 * GUI_GRID_W;
                    controlOffsetY = 0.3 * GUI_GRID_H;
                    controlH = 0.8 * GUI_GRID_H;
                };
                class Column3 {
                    controlBaseClassPath[] = {"RscEdit"};
                    columnX = 20 * GUI_GRID_W;
                    columnW = 2 * GUI_GRID_W;
                    controlOffsetY = 0.3 * GUI_GRID_H;
                    controlH = 1 * GUI_GRID_H;
                };
            };
        };
    };
};
