#include <stdio.h>
#include <C_CkJsonObject.h>

void PrettyPrintJSON(void)
    {
    BOOL success;
    HCkJsonObject json;
    const char *jsonStr;

    success = FALSE;

    json = CkJsonObject_Create();

    jsonStr = "{\"name\": \"donut\",\"image\":{\"fname\": \"donut.jpg\",\"w\": 200,\"h\": 200},\"thumbnail\":{\"fname\": \"donutThumb.jpg\",\"w\": 32,\"h\": 32}}";

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

int main(void) {
    PrettyPrintJSON();
    return 0;
}
