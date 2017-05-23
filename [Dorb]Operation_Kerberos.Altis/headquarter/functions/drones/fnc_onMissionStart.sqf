/*
 *  Author: iJesuz,Dorbedo
 *
 *  Description:
 *      initializes the drones
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


private _playerAmount = {((isPlayer _x)&&{side _x == GVARMAIN(playerside)})} count allUnits;
private _adrones = ["adrones"] call EFUNC(spawn,getUnit);
private _rdrones = ["rdrones"] call EFUNC(spawn,getUnit);
private _avail_adrones = [];
private _avail_rdrones = [];


_avail_rdrones pushBack (selectRandom _rdrones);
if (_playerAmount  >=  5) then { _avail_rdrones pushBack (selectRandom _rdrones); };
if (_playerAmount  >= 15) then { _avail_rdrones pushBack (selectRandom _rdrones); };
if (_playerAmount  >= 25) then { _avail_rdrones pushBack (selectRandom _rdrones); };
if (_playerAmount  >= 35) then { _avail_rdrones pushBack (selectRandom _rdrones); };

_avail_adrones pushBack (selectRandom _adrones); 
if (_playerAmount  >= 10) then { _avail_adrones pushBack (selectRandom _adrones); };
if (_playerAmount  >= 20) then { _avail_adrones pushBack (selectRandom _adrones); };
if (_playerAmount  >= 30) then { _avail_adrones pushBack (selectRandom _adrones); };
if (_playerAmount  >= 40) then { _avail_adrones pushBack (selectRandom _adrones); };

GVAR(drones_attackIntervall) = 600;
GVAR(drones_reconIntervall) = 600;
GVAR(drones_requestedAirstrikes) = [];
GVAR(drones_requestedReconnaissances) = [];
GVAR(drones_availableAttackDrones) = _avail_adrones;
GVAR(drones_availableReconDrones) = _avail_rdrones;
GVAR(drones_isActive) = true;
