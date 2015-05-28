/*
	Author: Dorbedo
	
	Description:
		Do not call, never ever directly
*/
#include "makros.hpp"

CHECK(!(local (_this select 0)))

[-2,{_this FCALL(_this select 1)},(_this select 2)] FMP;