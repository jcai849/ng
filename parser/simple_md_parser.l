%option noyywrap
%option stack
%x WIKI ESCAPE CODE_SPAN CODE_BLOCK
%{
#include "yy.tab.h"

int code_delim_len;
%}
%%

<INITIAL,WIKI>\\              {yy_push_state(ESCAPE); return CHAR};
<ESCAPE>\n|.                  {yy_pop_state(); return CHAR};

<INITIAL,WIKI>`+              {code_delim_len=yyleng;yy_push_state(CODE_SPAN); return CODE_SPAN_OPEN;}
<CODE_SPAN>`+                 {if (yyleng==code_delim_len) yy_pop_state(); return CODE_SPAN_CLOSE;}

^([ ]{4,})|\t+                {BEGIN(CODE_BLOCK); return CODE_BLOCK_OPEN;}
<CODE_BLOCK>\n[ \t]*\n        {BEGIN(INITIAL); return CODE_BLOCK_CLOSE;}
<CODE_SPAN,CODE_BLOCK>\n|.    {return CHAR;}

\[\[                          {BEGIN(WIKI); return WIKI_OPEN;}
<WIKI>]]                      {BEGIN(INITIAL); return WIKI_CLOSE;}
<WIKI>\[\[                    {return WIKI_OPEN;}
<WIKI>\n                      {BEGIN(INITIAL); return CHAR}
<WIKI>.                       {return CHAR}
\n|.                          {return CHAR} 

%%
int main() {
    yylex();
}