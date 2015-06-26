
// Constant speed for CE penetrators
#define TypicalSpeed 1000
// path to materials for easier 3rd mod adoption
#define MatPath(percentage) 'rhsafrf\addons\rhs_main\penetration\ce_0.##percentage##.bisurf'

private ["_arr","_pens", "_veh", "_anim"];

// First hitPart element
_arr = _this select 0;

// Exit on non-direct hits
if !(_arr select 10) exitWith {};

// Get AIS Penetrators array from cfgAmmo (defaults to CE)
_pens = getArray (configFile >> "CfgAmmo" >> (_arr select 6 select 4) >> "ais_ce_penetrators");

// Exit if projectile has no penetrators 
if (count _pens == 0) exitWith {};

// Exit if projectile is penetrator
if ((_pens select 0) == "") exitWith {};

// Vehicle that was hit
_veh = _arr select 0;

// Get vehicle CE animations
_anim = getText (configFile >> "CfgVehicles" >> (typeOf _veh) >> "ais_ce_protector");

// If vehicle has CE animations, run them
if(_anim != "") then {
	// Check if vehicle is animating, exit on true
	if ((_veh animationPhase _anim) == 0) then {
		// Do animation, set to ONE
		_veh animate [_anim, 1];
		// Spawn thread for delayed reverse of animation
		[_veh, _anim] spawn {
			// Sleep for penetrator(s) to pass/die
			sleep 0.15;
			// Revert animation, set to ZERO
			(_this select 0) animate [(_this select 1), 0];
		};
	};
};

// Get surface modifier
private ["_surface","_mod"];
_surface = _arr select 9;
_surfaces =
[
	MatPath(95),
	MatPath(90),
	MatPath(85),
	MatPath(80),
	MatPath(75),
	MatPath(70),
	MatPath(65),
	MatPath(60),
	MatPath(50),
	MatPath(40),
	MatPath(30),
	MatPath(20),
	MatPath(10)
];
_mod = _surfaces find _surface;

// Spawn thread for warheads
[_pens, _arr select 3, _arr select 4, _mod] spawn  {
	private "_mod";
	_mod = _this select 3;
	// Spawn CE penetrator for each warhead
	{
		private ["_pos","_vel","_p"];
		_pos = ASLToATL (_this select 1);
		_vel = (vectorNormalized (_this select 2));
		// Move penetrator back 0.2 
		_pos = _pos vectorAdd (_vel vectorMultiply -0.2);
		_vel = _vel vectorMultiply TypicalSpeed;
		// Create penetrator
		_p = createVehicle [_x, _pos, [], 0, "CAN_COLLIDE"];
		if (_mod != -1) then {
			// Apply surface modifier
			_vel = _vel vectorMultiply ([0.95,0.9,0.85,0.8,0.75,0.7,0.65,0.6,0.5,0.4,0.3,0.2,0.1] select _mod);
		};
		_p setVelocity _vel;
		// diag_log format["created penetrator, p: %1, pos: %2, vel: %3, class: %4, mod: %5", _p, ASLToATL (_this select 1), _vel, _x, _mod];
		// Add small delay between penetrators
		sleep 0.05;
	} forEach (_this select 0);
};