
class APP(dialog) : RSC(guiMenu) {
    idd = IDD_GUI_CRATE;
    name = "Cratespawner";

    onLoad = QUOTE(uiNamespace setVariable [ARR_2('EGVAR(gui_main,dialog)',_this select 0)]; [ARR_2('GVAR(dialog)',true)] call EFUNC(gui,blur); _this call EFUNC(gui_main,OnLoad); _this call FUNC(OnLoad););
    onUnload = QUOTE([ARR_2('GVAR(dialog)',false)] call EFUNC(gui,blur);_this call EFUNC(gui_main,OnUnload););

    controlsBackground[] = {
        background_header,
        background_body,
        background_gradiend,
        background_itemlist,
        background_inventory
    };
    controls[] = {
        //background_logo,
        headertext,
        clock,
        player_button,
        menu_button,
        crate_button1,
        crate_button2,
        crate_button3,
        crate_button4,
        crate_button5,
        crate_button6,
        crate_button7,
        crate_button8,
        crate_button9,
        crate_button10,
        crate_button11,
        crate_button12,
        crate_button13,
        crate_button14,
        crate_button15,
        crate_button16,
        itemlist,
        itemlist_button_add,
        itemlist_button_reduce,
        itemfilter_watermark,
        itemfilter,

        boxtitle,
        boxweight,
        boxlist,
        inventorytitle,
        inventory,
        inventoryweight,
        inventory_button_add,
        inventory_button_reduce
    };

    class headertext : headertext {
        text = CSTRING(header);
    };

    class background_body : background_body {
        colorBackground[] = COLOR_CRATE_BACKGROUND;
    };

    class background_gradiend : background_gradiend {
        colorText[] = COLOR_CRATE_BACKGROUND_GRADIEND;
    };

    class background_itemlist: RSC(BaseText) {
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*23;
        w = GUI_DISP_W*72;
        h = GUI_DISP_H*65;
        style = "0x02";
        text = "";
        colorText[] = COLOR_DISABLED;
        colorBackground[] = COLOR_CRATE_BACKGROUND2;
    };

    class itemlist_button_add : RSC(BaseButton) {
        idc = IDC_GUI_CRATE_ITEMLIST_ADD;
        x = GUI_DISP_XAbs;
        y = GUI_DISP_YAbs;
        w = 0;
        h = 0;
        sizeEx = GUI_DISP_W*3.5;
        text = "+";
        borderSize = 0;
        colorShadow[] = {0,0,0,0};
        onButtonClick = QUOTE([ARR_2((ctrlParent (_this select 0)) displayCtrl IDC_GUI_CRATE_ITEMLIST,true)] call FUNC(add);false);
    };
    class inventory_button_add : itemlist_button_add {
        idc = IDC_GUI_CRATE_INVENTORY_ADD;
        onButtonClick = QUOTE([ARR_2((ctrlParent (_this select 0)) displayCtrl IDC_GUI_CRATE_INVENTORY,true)] call FUNC(add);false);
    };

    class itemlist_button_reduce : itemlist_button_add {
        idc = IDC_GUI_CRATE_ITEMLIST_REDUCE;
        text = "-";
        onButtonClick = QUOTE([ARR_2((ctrlParent (_this select 0)) displayCtrl IDC_GUI_CRATE_ITEMLIST,false)] call FUNC(add);false);
    };
    class inventory_button_reduce : itemlist_button_reduce {
        idc = IDC_GUI_CRATE_INVENTORY_REDUCE;
        onButtonClick = QUOTE([ARR_2((ctrlParent (_this select 0)) displayCtrl IDC_GUI_CRATE_INVENTORY,false)] call FUNC(add);false);
    };

    class itemlist : RSC(BaseListboxN) {
        idc = IDC_GUI_CRATE_ITEMLIST;
        access = 2;
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*23;
        w = GUI_DISP_W*72;
        h = GUI_DISP_H*65;
        rowHeight = GUI_DISP_H*3;
        sizeEx = GUI_DISP_H*2;
        //columns[] = {GUI_DISP_W*3.2,GUI_DISP_W*7,GUI_DISP_W*25,GUI_DISP_W*33,GUI_DISP_W*58};
        columns[] = {GUI_DISP_W*3.2,GUI_DISP_W*12,GUI_DISP_W*37,GUI_DISP_W*41,GUI_DISP_W*58};
        drawSideArrows = 1;
        idcLeft = IDC_GUI_CRATE_ITEMLIST_REDUCE;
        idcRight = IDC_GUI_CRATE_ITEMLIST_ADD;

