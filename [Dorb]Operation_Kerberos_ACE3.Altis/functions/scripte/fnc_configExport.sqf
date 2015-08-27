_afrf_soldiers = "Soldiers";
_afrf_vehicles = "Vehicles";
_afrf_air = "Air";

_usf_soldiers = "Soldiers";
_usf_vehicles = "Vehicles";
_usf_air = "Air";

_rest="Other";

_cfgvehicles = configFile >> "cfgvehicles";

for "_i" from 0 to (count _cfgvehicles)-1  do {
	_vehicle	= _cfgvehicles select _i;
	if (isClass _vehicle) then {		
		_class 		= configName(_vehicle);
		_namearr = _class splitString "_";
		_scope =  getnumber(configFile >> "cfgvehicles" >> _class >> "scope");
		If (((_namearr select 0) in ["RHS","RHSUSF"])&&(_scope>1)) then {
			_side	 	= getnumber(configFile >> "cfgvehicles" >> _class >> "side");
			/*If (_class isKindOf "Air") then {
				If (_side == 1) then {_usf_air = _usf_air + format[" , %1",_class];};
				If (_side == 0) then {_afrf_air = _afrf_air + format[" , %1",_class];};
			};
			If (_class isKindOf "Man") then {
				If (_side == 1) then {_usf_soldiers = _usf_soldiers + format[" , %1",_class];};
				If (_side == 0) then {_afrf_soldiers = _afrf_soldiers + format[" , %1",_class];};
			};
			If (_class isKindOf "LandVehicle") then {
				If (_side == 1) then {_usf_vehicles = _usf_vehicles + format[" , %1",_class];};
				If (_side == 0) then {_afrf_vehicles = _afrf_vehicles + format[" , %1",_class];};
			};
			*/
			If (_side == 1) then {
				_usf_vehicles = _usf_vehicles + format[" , %1",_class];
			}else{
				If (_side == 0) then {
					_afrf_vehicles = _afrf_vehicles + format[" , %1",_class];
				}else{
					_rest = _rest + format[" , %1",_class];
				};
			};
		};
	};
};

_return=[_usf_vehicles,_afrf_vehicles,_rest];
//_return=_afrf_air + _afrf_soldiers + _afrf_vehicles + _usf_air + _usf_soldiers + _usf_vehicles;
_return