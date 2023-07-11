FILETYPE= md
PROGRAM = parse-${FILETYPE}
LEX     = flex
YACC    = bison
YFLAGS  = -d -o y.tab.c -t -Wall -Wcounterexamples --report=itemset --graph -x
CFLAGS = -Wall -Wextra -Werror -g
.PHONY: clean test all
.SUFFIXES: .gv .svg .xml .html

.gv.svg:
	dot -Tsvg ${.IMPSRC} >${.TARGET}
.xml.html:
	xsltproc `bison --print-datadir`/xslt/xml2xhtml.xsl ${.IMPSRC} >${.TARGET}

all: ${PROGRAM} y.svg y.html

y.html y.svg: ${PROGRAM}

${PROGRAM}: ${FILETYPE}-parser.o ${FILETYPE}-lexer.o
	${LINK.c} ${CFLAGS} ${LDFLAGS} -o ${.TARGET} ${.ALLSRC}

test: ${PROGRAM}
	./${PROGRAM} <test.md

clean:
	rm -f ${PROGRAM}
	rm -f *.o
	rm -f *.output
	rm -f y.tab.h
	rm -f *.svg
	rm -f *.gv
	rm -f *.xml
	rm -f *.html
	rm -f md-parser.c