        color[] = COLOR_CRATE_ITEMLIST_TEXT;
        colorScrollbar[] = COLOR_CRATE_BACKGROUND;
        colorSelect[] = COLOR_CRATE_ITEMLIST_TEXT;
        colorSelect2[] = COLOR_CRATE_ITEMLIST_TEXT;
        colorDisabled[] = COLOR_DISABLED;
        colorSelectBackground[] = COLOR_CRATE_ITEMLIST_SELECTBG;
        colorSelectBackground2[] = COLOR_CRATE_ITEMLIST_SELECTBG;
        colorText[] = COLOR_CRATE_ITEMLIST_TEXT;
        colorBackground[] = COLOR_CRATE_BACKGROUND;

        pictureColor[] = COLOR_BASE_WHITE;
        pictureColorSelect[] = COLOR_BASE_WHITE;
        pictureColorDisabled[] = COLOR_BASE_WHITE;
    };

    class itemfilter : RSC(BaseEditBox) {
        idc = IDC_GUI_CRATE_FILTER;
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*16;
        w = GUI_DISP_W*38;
        h = GUI_DISP_H*4;
        sizeEx = GUI_DISP_H*3;
        colorBackground[] = COLOR_DISABLED;
    };

    class itemfilter_watermark : RSC(BaseText) {
        idc = IDC_GUI_CRATE_FILTER_WATERMARK;
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*16;
        w = GUI_DISP_W*38;
        h = GUI_DISP_H*4;
        sizeEx = GUI_DISP_H*3;
        text = CSTRING(WATERMARK_FILTER);
        colorBackground[] = COLOR_CRATE_EDIT_BACKGROUND;
        //colorText[] = COLOR_CRATE_EDIT_TEXT_BACK;
        colorText[] = COLOR_BASE_WHITE;
    };

    class crate_button1 : RSC(BaseButton) {
        idc = IDC_GUI_CRATE_BTTN1;
        x = GUI_DISP_X+GUI_DISP_W*3;
        y = GUI_DISP_Y+GUI_DISP_H*10;
        w = GUI_DISP_W*4.5;
        h = GUI_DISP_H*4.5;
        shadow = 0;
        sizeEx = GUI_DISP_W*4.5;
        color[] = COLOR_DISABLED;

        colorBackground[] = COLOR_BASE_WHITE;
        colorBackgroundActive[] = COLOR_BASE_WHITE;
        colorFocused[] = COLOR_BASE_WHITE;

        colorText[] = COLOR_BASE_BLACK;
        colorTextSelect[] = COLOR_BASE_WHITE;

        colorShadow[] = COLOR_BASE_BLACK;
        colorBorder[] = COLOR_BASE_BLACK;

        colorDisabled[] = {0.1, 0.1, 0.1, 0.4};
        colorBackgroundDisabled[] = {0, 0, 0, 0.2};

        offsetX = 0;
        offsetY = 0;

