


hint "Export started";
private _br = toString [0x0D, 0x0A];

private _afrf_soldiers = [];
private _afrf_vehicles = [];

private _usf_soldiers = [];
private _usf_vehicles = [];

private _cfgvehicles = configFile >> "cfgvehicles";

for "_i" from 0 to (count _cfgvehicles)-1  do {
    private _vehicle    = _cfgvehicles select _i;
    if (isClass _vehicle) then {        
        private _classname = configName(_vehicle);
        private _namearr = _classname splitString "_";
        _scope =  getnumber(configFile >> "cfgvehicles" >> _classname >> "scope");
        If (((toUpper(_namearr select 0)) in ["RHS","RHSUSF","RHSGREF"])&&(_scope>1)) then {
            _side = getnumber(configFile >> "cfgvehicles" >> _classname >> "side");
            If (_classname isKindOf "CAManBase") then {
                If (_side == 1) then {_usf_soldiers pushback [_classname,getText(configFile >> "cfgvehicles" >> _classname >> "faction"),getText(configFile >> "cfgvehicles" >> _classname >> "displayname"),getText(configFile >> "cfgvehicles" >> _classname >> "vehicleClass")];};
                If (_side == 0) then {_afrf_soldiers pushback [_classname,getText(configFile >> "cfgvehicles" >> _classname >> "faction"),getText(configFile >> "cfgvehicles" >> _classname >> "displayname"),getText(configFile >> "cfgvehicles" >> _classname >> "vehicleClass")];};
            }else{
                If (_side == 1) then {_usf_vehicles pushback [_classname,getText(configFile >> "cfgvehicles" >> _classname >> "faction"),getText(configFile >> "cfgvehicles" >> _classname >> "displayname"),getText(configFile >> "cfgvehicles" >> _classname >> "vehicleClass")];};
                If (_side == 0) then {_afrf_vehicles pushback [_classname,getText(configFile >> "cfgvehicles" >> _classname >> "faction"),getText(configFile >> "cfgvehicles" >> _classname >> "displayname"),getText(configFile >> "cfgvehicles" >> _classname >> "vehicleClass")];};
            };
        };
    };
};

_output = "";
{
    _x params ["_cfgEntrie","_faction","_name","_vehicleClass"];
    _output = _output + _br + format["%1;%2;%3;%4",_cfgEntrie,_faction,_name,_vehicleClass];
}forEach _afrf_vehicles;


{
    _x params ["_cfgEntrie","_faction","_name","_vehicleClass"];
    _output = _output + _br + format["%1;%2;%3;%4",_cfgEntrie,_faction,_name,_vehicleClass];
}forEach _usf_vehicles;


{
    _x params ["_cfgEntrie","_faction","_name","_vehicleClass"];
    _output = _output + _br + format["%1;%2;%3;%4",_cfgEntrie,_faction,_name,_vehicleClass];
}forEach _afrf_soldiers;


{
    _x params ["_cfgEntrie","_faction","_name","_vehicleClass"];
    _output = _output + _br + format["%1;%2;%3;%4",_cfgEntrie,_faction,_name,_vehicleClass];
}forEach _usf_soldiers;

copytoClipboard _output;
hint "finished";