/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

// Types of Target
GVAR(info_targetType) = HASH_CREATE;
{
    HASH_SET(GVAR(info_targetType),_x select 0,[_x select 1,_x select 2]);
} forEach [
    ["00","",""],
    ["CODE","TYPE","SUBTYPE"],
    ["01","Air Defense Artillery","Unknown"],
    ["02","Air Defense Artillery","Light"],
    ["03","Air Defense Artillery","Medium"],
    ["04","Air Defense Artillery","Heavy"],
    ["05","Air Defense Artillery","Missile"],
    ["06","Air Defense Artillery","Position"],
    ["07","Armor","Unknown"],
    ["08","Armor","Light"],
    ["09","Armor","Medium"],
    ["10","Armor","Heavy"],
    ["11","Armor","Armored Personnel Carrier"],
    ["12","Armor","Position"],
    ["13","Artillery","Unknown"],
    ["14","Artillery","Light"],
    ["15","Artillery","Medium"],
    ["16","Artillery","Heavy"],
    ["17","Artillery","Position"],
    ["18","Assembly Areas","Unknown"],
    ["19","Assembly Areas","Troops"],
    ["20","Assembly Areas","Troops and Vehicles"],
    ["21","Assembly Areas","Mechanized Troops"],
    ["22","Assembly Areas","Troops and Armor"],
    ["23","Building","Unknown"],
    ["24","Building","Wood"],
    ["25","Building","Masonry"],
    ["26","Building","Concrete"],
    ["27","Building","Metal"],
    ["28","Building","Special Purpose"],
    ["29","Bridge","Unknown"],
    ["30","Bridge","Foot Pontoon"],
    ["31","Bridge","Vehicle Pontoon"],
    ["32","Bridge","Concrete"],
    ["33","Bridge","Wood"],
    ["34","Bridge","Steel"],
    ["35","Bridge","Site"],
    ["36","Bridge","Raft"],
    ["37","Bridge","Ferry"],
    ["38","Center","Unknown"],
    ["39","Center","Small"],
    ["40","Center","Battalion"],
    ["41","Center","Regiment"],
    ["42","Center","Division"],
    ["43","Center","Forward"],
    ["44","Equipment","Unknown"],
    ["45","Equipment","Radar"],
    ["46","Equipment","Electronic Warfare"],
    ["47","Equipment","Search-light"],
    ["48","Equipment","Guidance"],
    ["49","Equipment","Loud-speaker"],
    ["50","Mortars","Unknown"],
    ["51","Mortars","Light"],
    ["52","Mortars","Medium"],
    ["53","Mortars","Heavy"],
    ["54","Mortars","Very Heavy"],
    ["55","Mortars","Position"],
    ["56","Personnel","Unknown"],
    ["57","Personnel","Infantry"],
    ["58","Personnel","Observation Post"],
    ["59","Personnel","Patrol"],
    ["60","Personnel","Work Party"],
    ["61","Personnel","Position"],
    ["62","Rockets/Missiles","Unknown"],
    ["63","Rockets/Missiles","Anti-personnel"],
    ["64","Rockets/Missiles","Light Missile"],
    ["65","Rockets/Missiles","Medium Missile"],
    ["66","Rockets/Missiles","Heavy Missile"],
    ["67","Rockets/Missiles","Antitank"],
    ["68","Rockets/Missiles","Position"],
    ["69","Supply Dump","Unknown"],
    ["70","Supply Dump","Class 5"],
    ["71","Supply Dump","Class 3"],
    ["72","Supply Dump","Class 4"],
    ["73","Supply Dump","Class 1"],
    ["74","Supply Dump","Class 2"],
    ["75","Terrain Features","Unknown"],
    ["76","Terrain Features","Road"],
    ["77","Terrain Features","Road Junction"],
    ["78","Terrain Features","Hill"],
    ["79","Terrain Features","Defile"],
    ["80","Terrain Features","Landing Strip"],
    ["81","Terrain Features","Railroad"],
    ["82","Vehicle","Unknown"],
    ["83","Vehicle","Light Wheeled"],
    ["84","Vehicle","Heavy Wheeled"],
    ["85","Vehicle","Reconnaissance"],
    ["86","Vehicle","Boats"],
    ["87","Vehicle","Aircraft"],
    ["88","Vehicle","Helicopter"],
    ["89","Weapons","Unknown"],
    ["90","Weapons","Light Machine Gun"],
    ["91","Weapons","Antitank Gun"],
    ["92","Weapons","Heavy Machine Gun"],
    ["93","Weapons","Recoilless Rifle"]];

