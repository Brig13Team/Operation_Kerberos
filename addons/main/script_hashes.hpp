/*
 *  Author: Dorbedo
 *
 *  Description:
 *      this is the hash-system
 *      Combines code from ACRE, CBA with own code to create a new system
 *
 *
 *      Prefixes:
 *          No Prefix - work everytime, specific functions prefer local hashes
 *          L - "local" hashes only, can break
 *          G - "global" hashes only, can break
 *          A - "any" hashes - some macros support not internal hashes for communication with other mods
 *
 */
//>>>>>> Internal >>>>>>//
#define DORB_HASH_POSITION [-2017,-1803,0]
#define DORB_HASH_TYPE "CBA_NamespaceDummy"
#define DORB_HASH_SYS_CREATE_LOCAL (createLocation [DORB_HASH_TYPE, DORB_HASH_POSITION, 0, 0])

#define DORB_HASH_POOL GVARMAIN(HASHPOOL)
#define DORB_HASH_TO_DELETE GVARMAIN(HASHTODELETE)
#define DORB_HASH_CREATED_NEW GVARMAIN(HASHCREATEDNEW)
#define DORB_HASH_CREATED GVARMAIN(HASHCREATED)

#define DORB_HASH_COLLECTOR_HANDLER GVAR(hashCollector_handler)
#define DORB_HASH_COLLECTOR_COLLECT GVAR(hashCollector_collect)
#define DORB_HASH_COLLECTOR_SEARCHTIME 0.001
#define DORB_HASH_COLLECTOR_NAMESPACES GVAR(hashCollector_namespaces)
#define DORB_HASH_COLLECTOR_NAMESPACES_ID GVAR(hashCollector_namespaces_ID)
#define DORB_HASH_COLLECTOR_VARIABLES GVAR(hashCollector_variables)
#define DORB_HASH_COLLECTOR_ARRAYS GVAR(hashCollector_arrays)
#define DORB_HASH_COLLECTOR_FOUND GVAR(hashCollector_found)
#define DORB_HASH_COLLECTOR_ID GVAR(hashCollector_ID)
#define DORB_HASH_COLLECTOR_IGNORE GVAR(hashCollector_ignore)

//<<<<<< Internal <<<<<<//

