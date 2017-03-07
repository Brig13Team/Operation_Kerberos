#include "script_component.hpp"
ADDON = false;

PREP(add);
PREP(disable);
PREP(enable);
PREP(remove);

ADDON = true;

If (isServer) then {
    enableDynamicSimulationSystem true;
}else{
    enableDynamicSimulationSystem false;
};

"Prop" setDynamicSimulationDistance 150;
"Vehicle" setDynamicSimulationDistance 1000;
"EmptyVehicle" setDynamicSimulationDistance 500;
"Group" setDynamicSimulationDistance 1500;

"IsMoving" setDynamicSimulationDistanceCoef 2;
