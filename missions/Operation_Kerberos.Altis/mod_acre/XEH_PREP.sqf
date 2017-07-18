#include "script_component.hpp"

PREP(getSignal);

PREPS(antenna,addChildActions);
PREPS(antenna,canConnect);
PREPS(antenna,canDisconnect);
PREPS(antenna,connect);
PREPS(antenna,disconnect);
PREPS(antenna,handler);

PREPS(babbel,addLanguageLocal);
PREPS(babbel,canAddLanguage);
PREPS(babbel,removeLanguageLocal);

PREPS(jammer,add);
PREPS(jammer,getSignalOutput);
PREPS(jammer,getArray);
PREPS(jammer,getSignal);
PREPS(jammer,getSignalSimple);
PREPS(jammer,handleReturn);
PREPS(jammer,isActive);
PREPS(jammer,remoteStopSpeaking);
PREPS(jammer,remove);
PREPS(jammer,selectBest);
