#include <stdio.h>

void f(int) __attribute__((cdecl));

int main(void) {
    int x;

    printf("x= ");
    scanf("%d", &x);
    f(x);

    return 0;
}
