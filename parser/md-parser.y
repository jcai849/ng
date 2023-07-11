%define parse.trace
%define api.value.type {char *}
%printer { fprintf (yyo, "\"%s\"", $$); } <>
%token WIKI_OPEN WIKI_CLOSE CHAR CODE_BLOCK_OPEN CODE_BLOCK_CLOSE CODE_SPAN_OPEN CODE_SPAN_CLOSE
%{
    #include <stdio.h>
    #include <string.h>
    
    int yylex(void);
    void yyerror (char const *s) {
        fprintf (stderr, "%s\n", s);
    }
%}
%%

document: %empty 
    | document CHAR
    | document link
    | document verbatim
;

verbatim:
      CODE_BLOCK_OPEN text CODE_BLOCK_CLOSE {printf("code block: \"%s\"\n", $2);}
    | CODE_SPAN_OPEN text CODE_SPAN_CLOSE {printf("code span: \"%s\"\n", $2);}
;

text:
      %empty {char *empty = (char *) malloc(strlen("")+1);
              $$ = empty = "";}
    | text CHAR {char *str = (char*) malloc(strlen($1) + strlen($2) + 1);
                 strcpy(str, $1);
                 strcat(str, $2);
                 $$ = str;}
;

link:
    WIKI_OPEN text WIKI_CLOSE {printf("link: \"%s\"\n", $2);}
;

%%

int main(int argc, char *argv[]) {
    /* Enable parse traces on option -p. */
    if (argc == 2 && strcmp(argv[1], "-p") == 0)
        yydebug = 1;
    yyparse();
    return 0;
}