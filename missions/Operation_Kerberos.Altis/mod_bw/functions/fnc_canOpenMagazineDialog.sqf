params ["_target"];

private _vehicles = nearestObjects [_target, ["Air", "LandVehicle", "Slingload_base_F", "ReammoBox_F"], BWA3_MagazineDialogDistance];
private _filter = ["transportAmmo", "ace_rearm_defaultSupply"] select (["ace_rearm"] call ace_common_fnc_isModLoaded);
private _rearmVehicles = {(getNumber (configFile >> "CfgVehicles" >> typeOf _x >> _filter)) > 0} count _vehicles;

(_rearmVehicles > 0 && {[ace_player, _target] call ace_common_fnc_canInteractWith} && {missionNamespace getVariable ["BWA3_MagazineDialogAllowed", true]})
