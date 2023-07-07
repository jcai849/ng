%{
#include "y.tab.h"    
%}
%%
^[ \t]*- \[[ \.]]     return OPEN_TASKBOX; 
^[ \t]- \[[XxoO]]     return CLOSED_TASKBOX; 
\[\[                  return LEFT_WIKI_PAREN;
]]                    return LEFT_WIKI_PAREN;
]\(                   return ANCHOR_CENTRE;
(https?://)?([:alnum:]+\.)?[:alnum:]+(\.[:alnum:]+)+    return URL;
^```                  return CODE_BLOCK_START;
^```[ \t]*            return CODE_BLOCK_END;
.                     return yytext[0];