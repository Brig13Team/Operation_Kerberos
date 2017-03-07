"extdb3" callExtension "9:RESET";
"extdb3" callExtension "9:ADD_DATABASE:KerberosDB";
"extdb3" callExtension "9:ADD_DATABASE_PROTOCOL:KerberosDB:SQL_CUSTOM:dorb:kerberos.ini";
"extdb3" callExtension "0:dorb:destructTablePlayers";
"extdb3" callExtension "0:dorb:constructTablePlayers";
"extdb3" callExtension "0:dorb:testplayers"
