#include <stdio.h>

void iterate_null_terminated_string() {

  char message[] = "qwerty";  // implicitly null-terminated
  char* character_pointer = message;

  printf("iterate_null_terminated_string: %s\n", message);
  printf("result: ");

  while (*character_pointer) {
    printf("%c", *character_pointer);
    ++character_pointer;
  }
  printf("\n");

}

void iterate_char_array() {

  char message[] = {'q', 'w', 'e', 'r', 't', 'y'}; // not null terminated

  printf("iterate_char_array: %.*s\n", (int)sizeof(message), message);
  printf("result: ");

  for(int i=0; i < sizeof(message)/sizeof(message[0]); ++i) {
    printf("%c", message[i]);
  }
  printf("\n");

}

int main(){
  iterate_null_terminated_string();
  iterate_char_array();
}