//
GVAR(info_protection) = HASH_CREATE;
{
    HASH_SET(GVAR(info_protection),_x select 0,[_x select 1,_x select 2]);
} forEach [
    ["CODE","FIRST VOLLEY","SUBSEQUENT VOLLEYS","VOICE EQUIVALENT"],
    ["1","Half Prone, Half Standing","All Prone","Standing"],
    ["2","Prone","Prone","Prone"],
    ["3","Prone","Dug In","Mix Dug in"],
    ["4","Prone","Under Overhead Cover ","Mix Overhead"],
    ["5","Dug In","Dug In","Dug In"],
    ["6","Under Overhead Cover","Under Overhead Cover","Overhead"]
];


GVAR(info_VULNERABILITIES) = HASH_CREATE;
{
    HASH_SET(GVAR(info_VULNERABILITIES),_x select 0,[_x select 1]);
} forEach [
    ["CODE","DEFINITION"],
    ["1","Casualties to Personnel in Open"],
    ["2","Casualties to Personnel in Tank"],
    ["3","Casualties to Personnel in APCs"],
    ["4","Casualties to Personnel in Wheeled Vehicles"],
    ["5","Casualties to Personnel in Earth Shelters"],
    ["6","Casualties to Personnel in Foxholes"],
    ["7","Moderate Damage to Exposed Wheeled Vehicles"],
    ["8","Moderate Damage to Shielded Wheeled Vehicles"],
    ["9","Moderate Damage to Towed Artillery"],
    ["10","Moderate Damage to Tanks, APCs, and SP Artillery"],
    ["11","Moderate Damage to Hard Fixed Bridges"],
    ["12","Moderate Damage to Soft Fixed Bridges"],
    ["13","Severe Damage to Supply Depots"],
    ["14","Severe Damage to Randomly Parked Cargo/Transportation Helicopters"],
    ["15","Severe Damage to Randomly Parked Light Observation Helicopter"]
];


GVAR(info_FUZES) = HASH_CREATE;
{
    HASH_SET(GVAR(info_FUZES),_x select 0,[_x select 1]);
} forEach [
    ["CODE","DEFINITION"],
    ["CP","Concrete Piercing"],
    ["MRD","Multi-Role Fuze Delay"],
    ["MRF","Multi-Role Fuze"],
    ["MRP","Multi-Role Fuze Point Detonation"],
    ["MRT","Multi-Role Fuze Time"],
    ["MRV","Multi-Role Fuze Variable Time"],
    ["PD","Point Detonation"],
    ["PDD","Point Detonation Delay"],
    ["TI","Time Action"],
    ["VT","Variable Time"],
    ["VTD","Variable Time Desensitized"]
];


GVAR(info_PROJECTCODES) = HASH_CREATE;
{
    HASH_SET(GVAR(info_PROJECTCODES),_x select 0,[_x select 1]);
} forEach [
    ["CODE","DEFINITION"],
    ["AML","Anti-Materiel Mine, Long Delay"],
    ["AMS","Anti-Materiel Mine, Short Delay"],
    ["APL","Anti-Personnel Mine, Long Delay"],
    ["APS","Anti-Personnel Mine, Short Delay"],
    ["HEA","High Explosive"],
    ["HEB","Improved High Explosive"],
    ["HED","Anti-Personnel & AntiMaterial Submunitions"],
    ["HEI","ATICM Anti-Tank Submunitions"],
    ["HER","Rocket Assisted"],
    ["ILL","Illuminating"],
    ["ILR","Illuminating Infra Red"],
    ["JED","DPICM Anti-Personnel & Anti-Material Submunitions"],
    ["JEE","ATCMS Anti-Material & AntiPersonnel"],
    ["JEH","Reduced Range Practice Rocket"],
    ["JEL","Extended Range Rocket"],
    ["JEM","DEU/GBR Reduced Range Practice Rocket"],
    ["JMT","Anti-Tank Mine"],
    ["JTA","MLRS Terminally Guided Warhead"],
    ["JTB","MLRS SADARM"],
    ["JTC","ATCMS Brilliant Anti-Tank"],
    ["LEA","Leaflet/Propaganda"],
    ["RP","Smoke Red Phosphorous"],
    ["SMK","Smoke"],
    ["WP","Smoke White Phosphorous"]
];
