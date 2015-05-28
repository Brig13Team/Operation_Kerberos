/* == TASKMASTER ===============================================================================
  
  Version 0.39
  Author: Shuko (shuko@quakenet, miika@miikajarvinen.fi)
  Contributors: cuel, galzohar, zuff
  Forum: http://forums.bistudio.com/showthread.php?160974-SHK_Taskmaster
  
  == Creating a briefing =======================================================================
  
  Tasks and notes are given in the init.sqf.
  
  Syntax: [[[Task1Data],[Task2Data]],[[Note1Data],[Note2Data]]] execvm "shk_taskmaster.sqf";
  Example:
    [[
      ["Task1","Task1Title","Task1Desc"],
      ["Task2","Task2Title","Task2Desc",true,["markerTask2",getpos obj2]]
    ],[
      ["Note1","Hello West",WEST],
      ["Note2","Hello East",EAST],
      ["Credits","<br />Made by: Shuko of LDD Kyllikki<br />Contact: shuko@Quakenet<br />www.kyllikki.fi"]
    ]] execvm "shk_taskmaster.sqf";
  
  -- Task Data ---------------------------------------------------------------------------------
    ["TaskName","Title","Description",Condition,[Marker],"State"]
    
    Required parameters:
      TaskName      string     Name used to refer to the task
      Title         string     Task name shown in the in/game task list
      Description   string     Task description, the actual text body
    
    Optional parameters:
      Condition     boolean/side/faction/unit/group/string   Units the task is added to. Default is everyone
      Marker        array     Marker related to the task. It will be created only for the units who have the
                              task. Marker will be hidden after task is completed. Can be an array of marker
                              arrays, if you want to create multiple markers.
        Name        string    Name of the marker to create.
        Position    string    Position of the marker.
        Type        string    Marker type. Optional, default is "selector_selectedMission".
        Color       string    Marker color. Optional, default is red.
        Text        string    Marker text.
        Shape       string    Marker shape: Icon, Ellipse, Rectangle
        Size        number or array     Marker size. If number given, it's used for both X and Y dimension.
      State         string    Task state of the newly created task. Default is "created".
      Destination   object/position/marker   Place to create task destination (game's built-in waypoint/marker). If an object is given, setSimpleTaskTarget command is used, attaching the destination to it.
      
    - Condition -
    It's possible to specify which units (groups, side etc) you want to create the tasks/notes for.
    
    Examples:
      [...,WEST]               All playable units on BLUFOR (WEST)
      [...,"USMC"]             Faction USMC
      [...,grpMarine1]         Units that belong to group named grpMarine1
      [...,myDude]             Unit named myDude
      
    Then there is the IF syntax, so you can create a condition anyway you want, where _x is the unit (=player).
    
    Examples:
      "((group _x == grpScouts) OR (_x == pilot1))"     Members of grpScouts and unit named pilot1
      "(typeof _x == ""CDF_Soldier_Sniper"")"           All CDF snipers
  
  -- Note Data ---------------------------------------------------------------------------------
    [NoteTitle,NoteText,Condition]
    
    Required parameters:
      NoteTitle     string     Text shown in the list
      NoteText      string     The actual note text body
      
    Optional parameters:
      Condition    boolean/side/faction/unit/group/string   Units the note is added to. Default is everyone.
      
  == Updating tasks ============================================================================
  
  Task states are updated by calling a function. Possible states are: succeeded/failed/canceled/assigned/created.
  Example: ["Task1","succeeded"] call SHK_Taskmaster_upd;
  
  It's possible to set state of one task and set another as assigned using an optional 3rd parameter.
  Example: ["Task1","succeeded","Task2"] call SHK_Taskmaster_upd;
  
  This will make task state of task Task1 to succeeded and the state of the task Task2 as assigned.
  
  Another optional 3rd parameter can be used to add a new task after updating another task.
  Example: ["Task1","succeeded",["Task2","Title","Desc"]] call SHK_Taskmaster_upd;
  
  This will make task Task1 as succeeded and create a new task Task2. Same set of parameters is used for the
  creation as in init.sqf or SHK_Taskmaster_add.
  
  == Creating tasks during a mission ===========================================================
  
  Tasks can be added after briefing with the add function. Same set of parameters is used as in creating a
  briefing.
  
  Example: ["Task2","Extraction","Get to teh choppa!"] call SHK_Taskmaster_add;
  
  == Checking task status ======================================================================
  
    SHK_Taskmaster_areCompleted
      This function can be used to check if multiple tasks are completed. Task is considered completed with states
      succeeded, failed and canceled. Function returns a boolean (true/false) value.
  
      Example: ["Task1","Task2"] call SHK_Taskmaster_isCompleted
  
    SHK_Taskmaster_isCompleted
      This function can be used to check if a task is completed. Task is considered completed with states
      succeeded, failed and canceled. Function returns a boolean (true/false) value.
  
      Example: "Task1" call SHK_Taskmaster_isCompleted
      Multiple tasks: ["Task1","Task2"] call SHK_Taskmaster_isCompleted
    
    SHK_Taskmaster_getAssigned
      Returns list of tasks which have "assigned" as their state.
      
      Example: call SHK_Taskmaster_getAssigned
      Example result: ["Task1","Task4"]
      
    SHK_Taskmaster_getState
      Returns the task state (succeeded/failed/canceled/assigned/created).
      
      Example: "Task1" call SHK_Taskmaster_getState
      
    SHK_Taskmaster_hasState
      Checks if a task's state matches the given state. Function returns a boolean value.
      
      Example: ["Task1","succeeded"] call SHK_Taskmaster_hasState

    SHK_Taskmaster_hasTask
      Checks if a task with the given name has been created. Returns boolean.
      
      Example: "Task1" call SHK_Taskmaster_hasTask
      
    SHK_Taskmaster_setCurrentLocal
      Sets the given task as the current task.
      
      Example: "Task1" call SHK_Taskmaster_setCurrentLocal;
      Multiplayer Example: ["Task1","SHK_Taskmaster_setCurrentLocal",true,true] call BIS_fnc_MP
      
    SHK_Taskmaster_addNote (client only)
      Creates a briefing note. This can only be used on client side, and it's not broadcasted for
      other players.
      
      Parameters: ["Title","TextBody",Condition]
      
      Condition is optional.
      
      Example: Example: ["Enemy forces","Oh noes, there will be enemy soldiers in the area of operation."] call SHK_Taskmaster_addNote
  
  == Known Issues =========================================================================
    If multiple add/upd calls are used nearly simultaneously (for example in same onAct field of a trigger) the tasks can multiply.
    This is because the script uses publicvariable and publicvariable eventhandler syncing. First command needs to travel over the net
    from server to clients and be processed before another update comes in. Way to avoid this issue is to add some waiting between the
    calls, for example "sleep 1;".
  
  == Version history ======================================================================
    0.39  Added: More marker options.
    0.38  Added: SHK_Taskmaster_isCompleted now takes multiple tasks are parameter. Also, added _areCompleted as a wrapper function.
    0.37  Changed: Task creation order was reversed in Arma 2. It was changed in Arma 3. Changed the order in script to be correct with A3. Automatic current task assignment was removed, use the SHK_Taskmaster_setCurrentLocal.
    0.36  Added: SHK_Taskmaster_setCurrentLocal can now be used to set a task as current task. Only works locally, so use with BIS_fnc_MP.
    0.35  Changed: Faction faction list to A3.
    0.34  Switch to Arma 3, changed hint notification to use the A3 command.
    0.33  Added: Now it's possible to add marker texts.
    0.32  Added: Now it's possible to define multiple markers for a task.
    0.31  Fixed: Change in v0.29 broke task state update for JIPs. States were being overwritten by setcurrenttask command.
    0.30  Added: Parameter to create task destination.
    0.29  Added: Last task to be added will be made current task automatically.
    0.28  Fixed: Markers of completed tasks were not hidden for JIPs.
    0.27  Fixed: Attempt to prevent double tasks from being added when the add parameter is used with the update function.
    0.26  Added: Script can be called without parameters, just to load the functions for later use.
    0.25  Changed: 1.55 patch changed note addition order to same as tasks. Code changed to keep the old way of adding them.
    0.24  Changed: Marker handling. Hiding/showing has been removed and replaced with local marker creation.
    0.23  Added: Support for Single Player missions. Mainly to enable tasks in the SP mission editor preview.
    0.22  Changed: Made add, assign and update functions useable in triggers without getting undefined variable error on clients.
    0.21  Changed: Script can now be started with call as well as execvm.
    0.20  Added: Support for non-dedicated servers.
    0.13  Added: SHK_Taskmaster_initDone variable will be set to true once tasks are processed and functions loaded.
    0.12  Fixed: Task updates now wait for player to be alive (after respawn etc).
    0.11  Fixed: Missed !isnull player check, which caused problems in marker handling.
*/
#define FACTIONLIST ["BLU_F","OPF_F","IND_F","IND_G_F","CIV_F"]
DEBUG = false;
/* == COMMON =================================================================================== */
  SHK_Taskmaster_initDone = false;
  SHK_Taskmaster_add = {
    /*   Take a task data array, apply default params if needed, save to the task list. Send to clients.
     In: array     ["Name","Title","Desc",[Marker],"State",Destination]
    Out:
    */
    if isserver then {
      private ["_name","_short","_long","_cond","_marker","_state","_dest"];
      _name = _this select 0;
      _short = _this select 1;
      _long = _this select 2;
      if (count _this > 3) then { _cond = _this select 3 } else { _cond = true };
      if (count _this > 4) then { _marker = _this select 4 } else { _marker = [] };
      if (count _this > 5) then { _state = _this select 5 } else { _state = "created" };
      if (count _this > 6) then { _dest = _this select 6 } else { _dest = 0 };
      SHK_Taskmaster_Tasks set [count SHK_Taskmaster_Tasks, [_name,_short,_long,_cond,_marker,_state,_dest]];
      publicvariable "SHK_Taskmaster_Tasks";
      /*
        Update for host of the non-dedicated server.
      */
      if (!isdedicated && SHK_Taskmaster_initDone) then {
        SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
      };
    };
  };
  SHK_Taskmaster_addNote = {
    /*   Creates a briefing note.
     In: array     ["Title","TextBody",Condition]
    Out:
    */
    private "_cond";
    if (count _this > 2) then { _cond = _this select 2 } else { _cond = true };
    {
      if ( [_x,_cond] call SHK_Taskmaster_checkCond ) then {
        _x creatediaryrecord ["Diary",[_this select 0,_this select 1]];
        if (time > 10) then{ hintsilent "Diary note added." };
      };
    } foreach  (if ismultiplayer then {playableunits} else {switchableunits});
  };
  SHK_Taskmaster_addTask = {
    /*   Creates the given task for each playableunit and saves the handles.
         Adds a task array with name, state and handles to the local task list.
         If marker exists, it will be shown or hidden depending if the unit has the task.
      In: array     ["Name","Title","Desc",[Marker],"State",Destination]
    */
    
    private ["_handle","_handles","_name","_state","_marker","_dest"];
    _handles = [];
    _name = _this select 0;
    _marker = _this select 4;
    _state = _this select 5;
    _dest = _this select 6;
    if DEBUG then { diag_log format ["SHK_Taskmaster> addTask: %1, %2, %3, %4",_name,_marker,_state,_dest]};
    {
      if ( [_x,(_this select 3)] call SHK_Taskmaster_checkCond ) then {
        _handle = _x createsimpletask [_name];
        _handle setsimpletaskdescription [(_this select 2),(_this select 1),""];
        _handle settaskstate _state;
        
        //if (_state in ["created","assigned"]) then {
          //_x setcurrenttask _handle;
        //};
        switch (toupper(typename _dest)) do {
          case "OBJECT": { _handle setsimpletasktarget [_dest,true] };
          case "STRING": { _handle setsimpletaskdestination (getmarkerpos _dest) };
          case "ARRAY": { _handle setsimpletaskdestination _dest };
        };
        
        _handles set [count _handles,_handle];
        
        if (_x == player) then {
          if (SHK_Taskmaster_showHints) then { [_handle,_state] call SHK_Taskmaster_showHint };
          
          if (count _marker > 0) then {
            if !(_state in ["succeeded","failed","canceled"]) then {
              if (typename (_marker select 0) == typename "") then {
                _marker = [_marker];
              };
              private ["_m","_type","_color","_txt","_shape","_size"];
              {
                _m = createmarkerlocal [(_x select 0),(_x select 1)];
                
                _type = "selector_selectedMission";
                if (count _x > 2) then {
                  private "_tmp";
                  _tmp = (_x select 2); 
                  if (_tmp != "") then {
                    _type = _tmp;
                  };
                };
                _m setmarkertypelocal _type;
                
                _color = "ColorRed";
                if (count _x > 3) then {
                  private "_tmp";
                  _tmp = (_x select 3);
                  if (_tmp != "") then {
                    _color = _tmp;
                  };
                };
                _m setmarkercolorlocal _color;
                
                _txt = "";
                if (count _x > 4) then {
                  private "_tmp";
                  _tmp = (_x select 4);
                  if (_tmp != "") then {
                    _color = _tmp;
                  };
                };
                _m setmarkertextlocal _txt;
                
                _shape = "ICON";
                if (count _x > 5) then {
                  private "_tmp";
                  _tmp = (_x select 5);
                  if (_tmp != "") then {
                    _shape = _tmp;
                  };
                };
                _m setmarkershapelocal _shape;
                
                _size = [1,1];
                if (count _x > 6) then {
                  private "_tmp";
                  _tmp = (_x select 6);
                  if (typeName _tmp == typeName 0) then {
                    _tmp = [_tmp,_tmp];
                  };
                  if !([_tmp,[1,1]] call BIS_fnc_areEqual) then {
                    _size = _tmp;
                  };
                };
                _m setmarkersizelocal _size;
                
              } foreach _marker;
            };
          };
        };
      };
    } foreach (if ismultiplayer then {playableunits} else {switchableunits});
    SHK_Taskmaster_TasksLocal set [count SHK_Taskmaster_TasksLocal,[_name,_state,_handles]];
  };
  SHK_Taskmaster_areCompleted = {
    /*   Checks if tasks are completed.
     In: array of strings     Task names
    Out: boolean
    */
    private ["_b"];
    _b = false;
    _b = _this call SHK_Taskmaster_isCompleted;
    _b;
  };
  SHK_Taskmaster_assign = {
    /*   Changes task's state to assigned.
     In: string     "Name"
    Out:
    */
    if isserver then {
      private "_task";
      for "_i" from 0 to (count SHK_Taskmaster_Tasks - 1) do {
        if (_this == ((SHK_Taskmaster_Tasks select _i) select 0)) then {
          _task =+ SHK_Taskmaster_Tasks select _i;
          _task set [5,"assigned"];
          SHK_Taskmaster_Tasks set [_i,_task];
        };
      };
      publicvariable "SHK_Taskmaster_Tasks";
      /*
        Update for host of the non-dedicated server.
      */
      if (!isdedicated && SHK_Taskmaster_initDone) then {
        SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
      };
    };
  };
  SHK_Taskmaster_checkCond = {
    /*   Checks if given unit fulfills the requirement.
     In: array     [Unit,Condition]
    Out: boolean
    */
    private ["_unit","_cond"];
    _unit = _this select 0;
    _cond = _this select 1;
    if (!isNil "_cond") then {
      if DEBUG then { diag_log format ["SHK_Taskmaster> typename condition: %1",typename _cond]};
      switch (typename _cond) do {
        case (typename grpNull): { (_unit in (units _cond)) };
        case (typename objNull): { _unit == _cond };
        case (typename WEST):    { (side _unit == _cond) };
        case (typename true):    { _cond };
        case (typename ""): {
          if (_cond in FACTIONLIST) then {
            (faction _unit == _cond)
          } else {
            (call compile format ["%1",_cond])
          };
        };
        default { false };
      };
    } else { false };
  };
  SHK_Taskmaster_getAssigned = {
    /*   Returns list of tasks which have "assigned" as their state.
     In:
    Out: array      ["TaskName","TaskName"]
    */
    private "_l";
    _l = [];
    {
      if ((_x select 5) == "assigned") then {
        _l set [count _l,(_x select 0)];
      };
    } foreach SHK_Taskmaster_Tasks;
    _l;
  };
  SHK_Taskmaster_getState = {
    /*   Returns state of the given task.
     In: string      "Name"
    Out: string      "State"
    */
    private "_s";
    {
      if (_this == (_x select 0)) exitwith {
        _s = (_x select 5);
      };
    } foreach SHK_Taskmaster_Tasks;
    _s;
  };
  SHK_Taskmaster_handleEvent = {
    /*   Takes the pubvar'd task array and determines if a task needs to be added or updated.
     In: array     SHK_Taskmaster_Tasks from pubvar eventhandler
    Out:
    */
    waituntil {alive player};
    private "_name";
    {
      _name = _x select 0;
      if (_name call SHK_Taskmaster_hasTaskLocal) then {
        if ([_name,(_x select 5)] call SHK_Taskmaster_hasStateChanged) then {
          if DEBUG then { diag_log format ["SHK_Taskmaster> handleEvent calling updateTask: %1",_name]};
          _x call SHK_Taskmaster_updateTask;
        };
      } else {
        if DEBUG then { diag_log format ["SHK_Taskmaster> handleEvent calling addTask: %1",_name]};
        _x call SHK_Taskmaster_addTask;
      };
    } foreach _this;
  };
  SHK_Taskmaster_hasState = {
    /*   Checks if given task has a specific state.
      In: array     ["Name","State"]
     Out: boolean
    */
    private "_b";
    _b = false;
    {
      if ((_this select  0) == (_x select 0)) then {
        if (((_this select 0) call SHK_Taskmaster_getState) == (_this select 1)) then {
          _b = true;
        };
      };
    } foreach SHK_Taskmaster_Tasks;
    _b;
  };
  SHK_Taskmaster_hasStateChanged = {
    /*   Checks if the task state of the given task has changed.
      In: array     ["TaskName","TaskState"]
     Out: boolean
    */
    private "_b";
    _b = false;
    {
      if ((_this select 0) == (_x select 0)) then {
        if ((_this select 1) != (_x select 1)) exitwith {
          _b = true;
        };
      };
    } foreach SHK_Taskmaster_TasksLocal;
    _b;
  };
  SHK_Taskmaster_hasTask = {
    /*   Checks if task with given name already exists.
     In: string     Task name
    Out: boolean
    */
    private "_b";
    _b = false;
    {
      if (_this == (_x select 0)) exitwith { _b = true };
    } foreach SHK_Taskmaster_Tasks;
    _b;
  };
  SHK_Taskmaster_hasTaskLocal = {
    /*   Checks if task with given name already exists.
     In: string     Task name
    Out: boolean
    */
    private "_b";
    _b = false;
    {
      if (_this == (_x select 0)) exitwith { _b = true };
    } foreach SHK_Taskmaster_TasksLocal;
    _b;
  };
  SHK_Taskmaster_isCompleted = {
    /*   Checks if task(s) are completed.
     In: string               Task name
     In: array of strings     Task names
    Out: boolean
    */
    private ["_b","_t","_i","_foreachIndex"];
    _b = false;
    if (typeName _this == typeName "") then {
      _this = [_this];
    };
    
    {
      _t = _x;
      _i = _foreachIndex;
      {
        if (_t == (_x select 0)) then {
          if ((_x select 5) in ["succeeded","failed","canceled"]) then {
            _this set [_i,true];
          } else {
            _this set [_i,false]
          };
        };
      } foreach SHK_Taskmaster_Tasks;
    } foreach _this;
    
    if ({_x} count _this == count _this) then {
      _b = true;
    };
    
    _b;
  };
  SHK_Taskmaster_setCurrentLocal = {
    /* Set the given task as current task. */
    {
      if (_this == (_x select 0)) exitwith {
        private "_handle";
        {
          _handle = _x;
          {
            if (_handle in (simpletasks _x)) then {
              _x setcurrenttask _handle;
              
              if (_x == player) then {
                if (SHK_Taskmaster_showHints) then { [_handle,"Assigned"] call SHK_Taskmaster_showHint };
              };
            };
          } foreach (if ismultiplayer then {playableunits} else {switchableunits});
        } foreach (_x select 2);
      };
    } foreach SHK_Taskmaster_TasksLocal;
  };
  SHK_Taskmaster_showHint = {
    private ["_p", "_taskCase"];
    _p = switch (tolower (_this select 1)) do {
      case "created": {   _taskCase = "TaskCreated" };
      case "assigned": {  _taskCase = "TaskAssigned" };
      case "succeeded": { _taskCase = "TaskSucceeded" };
      case "failed": {    _taskCase = "TaskFailed" };
      case "canceled": {  _taskCase = "TaskCanceled" };
    };
    [_taskCase, ["", format ["%1", ((taskDescription (_this select 0)) select 1)]]] spawn BIS_fnc_showNotification;
  };
  SHK_Taskmaster_upd = {
    /*   Take a task data array, update the task list. Send to clients.
     In: array     ["Name","Title","Desc",[Marker],"State"]
    Out:
    */
    if isserver then {
      private ["_task","_state"];
      _state = (_this select 1);
      for "_i" from 0 to (count SHK_Taskmaster_Tasks - 1) do {
        _task =+ (SHK_Taskmaster_Tasks select _i);
        if ((_task select 0) == (_this select 0)) then {
          _task set [5,_state];
        };
        SHK_Taskmaster_Tasks set [_i,_task];
      };
      if (count _this > 2) then {
        switch (typename (_this select 2)) do {
          case (typename ""): { (_this select 2) call SHK_Taskmaster_assign };
          case (typename []): { (_this select 2) spawn { sleep 1; _this call SHK_Taskmaster_add} };
        };
      };
      publicvariable "SHK_Taskmaster_Tasks";
      /*
        Update for host of the non-dedicated server.
      */
      if (!isdedicated && SHK_Taskmaster_initDone) then {
        SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
      };
    };
  };
  SHK_Taskmaster_updateTask = {
    /*   Updates task state for all playableunits and local task list.
         Delete marker of completed task.
     In: array     ["Name","Title","Desc",[Marker],"State"]
    Out:
    */
    private ["_task","_name","_state","_handle","_marker"];
    for "_i" from 0 to (count SHK_Taskmaster_TasksLocal - 1) do {
      _task =+ SHK_Taskmaster_TasksLocal select _i;
      _name = _task select 0;
      if (_name == (_this select 0)) then {
        _marker = _this select 4;
        _state = _this select 5;
        _task set [1,_state];
        SHK_Taskmaster_TasksLocal set [_i,_task];
        {
          _handle = _x;
          {
            if (_handle in (simpletasks _x)) then {
              _handle settaskstate _state;
              
              if (_x == player) then {
                if (SHK_Taskmaster_showHints) then { [_handle,_state] call SHK_Taskmaster_showHint };
                
                if (count _marker > 0) then {
                  if (_state in ["succeeded","failed","canceled"]) then {
                    if DEBUG then { diag_log format ["SHK_Taskmaster> updateTask deleting marker: %1, state: %2",_marker,_state]};
                    if (typename (_marker select 0) == typename "") then {
                      _marker = [_marker];
                    };
                    {
                      deletemarkerlocal (_x select 0);
                    } foreach _marker;
                  };
                };
              };
            };
          } foreach (if ismultiplayer then {playableunits} else {switchableunits});
        } foreach (_task select 2);
      };
    };
  };

