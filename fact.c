#include <stdio.h>

int _fact(int) __attribute__((cdecl));

int main(void) {
    int n, res;

    printf("Calculate factorial of: ");
    scanf("%d", &n);
    res = _fact(n);
    printf("Result: %d\n", res);

    return 0;
}
