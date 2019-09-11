#include <stdio.h>
#include "dict.h"

int main() {
    dictionary *d = dictionary_new();

    int value1 = 1;
    float value2 = 2.0;
    char value3[] = "three";

    dictionary_add(d, "key1", &value1);
    dictionary_add(d, "key2", &value2);
    dictionary_add(d, "key3", &value3);

    char *result;

    result = dictionary_find(d, "key1");
    printf("Finding: 'key1' (int)    .. found: %i\n", *(int*)result);

    result = dictionary_find(d, "key2");
    printf("Finding: 'key2' (float)  .. found: %f\n", *(float*)result);

    result = dictionary_find(d, "key3");
    printf("Finding: 'key3' (string) .. found: %s\n", result);

    printf("Finding: 'bogative'      .. ");
    result = dictionary_find(d, "bogative");
    if (result == dictionary_not_found) {
        printf("not found\n");
    } else {
        printf("found: %s\n", result);
    }

    dictionary_free(d);
}
