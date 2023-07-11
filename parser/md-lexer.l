%option noyywrap
%option nounput
%option noinput
%x ESCAPE CODE_SPAN CODE_BLOCK
%{
    #include <stdio.h>
    #include "y.tab.h"

    int code_delim_len;
%}
%%

\\                            {BEGIN(ESCAPE); return CHAR;}
<ESCAPE>\n|.                  {BEGIN(INITIAL); yylval=strdup(yytext); return CHAR;}

`+                            {code_delim_len = yyleng; BEGIN(CODE_SPAN); return CODE_SPAN_OPEN;}
<CODE_SPAN>`+                 {if (yyleng == code_delim_len) {BEGIN(INITIAL); return CODE_SPAN_CLOSE;} else {yylval=strdup(yytext); return CHAR;}}

^([ ]{4,})|\t+                {BEGIN(CODE_BLOCK); return CODE_BLOCK_OPEN;}
<CODE_BLOCK>\n[ \t]*\n        {BEGIN(INITIAL); return CODE_BLOCK_CLOSE;}
<CODE_SPAN,CODE_BLOCK>\n|.    {yylval=strdup(yytext); return CHAR;}

\[\[                          {return WIKI_OPEN;}
]]                            {return WIKI_CLOSE;}
\n|.                          {yylval=strdup(yytext); return CHAR;} 

%%