/* -------------------------------------------
Macro: HASH_CREATE
    Creates a new hash

Parameters:
    none

Example:
    _hash = HASH_CREATE;

Author:
    Dorbedo
------------------------------------------- */
#define HASH_CREATE (call EFUNC(main,hash_Lcreate))
#define LHASH_CREATE (call EFUNC(main,hash_Lcreate))
#define GHASH_CREATE (call EFUNC(main,hash_Gcreate))
#define AHASH_CREATE (call CBA_fnc_createNamespace)
/* -------------------------------------------
Macro: HASH_DELETE(hash)
    deletes a hash
    the hash is not deleted instant. it' possible to receive the values for a short timeperiod

Parameters:
    0 : HASH

Example:
    HASH_DELETE(_hash);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_DELETE(hash) ((DORB_HASH_TO_DELETE) pushBack hash)
#define LHASH_DELETE(hash) HASH_DELETE(hash)
#define GHASH_DELETE(hash) HASH_DELETE(hash)
#define AHASH_DELETE(hash) ([hash] call CBA_fnc_deleteNamespace)
/* -------------------------------------------
Macro: HASH_HASKEY(hash,key)
    checks if a hash has a defined key

Parameters:
    0 : HASH
    1 : STRING

Example:
    If !(HASH_HASKEY(_hash,"s")) then {....};

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_HASKEY(hash, key) (!(isNil {hash getVariable key}))
#define LHASH_HASKEY(hash, key) HASH_HASKEY(hash, key)
#define GHASH_HASKEY(hash, key) HASH_HASKEY(hash, key)
#define AHASH_HASKEY(hash, key) HASH_HASKEY(hash, key)
/* -------------------------------------------
Macro: HASH_SET(hash, key, val)
    sets a hash value

Parameters:
    0 : HASH
    1 : STRING
    2 : ANY

Example:
    HASH_SET(_hash, "status", 10);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_SET(hash, key, val) (hash setVariable [key, val])
#define LHASH_SET(hash, key, val) HASH_SET(hash, key, val)
#define GHASH_SET(hash, key, val) (hash setVariable [key, val, true])
#define AHASH_SET(hash, key, val) HASH_SET(hash, key, val)
/* -------------------------------------------
Macro: IS_HASH(hash)
    checks if a variable is a hash

Parameters:
    0 : HASH

Example:
    IS_HASH(_hash);

Author:
    Dorbedo
------------------------------------------- */
#define IS_HASH(hash) ((hash isEqualTypeAny [locationNull,objNull])&&{(position hash) isEqualTo DORB_HASH_POSITION})
#define IS_LHASH(hash) ((hash isEqualType locationNull)&&{(type hash) isEqualTo DORB_HASH_TYPE})
#define IS_GHASH(hash) ((hash isEqualType objNull)&&{(typeOf hash) isEqualTo DORB_HASH_TYPE})
#define IS_AHASH(hash) (((hash isEqualType locationNull)&&{(type hash) isEqualTo DORB_HASH_TYPE})||((hash isEqualType objNull)&&{(typeOf hash) isEqualTo DORB_HASH_TYPE})||((hash isEqualType locationNull)&&{(type hash) isEqualTo 'ACRE_FastHashNamespaceDummy'}))
/* -------------------------------------------
Macro: HASH_GET(hash, key)
    returns a value from a hash
    can return nil

Parameters:
    0 : HASH
    1 : STRING

Example:
    _value = HASH_GET(_hash, "key");

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_GET(hash, key) (hash getVariable key)
#define LHASH_GET(hash, key) HASH_GET(hash, key)
#define GHASH_GET(hash, key) HASH_GET(hash, key)
#define AHASH_GET(hash, key) HASH_GET(hash, key)
/* -------------------------------------------
Macro: HASH_GET_DEF(hash, key, default)
    returns a value from a hash
    use to define a default value, if the key has no value

Parameters:
    0 : HASH
    1 : STRING
    2 : ANY

Example:
    _hash = HASH_GET(_hash, "key", []);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_GET_DEF(hash, key, default) (hash getVariable [key,default])
#define LHASH_GET_DEF(hash, key, default) HASH_GET_DEF(hash, key, default)
#define GHASH_GET_DEF(hash, key, default) HASH_GET_DEF(hash, key, default)
#define AHASH_GET_DEF(hash, key, default) HASH_GET_DEF(hash, key, default)
/* -------------------------------------------
Macro: HASH_REM(hash, key)
    removes the key from a hash

Parameters:
    0 : HASH
    1 : STRING

Example:
    HASH_REM(_hash, "remove");

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_REM(hash, key) (hash setVariable [key, nil])
#define LHASH_REM(hash, key) HASH_REM(hash, key)
#define GHASH_REM(hash, key) (hash setVariable [key, nil, true])
#define AHASH_REM(hash, key) HASH_REM(hash, key)
/* -------------------------------------------
Macro: HASH_COPY(hash)
    copys a hash into a new one
    the prefix indicates the type of the new hash

Parameters:
    0 : HASH

Example:
    _newhash = HASH_COPY(_oldhash);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_COPY(hash) ([hash] call EFUNC(main,hash_Lcopy))
#define LHASH_COPY(hash) ([hash] call EFUNC(main,hash_Lcopy))
#define GHASH_COPY(hash) ([hash] call EFUNC(main,hash_Gcopy))
#define AHASH_COPY(hash) ([hash] call EFUNC(main,hash_Acopy))
/* -------------------------------------------
Macro: HASH_KEYS(hash)
    returns all keys from a hash

Parameters:
    0 : HASH

Example:
    _allKeys = HASH_KEYS(_hash);

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_KEYS(hash) ([hash] call EFUNC(main,hash_Keys))
#define LHASH_KEYS(hash) HASH_KEYS(hash)
#define GHASH_KEYS(hash) HASH_KEYS(hash)
#define AHASH_KEYS(hash) HASH_KEYS(hash)
/* -------------------------------------------
Macro: HASH_SERIALIZE(hash)

Parameters:
    0 : HASH

Example:
    _hash = HASH_CREATE;

Author:
    ACRE2-Team
------------------------------------------- */
#define HASH_SERIALIZE(HASH) ([HASH] call EFUNC(main,hash_serialize))
#define LHASH_SERIALIZE(HASH) ([HASH] call EFUNC(main,hash_serialize))
#define GHASH_SERIALIZE(HASH) ([HASH] call EFUNC(main,hash_serialize))
#define AHASH_SERIALIZE(HASH) ([HASH] call EFUNC(main,hash_serialize))
/* -------------------------------------------
Macro: IS_SERIALIZEDHASH(array)

Parameters:
    0 : ARRAY

Example:
    If (IS_SERIALIZEDHASH(_value)) then {...};

Author:
    ACRE2-Team
------------------------------------------- */
#define IS_SERIALIZEDHASH(array) (IS_ARRAY(array) && {(count array) > 0} && {IS_STRING((array select 0))} && {(array select 0) isEqualTo DORB_HASH_TYPE})
/* -------------------------------------------
Macro: HASH_DESERIALIZE(ARRAY)

Parameters:
    0 : ARRAY (serialized hash)

Example:
    _hash = HASH_DESERIALIZE(_array);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_DESERIALIZE(ARRAY) ([ARRAY] call EFUNC(main,hash_Ldeserialize))
#define LHASH_DESERIALIZE(ARRAY) ([ARRAY] call EFUNC(main,hash_Ldeserialize))
#define GHASH_DESERIALIZE(ARRAY) ([ARRAY] call EFUNC(main,hash_Gdeserialize))
#define AHASH_DESERIALIZE(ARRAY) ([ARRAY] call EFUNC(main,hash_Adeserialize))
/* -------------------------------------------
Macro: HASH_SIZE(HASH)
    returns the amount of keys in a hash

Parameters:
    0 : HASH

Example:
    _size = HASH_SIZE(_hash);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_SIZE(HASH) (count HASH_KEYS(HASH))
#define LHASH_SIZE(HASH) (count LHASH_KEYS(HASH))
#define GHASH_SIZE(HASH) (count GHASH_KEYS(HASH))
#define AHASH_SIZE(HASH) (count AHASH_KEYS(HASH))
/* -------------------------------------------
Macro: HASH_ISEMPTY(HASH)
    checks if a hash is empty

Parameters:
    0 : HASH

Example:
    IF (HASH_ISEMPTY(_hash)) then {};

Author:
    Dorbedo
------------------------------------------- */
#define HASH_ISEMPTY(HASH) ((count HASH_KEYS(HASH))<1)
#define LHASH_ISEMPTY(HASH) ((count LHASH_KEYS(HASH))<1)
#define GHASH_ISEMPTY(HASH) ((count GHASH_KEYS(HASH))<1)
#define AHASH_ISEMPTY(HASH) ((count AHASH_KEYS(HASH))<1)
/* -------------------------------------------
Macro: HASH_GETKEY(hash, value)
    returns a key of a hash, which contaions the same value
    returns nil if no hash is availible

Parameters:
    0 : HASH
    1 : ANY

Example:
    _key = HASH_GETKEY(_hash, 999.9)

Author:
    Dorbedo
------------------------------------------- */
#define HASH_GETKEY(HASH,VALUE) ([HASH,VALUE] call EFUNC(main,hash_GetKeyFromValue))
#define LHASH_GETKEY(HASH,VALUE) HASH_GETKEY(HASH,VALUE)
#define GHASH_GETKEY(HASH,VALUE) HASH_GETKEY(HASH,VALUE)
#define AHASH_GETKEY(HASH,VALUE) HASH_GETKEY(HASH,VALUE)
/* -------------------------------------------
Macro: HASH_HASVALUE(hash, value)
    checks if a hash has the provided value

Parameters:
    0 : HASH
    1 : ANY

Example:
    _key = HASH_HASVALUE(_hash, 999.9)

Author:
    Dorbedo
------------------------------------------- */
#define HASH_HASVALUE(HASH,VALUE) (!isNil{([HASH,VALUE] call EFUNC(main,hash_GetKeyFromValue))})
#define LHASH_HASVALUE(HASH,VALUE) HASH_HASVALUE(HASH,VALUE)
#define GHASH_HASVALUE(HASH,VALUE) HASH_HASVALUE(HASH,VALUE)
#define AHASH_HASVALUE(HASH,VALUE) HASH_HASVALUE(HASH,VALUE)
/* -------------------------------------------
Macro: HASH_MERGE(hash1, hash2)
    merges hash2 into hash1

Parameters:
    0 : HASH
    1 : HASH

Example:
    HASH_MERGE(_hash,_otherHash);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_MERGE(PRIMHASH,SECHASH) ([PRIMHASH,SECHASH] call EFUNC(main,hash_Lmerge))
#define LHASH_MERGE(PRIMHASH,SECHASH) ([PRIMHASH,SECHASH] call EFUNC(main,hash_Lmerge))
#define GHASH_MERGE(PRIMHASH,SECHASH) ([PRIMHASH,SECHASH] call EFUNC(main,hash_Gmerge))
#define AHASH_MERGE(PRIMHASH,SECHASH) ([PRIMHASH,SECHASH] call EFUNC(main,hash_Amerge))
/* -------------------------------------------
Macro: HASH_CLEAR(hash)
    clears all values of a hash

Parameters:
    0 : HASH

Example:
    HASH_CLEAR(_hash);

Author:
    Dorbedo
------------------------------------------- */
#define HASH_CLEAR(HASH) ({HASH setVariable [_x,nil];}forEach (allVariables HASH))
#define LHASH_CLEAR(HASH) HASH_CLEAR(HASH)
#define GHASH_CLEAR(HASH) ({HASH setVariable [_x,nil,true];}forEach (allVariables HASH))
#define AHASH_CLEAR(HASH) HASH_CLEAR(HASH)

#define HASHLIST_CREATELIST(keys) []
#define HASHLIST_CREATEHASH(hashList) HASH_CREATE
#define HASHLIST_SELECT(hashList, index) (hashList select index)
#define HASHLIST_SET(hashList, index, value) (hashList set[index, value])
#define HASHLIST_PUSH(hashList, value) (hashList pushBack value)
