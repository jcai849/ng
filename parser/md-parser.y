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

    char TEXTBUF[1000];
    int TEXTBUF_i;
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
      %empty {TEXTBUF_i = 0;
              TEXTBUF[TEXTBUF_i] = '\0';
              $$ = TEXTBUF;}
    | text CHAR {
        TEXTBUF[TEXTBUF_i] = $2;
        TEXTBUF_i += 1;
        TEXTBUF[TEXTBUF_i] = '\0'; }
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