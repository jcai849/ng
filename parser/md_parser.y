/* not going to support reference-style links or implicit names yet  */
%token CONTENT
%token OPEN_TASKBOX CLOSED_TASKBOX
%token LEFT_WIKI_PAREN RIGHT_WIKI_PAREN ANCHOR_CENTRE URL
%token CODE_BLOCK_START CODE_BLOCK_END

%start document
%%

document:
    text
;
text:
    CONTENT
    | text special
;
special:
    link
    | verbatim
    | task
;

link:
    img
    | wikilink
    | anchor
    | auto_link
;
wikilink:
    LEFT_WIKI_PAREN anchor_text RIGHT_WIKI_PAREN
    | LEFT_WIKI_PAREN anchor_text '|' alias RIGHT_WIKI_PAREN
;
img:
    '!' anchor
;
anchor:
    '[' anchor_text ANCHOR_CENTRE href ')'
;
auto_link:
    '<' href '>'
;
href:
    URL
    | URL '"' title '"'
;
anchor_text:
    SENTENCE
    | verbatim
    | anchor_text sentence.opt
sentence.opt: | SENTENCE

verbatim:
    code_span
    | code_block
;
code_span:
    '`' code '`'
;
code_block:
    CODE_BLOCK_START code CODE_BLOCK_END
;

/* allow for a variety of fillers for the taskboxes in the lexer, e.g. x,.,o,O, etc. */
task:
    OPEN_TASKBOX task_text
    | CLOSED_TASKBOX task_text
;

%%