        toolTip = CSTRING(BTTN_1);
        style = 48;
        text = "A3\ui_f\data\gui\cfg\Hints\rifle_ca.paa";
    };
    class crate_button2 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN2;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*1);
        toolTip = CSTRING(BTTN_2);
        text = "A3\ui_f\data\gui\cfg\Hints\automatic_ca.paa";
    };
    class crate_button3 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN3;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*2);
        toolTip = CSTRING(BTTN_3);
        text = "A3\ui_f\data\gui\cfg\Hints\Sniper_ca.paa";
    };
    class crate_button4 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN4;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*3);
        toolTip = CSTRING(BTTN_4);
        text = "A3\ui_f\data\gui\cfg\Hints\Launcher_ca.paa";
    };
    class crate_button5 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN5;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*4);
        toolTip = CSTRING(BTTN_5);
        text = "A3\ui_f\data\gui\cfg\Hints\Handgun_ca.paa";
    };
    class crate_button6 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN6;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*5);
        toolTip = CSTRING(BTTN_6);
        text = "A3\ui_f\data\gui\cfg\Hints\Optics_ca.paa";
    };
    class crate_button7 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN7;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*6);
        toolTip = CSTRING(BTTN_7);
        text = "A3\ui_f\data\gui\cfg\Hints\grenades_ca.paa";
    };
    class crate_button8 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN8;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*7);
        toolTip = CSTRING(BTTN_8);
        text = "A3\ui_f\data\gui\cfg\Hints\Mines_ca.paa";
    };
    class crate_button9 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN9;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*8);
        toolTip = CSTRING(BTTN_9);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\uniform_ca.paa";
        colorBackground[] = COLOR_BASE_BLACK;
        colorBackgroundActive[] = COLOR_BASE_BLACK;

        colorFocused[] = COLOR_BASE_BLACK;
        colorText[] = COLOR_BASE_WHITE;
        colorTextSelect[] = COLOR_BASE_WHITE;
    };
    class crate_button10 : crate_button9 {
        idc = IDC_GUI_CRATE_BTTN10;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*9);
        toolTip = CSTRING(BTTN_10);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\vest_ca.paa";
    };
    class crate_button11 : crate_button9 {
        idc = IDC_GUI_CRATE_BTTN11;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*10);
        toolTip = CSTRING(BTTN_11);
        text = "A3\ui_f\data\gui\Rsc\RscDisplayArsenal\headgear_ca.paa";
    };
    class crate_button12 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN12;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*11);
        toolTip = CSTRING(BTTN_12);
        text = "A3\ui_f\data\gui\cfg\Hints\Gear_CA.paa";
    };
    class crate_button13 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN13;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*12);
        toolTip = CSTRING(BTTN_13);
        text = "A3\ui_f\data\gui\cfg\Hints\CallSupport_CA.paa";
    };
    class crate_button14 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN14;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*13);
        toolTip = CSTRING(BTTN_14);
        text = "A3\ui_f\data\gui\cfg\Hints\Direction_ca.paa";
    };
    class crate_button15 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN15;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*14);
        toolTip = CSTRING(BTTN_15);
        text = "A3\ui_f\data\gui\cfg\Hints\Injury_ca.paa";
    };
    class crate_button16 : crate_button1 {
        idc = IDC_GUI_CRATE_BTTN16;
        x = GUI_DISP_X+GUI_DISP_W*(3+4.5*15);
        toolTip = CSTRING(BTTN_16);
        text = "A3\ui_f\data\gui\cfg\Hints\Take_ca.paa";
    };

    class boxtitle : RSC(BaseText) {
        idc = IDC_GUI_CRATE_BOXLIST_HEADER;
        x = GUI_DISP_X + GUI_DISP_W*82;
        y = GUI_DISP_Y + GUI_DISP_H*10;
        w = GUI_DISP_W*30;
        h = GUI_DISP_H*4;
        sizeEx = GUI_DISP_H*4;
        text = CSTRING(header_box);
        colorBackground[] = COLOR_DISABLED;
        colorText[] = COLOR_BASE_BLACK;
    };

    class boxweight : boxtitle {
        idc = IDC_GUI_CRATE_BOXLIST_WEIGHT;
        style = 0x01;
        x = GUI_DISP_X + GUI_DISP_W*134;
        w = GUI_DISP_W*20;
        text = "0 kg";
    };

    class boxlist : RSC(BaseCombobox) {
        idc = IDC_GUI_CRATE_BOXLIST;
        x = GUI_DISP_X + GUI_DISP_W*82;
        y = GUI_DISP_Y + GUI_DISP_H*16;
        w = GUI_DISP_W*72;
        h = GUI_DISP_H*4;
        sizeEx = GUI_DISP_H*3;
        rowHeight = GUI_DISP_H*3;
        wholeHeight = GUI_DISP_H*40;
        onLBSelChanged = QFUNC(onBoxChanged);
    };

    class inventorytitle : boxtitle {
        idc = IDC_GUI_CRATE_INVENTORY_HEADER;
        y = GUI_DISP_Y + GUI_DISP_H*24;
        text = CSTRING(header_inventory);
    };

    class inventoryweight : inventorytitle {
        idc = IDC_GUI_CRATE_INVENTORY_WEIGHT;
        style = 0x01;
        x = GUI_DISP_X + GUI_DISP_W*134;
        w = GUI_DISP_W*20;
        text = "0 kg";
    };

    class inventory : itemlist {
        idc = IDC_GUI_CRATE_INVENTORY;
        x = GUI_DISP_X + GUI_DISP_W*82;
        y = GUI_DISP_Y + GUI_DISP_H*30;
        h = GUI_DISP_H*46;
        idcLeft = IDC_GUI_CRATE_INVENTORY_REDUCE;
        idcRight = IDC_GUI_CRATE_INVENTORY_ADD;
    };

    class background_inventory: background_itemlist {
        x = GUI_DISP_X+GUI_DISP_W*82;
        y = GUI_DISP_Y+GUI_DISP_H*30;
        h = GUI_DISP_H*46;
    };
};
