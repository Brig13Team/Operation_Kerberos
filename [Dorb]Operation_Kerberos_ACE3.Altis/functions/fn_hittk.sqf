/*
	Author: Dorbedo
	
	Description:
		Logs Shooting on Teammates
	
*/
_this spawn {
	#include "makros.hpp"
	CHECK(!(isPlayer (_this select 1)))
	CHECK((_this select 0)==(_this select 1))
	[0,{d_log_o(FORMAT_4("Teambeschuss: %1 / %2 beschossen von %3 / %4   Damage=%5",(_this select 0),name(_this select 0),(_this select 1),name(_this select 1),(_this select 2)))},_this] FMP;
};