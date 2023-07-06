#include <stdio.h>

void foo(char *x) {
	printf("x: %s\n", x);
}

void xbar(char *x) {
	foo(x);
}
