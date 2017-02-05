/*
    Author: iJesuz

    Description:
        initialize everything

    Note(s):
        - A hash is a mission if it has the following keys:
          - type (STRING)
          - location ([STRING,POSITION])
          - state (STRING)
          - condition (function name) (STRING)
          - arguments (ANY)
        Internally a mission becomes a taskhandler too and gets
        the key BIS_taskID (STRING).

        - A hash is a taskhandler if it has the following keys:
            - name (STRING)
            - counter (NUMBER)
            - missions ([STRING])
            - <mission_name> (MISSION)
          You can use the functions add(Child) and remove(Child)
          to communicate with the kerberos's taskhandler.

    Parameter(s):
        -

    Return:
        -
*/
#include "script_component.hpp"

__THIS = HASH_CREATE;
THIS_SET("name", "dorb_mission");
THIS_SET("counter", 0);
THIS_SET("missions", []);

[] call FUNC(taskmanager_handle);
