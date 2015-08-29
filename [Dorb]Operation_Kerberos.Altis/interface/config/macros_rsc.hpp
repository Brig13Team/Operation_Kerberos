#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1
#define CSTRING(var1) QUOTE(TRIPLES($STR,dorb_interface,var1))
#define ECSTRING(var1,var2) QUOTE(TRIPLES($STR,DOUBLES(dorb,var1),var2))