/* == SERVER =================================================================================== */
if isserver then {
  SHK_Taskmaster_Tasks = []; // Array member: ["Name","Title","Desc","Marker","State"]
  /*
    Iterate through the tasks received from init.sqf and add them to an array. Then send it to clients.
  */
  if (!isnil "_this") then {
    if (count _this > 0) then {
      private ["_task","_tasks","_i"];
      _tasks = _this select 0;
      {
        _x call SHK_Taskmaster_add;
      } foreach _tasks;
    };
  };
  publicvariable "SHK_Taskmaster_Tasks";
  if DEBUG then {
    diag_log "-- SHK_Taskmaster_Tasks --";
    diag_log SHK_Taskmaster_Tasks;
  };
  
};
/* == CLIENT =================================================================================== */
if !isdedicated then {
  SHK_Taskmaster_showHints = false;
  SHK_Taskmaster_TasksLocal = []; // Array member: ["TaskName","TaskState",TaskHandles]
  /*
    If any notes given in init.sqf, simply add them.
  */
  if (!isnil "_this") then {
    if (count _this > 1) then {
      private ["_notes","_i"];
      _notes = _this select 1;
      for [{_i=(count _notes - 1)},{_i>-1},{_i=_i-1}] do {
        (_notes select _i) call SHK_Taskmaster_addNote;
      };
    };
  };
  /*
    Initially wait for server to send the task list for briefing. After briefing is created, add
    an eventhandler to catch the updated task list server might send.
    
    Wait for briefing tasks to be created before enabling taskhints. This prevents hints from briefing tasks
    from being spammed at the start of the mission.
  */
  [] spawn {
    waituntil {!isnull player};
    waituntil {!isnil "SHK_Taskmaster_Tasks"};
    if DEBUG then {diag_log format ["SHK_Taskmaster> Tasks received first time: %1",SHK_Taskmaster_Tasks]};
    private "_sh";
    _sh = SHK_Taskmaster_Tasks spawn SHK_Taskmaster_handleEvent;
    waituntil {scriptdone _sh};
    
    SHK_Taskmaster_showHints = false;
    SHK_Taskmaster_initDone = true;

    "SHK_Taskmaster_Tasks" addpublicvariableeventhandler {
      (_this select 1) spawn SHK_Taskmaster_handleEvent;
    };
  };
};