/*
	Author: Dorbedo
	
	Description:
		
		spawn road - defence positions
		
	
	Parameter(s):
		_this : ARRAY		- roadpositions
		
	Returns:
		BOOL
	
*/
#include "script_component.hpp"

params["_weight","_pos_x","_pos_y","_pos_z","_dir","_size"];
private "_position";
_position = [_pos_x,_pos_y,_pos_z];


If (dorb_debug) then {
	_mrkr = createMarker [format["Fortification-%1",_position],_position];
	_mrkr setMarkerShape "ICON";
	_mrkr setMarkerColor "ColorOPFOR";
	_mrkr setMarkerType "mil_arrow";
	_mrkr setMarkerDir _dir;
};
private "_rand";
/// Direction
_rand = floor(random 2);
_dir = _dir - 90;
if (_rand>0) then {
	_dir = _dir + 180;
};

_type = 0;

if (_size>1) then {
	_rand = floor(random 2);
	if (_rand>0) then {
		_type = 10;
	}else{
		_type = 11;
	};
};
if (_size<2) then {
	_rand = floor(random 2);
	if (_rand>0) then {
		_type = 20;
	}else{
		_type = 21;
	};
};


switch (_type) do {
	// Roadblock Mainroad - MG
	case 10 : {
		_makro = [
					["Land_BagFence_Round_F",[2.54614,-4.18262,0.00459957],346.17],
					["Land_BagFence_Short_F",[4.19653,-3.00781,0.00416279],125.918],
					["Land_LampStreet_F",[-2.75781,9.54688,-0.00611782],126.074],
					["Land_BagBunker_Small_F",[-1.29053,5.64648,-0.00433445],215.057],
					["Land_BagBunker_Small_F",[-5.63599,-0.446289,0.00659275],35.7045],
					["Land_BagFence_Round_F",[4.50537,-1.09473,-0.00357914],247.506],
					["Land_BagFence_Long_F",[-5.62866,2.50586,0.0102396],127.109],
					["Land_BagFence_Long_F",[-3.80908,4.90625,0.00811291],127.109],
					["Land_BagFence_Short_F",[-0.912109,3.19141,0.00444794],126.969],
					["Land_BagFence_Short_F",[-3.18677,0.0078125,-0.00684834],304.699],
					["RHS_M2StaticMG_D",[-6.06201,0.150391,0.00819683],206.005],
					["RHS_M2StaticMG_D",[-0.430176,5.34668,0.00811195],34.806]
				];
		_dir = _dir + 35;
		[_position,_makro,_dir] call FM(spawn_macro_exec);
	};
	
	// Roadblock Mainroad - AT
	case 11 : {
		_makro = [
					["Land_BagBunker_Tower_F",[-1.91113,1.24805,0.00307083],56.452],
					["Land_HBarrierBig_F",[1.58545,-4.51074,0.00187302],145.945],
					["Land_HBarrier_3_F",[-6.12524,-8.50293,0.0548925],236.606],
					["Land_HBarrier_3_F",[6.40332,-0.924805,0.0734386],148.42],
					["Land_HBarrier_3_F",[7.82446,1.29297,0.0481453],236.603],
					["Land_HBarrier_3_F",[-3.37988,-7.92578,0.0830603],148.425],
					["Land_BagFence_Round_F",[6.34546,3.78711,-0.0343771],199.455],
					["Land_BagFence_Round_F",[-7.698,-5.95313,-0.0323534],90.0539],
					["Land_BagFence_Long_F",[0.691895,2.7666,2.70542],58.654],
					["Land_BagFence_Long_F",[-2.34863,3.18945,2.74314],146.758],
					["Land_BagFence_Long_F",[-0.699707,0.188477,2.67326],146.754],
					["Land_CncBarrier_F",[-7.87964,-11.4199,-0.000910759],47.8324],
					["Land_CncBarrier_F",[8.19434,10.5742,-6.00815e-005],231.528],
					["Land_CncBarrier_F",[-10.259,-8.11816,-0.000925064],53.6864],
					["Land_CncBarrier_F",[10.5039,7.07422,-3.91006e-005],237.377],
					["Land_CncBarrier_F",[-12.9507,-4.32031,-0.000801086],65.6875],
					["Land_BagFence_Corner_F",[-0.475342,4.19629,2.76088],333.374],
					["Land_BagFence_End_F",[0.855713,1.19141,2.61055],155.452],
					["Land_CncBarrier_F",[12.5752,3.27246,-0.000136375],249.391],
					["RHS_M2StaticMG_D",[-7.08447,-5.46875,0.0114393],243.099],
					["RHS_M2StaticMG_D",[5.73267,2.19629,0.011199],55.9528]
				];
		_dir = _dir + 41;
		[_position,_makro,_dir] call FM(spawn_macro_exec);
	};
	
	// Roadblock Middelroad - MG
	case 20 : {
		_makro = [
					["Land_BagBunker_Small_F",[5.13281,2.10059,0.018455],222.25],
					["Land_BagFence_Long_F",[2.87109,-3.08594,0.0405693],311.938],
					["Land_BagFence_Long_F",[0.893311,-5.38379,0.0211296],311.942],
					["Land_BagFence_Long_F",[4.77222,-0.874023,-0.0408034],128.765],
					["Land_CncBarrier_stripes_F",[-0.25415,6.31445,-0.00114822],131.196],
					["Land_CncBarrier_stripes_F",[-4.66479,1.01367,-0.0010705],131.192],
					["Land_CncBarrier_stripes_F",[-6.85571,-1.68652,-0.00108814],131.192],
					["Land_CncBarrier_stripes_F",[-2.1731,-4.17871,-0.00138044],103.638],
					["Land_CncBarrier_stripes_F",[-1.52539,-6.1709,-0.00144625],40.495],
					["Land_CncBarrier_stripes_F",[-1.10498,-1.88574,-0.00106716],133.17],
					["Land_CncBarrier_stripes_F",[-2.45435,3.61426,-0.00108957],131.193],
					["Land_CncBarrier_stripes_F",[2.16577,1.61426,-0.00108814],133.172],
					["RoadCone_F",[9.35962,7.4209,-0.00119209],359.993],
					["RoadCone_F",[7.82959,7.4209,-0.0011878],359.993],
					["RoadCone_F",[5.88086,6.12207,-0.00124264],359.998],
					["RoadCone_F",[10.4502,6.32031,-0.00115013],359.985]
				];
		_dir = _dir + 51;
		[_position,_makro,_dir] call FM(spawn_macro_exec);
	};
	
	// Roadblock Middelroad - AT
	case 21 : {
		_makro = [
					["CamoNet_BLUFOR_open_Curator_F",[0.236572,-0.773438,-0.500586],134.595],
					["Land_HBarrierWall_corridor_F",[1.36987,-2.39648,-0.490756],318.978],
					["Land_BagBunker_Small_F",[-5.47119,-2.73145,-0.52377],48.93],
					["Land_Pallet_MilBoxes_F",[0.0449219,0.9375,-0.476232],316.428],
					["Land_BagFence_Long_F",[-4.59326,0.231445,-0.570191],135.463],
					["Land_PaperBox_open_full_F",[-1.40039,-0.68457,-0.491858],311.145],
					["Land_BagFence_Short_F",[-3.32446,-4.26758,-0.488204],234.623],
					["Land_BagFence_Short_F",[0.468994,-6.26855,-0.449812],315.632],
					["Land_BagFence_Corner_F",[-0.598633,-6.84668,-0.538227],139.712],
					["Land_BagFence_End_F",[-1.32397,-6.50488,-0.49685],227.27],
					["Land_BagBunker_Small_F",[2.45117,4.62109,-0.385187],228.815],
					["Land_BagFence_Long_F",[-2.41797,2.3291,-0.590883],135.473],
					["Land_BagFence_Long_F",[-0.297852,4.42969,-0.576032],135.473],
					["Land_BagFence_Short_F",[5.40698,-1.37402,-0.410065],315.649],
					["Land_BagFence_Corner_F",[6.14697,-0.0585938,-0.462224],48.4176],
					["Land_BagFence_End_F",[5.87524,0.680664,-0.495937],227.042],
					["Land_BagFence_Short_F",[4.18311,2.72461,-0.495001],234.45],
					["RHS_M2StaticMG_D",[2.56494,4.27637,-0.474106],52.6263],
					["RHS_M2StaticMG_D",[-5.72168,-2.10938,-0.48362],227.691]
				];
		_dir = _dir + 51;
		[_position,_makro,_dir] call FM(spawn_macro_exec);
	};
	
	// Roadblock Crossing (4 roads)
	case 30 : {
		_makro = [
					["Land_BagFence_Long_F",[-6.43848,-4.68555,0.0262041],301.122],
					["Land_BagBunker_Small_F",[-8.8689,8.44336,-0.0400782],124.294],
					["Land_BagFence_Round_F",[-5.42554,-2.14551,-0.0238304],266.323],
					["Land_BagFence_Long_F",[-5.74805,4.42285,0.127399],31.1799],
					["Land_BagFence_Long_F",[-5.70605,8.3457,-0.130773],210.222],
					["Land_BagFence_Long_F",[-7.64868,0.258789,-0.0747566],212.435],
					["Land_BagFence_Long_F",[-3.09619,6.8457,-0.140567],210.222],
					["Land_BagFence_Long_F",[-7.48804,5.52246,0.127431],31.1799],
					["Land_BagFence_Long_F",[-12.6453,3.3584,-0.175528],212.281],
					["Land_BagFence_Long_F",[-10.1255,1.75879,-0.207961],212.281],
					["Land_BagFence_End_F",[-6.08105,-0.790039,0.0783186],38.326],
					["Land_BagBunker_Small_F",[-0.519531,-8.20703,-0.0149374],29.8793],
					["Land_HBarrier_5_F",[4.34888,-6.9541,0.0622778],213.031],
					["Land_HBarrier_5_F",[8.32788,-9.53516,-0.0576239],34.0958],
					["Land_HBarrier_3_F",[11.0076,-9.01172,0.00466442],301.074],
					["Land_BagFence_Long_F",[7.29077,-5.35059,-0.028821],211.063],
					["Land_BagFence_Long_F",[10.0107,-7.0498,-0.0264254],211.066],
					["Land_HBarrier_1_F",[1.73218,-7.07031,-0.00118256],30.8589],
					["Land_PaperBox_open_empty_F",[8.00977,-7.07715,-3.62396e-005],306.11],
					["Land_PaperBox_closed_F",[9.45972,-7.98242,-0.000664711],305.497],
					["Land_BagFence_Corner_F",[5.40234,-4.72754,0.013092],300.253],
					["Land_BagBunker_Small_F",[5.35645,14.0566,0.0178652],211.965],
					["Land_HBarrier_5_F",[8.61279,0.757813,0.0281916],213.067],
					["Land_HBarrier_5_F",[8.70508,4.96289,0.0450478],301.017],
					["Land_HBarrier_5_F",[13.3533,-2.32324,-0.0314465],34.1248],
					["Land_HBarrier_5_F",[11.6326,9.72266,-0.00755692],302.65],
					["Land_BagFence_Round_F",[3.67798,9.14063,0.019042],338.606],
					["Land_BagFence_Long_F",[1.15112,10.3262,-0.0157089],299.735],
					["Land_BagFence_Long_F",[5.55103,11.0225,0.00915623],299.725],
					["Land_BagFence_Long_F",[-0.27832,7.82617,-0.0116243],299.735],
					["Land_BagFence_Long_F",[2.68091,13.0352,-0.0188799],299.718],
					["Land_BagFence_Corner_F",[-1.48486,6.38281,0.00581169],121.302]
				];
		_dir = _dir + 32.5;
		[_position,_makro,_dir] call FM(spawn_macro_exec);
	};

};

true