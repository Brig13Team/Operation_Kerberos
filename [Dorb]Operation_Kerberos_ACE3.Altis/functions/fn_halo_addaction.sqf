/*
	Author: Dorbedo
	
	Description:
	Adds Halo action
*/
#include "makros.hpp"

CHECK(!hasInterface)
halo addAction ["<t size='1.5' shadow='2' color='#ff0000'>"+localize "STR_DORB_HALO"+"</t> <img size='3' color='#ff0000' shadow='2' image='\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa'/>",{_this call dorb_fnc_halo;},[750,75], 4, false,true, "","alive _target and (getposatl player distance getposatl halo) < 4"];