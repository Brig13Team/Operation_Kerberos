class RscTitles {
  class DORB_DISP_MSG {
    duration = 20;
    idd = 700100;
    movingenable = 0;
    onLoad = "uiNamespace setVariable ['DORB_DISP_MSG', _this select 0];";
    class controlsBackground {
      class dorb_disp_header : dorb_gui_backgroundBase {
        text = "";
        idc = 700101;
		sizeEx = _get_screen_h(0.03);
		style = ST_LEFT;
        x = safezoneX + safezoneW * 0.05;
        y = safeZoneY + safezoneH * 0.2;
        w = _get_screen_w(0.13);
        h = _get_screen_h(0.035);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
      };
      class content: dorb_disp_header {
        idc = 700102;
        y = safeZoneY + safezoneH * 0.2 + _get_screen_h(0.040);
		sizeEx = _get_screen_h(0.025);
		colorText[] = UI_CL_BODY_TEXT;
		colorBackground[] = UI_CL_BODY;
      };
    };
  };
  class DORB_DISP_INFO {
	duration = 20;
	idd = 700106;
	movingenable = 0;
	onLoad = "uiNamespace setVariable ['DORB_DISP_INFO', _this select 0];";
    class controlsBackground {
      class dorb_disp_header : dorb_gui_backgroundBase {
        text = "";
        idc = 700107;
		sizeEx = _get_screen_h(0.03);
		style = ST_LEFT;
        x = safezoneX + safezoneW * 0.05;
        y = safeZoneY + safezoneH * 0.41;
        w = _get_screen_w(0.13);
        h = _get_screen_h(0.035);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_HEADER;
      }; 
	  class icon_body: dorb_disp_header {
        idc = 700109;
        x = safezoneX + safezoneW * 0.05;
        y = safeZoneY + safezoneH * 0.26;
        w = _get_screen_w(0.13);
        h = _get_screen_h(0.15);
		colorText[] = UI_CL_BODY_TEXT;
		colorBackground[] = UI_CL_BODY;
      };
	  class icon : dorb_gui_pictureBase{
		idc = 700108;
		text = "";
		style = 48;
		x = safezoneX + safezoneW * 0.06;
        y = safeZoneY + safezoneH * 0.27;
        w = _get_screen_w(0.10);
        h = _get_screen_h(0.13);
		colorText[] = UI_CL_HEADER_TEXT;
		colorBackground[] = UI_CL_BODY;
	  }; 
      class content: dorb_disp_header {
        idc = 700110;
		sizeEx = _get_screen_h(0.025);
		colorText[] = UI_CL_BODY_TEXT;
		colorBackground[] = UI_CL_BODY;
		y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.040);
		style = ST_LEFT;
      };
	  class content2: content {
        idc = 700111;
        y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.077);
      };
	  class content3: content {
        idc = 700112;
        y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.114);
      };
	  class content4: content {
        idc = 700113;
        y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.151);
      };
	  class content5: content {
        idc = 700114;
        y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.188);
      };
	  class content6: content {
        idc = 700115;
        y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.225);
      };
	  class content7: content {
        idc = 700116;
        y = safeZoneY + safezoneH * 0.41 + _get_screen_h(0.262);
      };
	  
    };
  };
  
  class DORB_DISP_MISSIONTIMER {
	duration = 61;
	idd = 700103;
	movingenable = 0;
	onLoad = "uiNamespace setVariable ['DORB_DISP_MISSIONTIMER', _this select 0];";
	class controlsBackground {
      class dorb_disp_header : dorb_gui_backgroundBase {
        text = "";
        idc = 700104;
		sizeEx = _get_screen_h(0.03);
		style = ST_CENTER;
        x = safeZoneX + safeZoneW - (safeZoneW * 0.032);
        y = safeZoneY + safezoneH * 0.19;
        w = _get_screen_w(0.03);
        h = _get_screen_h(0.035);
		colorText[] = UI_CL_BODY_TEXT;
		colorBackground[] = UI_CL_BODY;
      };
    };
  };
  
  class DORB_DISP_PROGRESSBAR {
    duration = 1e+011;
    idd = 700105;
    movingenable = 0;
    onLoad = "uiNamespace setVariable ['DORB_DISP_PROGRESSBAR', _this select 0];";
	class controls {
		class Progress {
			idc=6;
			type = 8;
			style = 0;
			colorFrame[] = UI_CL_CTRL_GRUEN1;
			colorBar[] = UI_CL_CTRL_GRUEN2;
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			x = safezoneX + safezoneW * 0.3;
			y = safeZoneY + _get_screen_h(0.1);
			w = safezoneW * 0.4;
			h = _get_screen_h(0.02);
		};
	};
  };
};