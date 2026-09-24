#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[100] = "Hello";
    char str2[] = " Operating Systems";

    printf("Length of str1: %d\n", mystrlen(str1));
    mystrcat(str1, str2);
    printf("Concatenated string: %s\n", str1);

    printf("\n--- Testing File Functions ---\n");
    FILE* file = fopen("README.md", "r");
    if (file) {
        int lines, words, chars;
        if (wordCount(file, &lines, &words, &chars) == 0) {
            printf("README.md stats -> Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
        }
        
        // Rewind file pointer to test mygrep on the same file
        fseek(file, 0, SEEK_SET);
        char** matches = NULL;
        int count = mygrep(file, "OS", &matches);
        printf("mygrep found %d line(s) containing 'OS':\n", count);
        for (int i = 0; i < count; i++) {
            printf("  [%d] %s", i + 1, matches[i]);
            free(matches[i]); // Clean up allocated line memory
        }
        free(matches); // Clean up array pointer
        
        fclose(file);
    } else {
        printf("Could not open README.md for testing.\n");
    }

    return 0;
}
