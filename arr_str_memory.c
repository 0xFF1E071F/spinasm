#include <stdio.h>

#define STR_SIZE 30

void asm_copy(void *, const void *, unsigned) __attribute__((cdecl));
void *asm_find(const void *, char target, unsigned) __attribute((cdecl));
unsigned asm_strlen(const char *) __attribute__((cdecl));
void asm_strcpy(char *, const char *) __attribute__((cdecl));

int main() {
    char str1[STR_SIZE] = "test string";
    char str2[STR_SIZE];
    char *strp;
    char ch;

    asm_copy(str2, str1, STR_SIZE);
    printf("%s\n", str2);

    printf("Enter a char: ");
    scanf("%c%*[^\n]", &ch);
    strp = asm_find(str2, ch, STR_SIZE);
    if (strp)
        printf("Found: %s\n", strp);
    else
        printf("Not found\n");

    str1[0] = 0;
    printf("Enter string: ");
    scanf("%s", str1);
    printf("len = %u\n", asm_strlen(str1));

    asm_strcpy(str2, str1);
    printf("%s\n", str2);

    return 0;
}
