// client
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#include <zmq.h>

int main(void) {

  printf("Connecting to the server on tcp:5555...\n");

  void *context = zmq_ctx_new();
  void *requester = zmq_socket(context, ZMQ_REQ);
  int rc = zmq_connect(requester, "tcp://localhost:5555");
  assert(rc == 0);

  for (int count = 0; count < 10; ++count) {
    char request_buffer[10];
    sprintf(request_buffer, "REQ #%d", count);
    int request_bytes = strlen(request_buffer);
    printf("Sending '%s', strlen=%d ...\n", request_buffer, request_bytes);
    zmq_send(requester, request_buffer, request_bytes, 0);

    char reply_buffer[20] = {0};
    int recv_size = zmq_recv(requester, reply_buffer, 20, 0);
    printf("Received reply #%d: '%s', recv_size: %d, strlen: %lu\n", count, reply_buffer, recv_size, strlen(reply_buffer));
    sleep(1);
  }

  zmq_close(requester);
  zmq_ctx_destroy(context);
}
