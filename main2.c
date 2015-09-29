#include <stdio.h>

int _calc_sum(int) __attribute__((cdecl));

int main(void) {
    int n, sum;

    printf("Sum integers up to: ");
    scanf("%d", &n);
    sum = _calc_sum(n);
    printf("Sum is %d\n", sum);

    return 0;
}
