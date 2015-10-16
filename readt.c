// use redirection to read from file
#include <stdio.h>

extern int read_double(FILE *, double *, int );
#define MAX 100

int main(void) {
    int i, n;
    double arr[MAX];

    n = read_doubles(stdin, arr, MAX);

    for (i = 0; i < n; i++)
        printf("%3d %g\n", i, a[i]);

    return 0;
}
