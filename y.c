#include <stdio.h>

void foo(char *x) {
	printf("y: %s\n", x);
}

void ybar(char *x) {
	foo(x);
}
