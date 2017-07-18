---
title: spawn
layout: brigade
---

### short description:
The spawning functions.



#### Cleanup
`EGVAR(spawn,cleanUpDump)` is used to delete Objects after the mainmission has been deleted.
`EGVAR(spawn,cleanUp_Dump_int) pushBack [**TIME**,**OBJECT/GROUP**]` this is the internal Variable. You can force the deletion of a OBJECT by adding this to the list.
The cleanup deletes objects every 5 seconds for a certain amount of time. If an Objects was not deleted, it will get deleted in the next cycle.
By setting `OBJECT setVariable [QGVARMAIN(canDelete),false]` you can prevent the Deleting of an Object. You have to delete the object manually e.g. by adding it to `EGVAR(spawn,cleanUpDump)`.


### Features:
##### Compositions
Spawning of predefined compositions
##### Composition Houses
Spawning of reenforced buildings
##### Spawning of Enemys
Spawns the enemy vehicles and Units
##### Spawning of Mines and IEDs
spawns minefields and IEDa at roads
##### Civilian cars
Civilian Cars in garages and roadside
