/*
    Author: iJesuz

    Description:
        initialize everything

    Note(s):
        - A hash is a mission if it has the following keys:
          - type (STRING)                         -- set by FUNC(taskmanager___spawn)
          - state (STRING)                        -- set by FUNC(mainmission___spawn)
          - location ([STRING,POSITION])          -- set by FUNC(mainmission___spawn)
          - condition (function name) (STRING)    -- set by FUNC(mainmission___<type>)
          - <arguments> (for condition) (ANY)     -- set by FUNC(mainmission___<type>)
        A mission can have the following optional keys:
          - event_callback (function name) (STRING) -- set by FUNC(mainmission___<type>)
          - <event_arguments> (for event) (ANY)   -- set by FUNC(mainmission___<type>)
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
