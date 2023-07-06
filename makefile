.PHONY: clean
.SUFFIXES: .c .o .a .gv .svg

a: libxy.a a.c
	$(CC) -o $@ a.c -L. -lxy

libxy.a: x.o y.o
	$(AR) q $@ $>

.c.o:
	${COMPILE.c} $<
	objcopy -Lfoo $@

clean:
	rm -f *.a
	rm -f *.o
	rm -f *.svg

.gv.svg:
	dot -Tsvg $< >$@