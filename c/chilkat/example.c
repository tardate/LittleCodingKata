#include <stdlib.h>
#include <stdio.h>
#include <C_CkJsonObject.h>

void PrettyPrintJSON(const char *jsonStr) {
  BOOL success;
  HCkJsonObject json;

  success = FALSE;

  json = CkJsonObject_Create();

  success = CkJsonObject_Load(json,jsonStr);
  if (success != TRUE) {
    printf("%s\n",CkJsonObject_lastErrorText(json));
    CkJsonObject_Dispose(json);
    return;
  }

  // To pretty-print, set the EmitCompact property equal to FALSE
  CkJsonObject_putEmitCompact(json,FALSE);

  // If bare-LF line endings are desired, turn off EmitCrLf
  // Otherwise CRLF line endings are emitted.
  CkJsonObject_putEmitCrLf(json,FALSE);

  // Emit the formatted JSON:
  printf("%s\n",CkJsonObject_emit(json));

  CkJsonObject_Dispose(json);
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
    return 1;
  }

  FILE *file = fopen(argv[1], "r");
  if (file == NULL) {
    fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
    return 1;
  }

  fseek(file, 0, SEEK_END);
  long filesize = ftell(file);
  fseek(file, 0, SEEK_SET);

  char *jsonStr = (char *)malloc(filesize + 1);
  fread(jsonStr, 1, filesize, file);
  jsonStr[filesize] = '\0';
  fclose(file);

  PrettyPrintJSON(jsonStr);
  return 0;
}
