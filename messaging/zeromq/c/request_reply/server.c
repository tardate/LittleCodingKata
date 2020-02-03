// server
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <zmq.h>

int main(void) {

  printf("Server listening for connections on tcp:5555...\n");

  void *context = zmq_ctx_new();
  void *responder = zmq_socket(context, ZMQ_REP);
  int rc = zmq_bind(responder, "tcp://*:5555");
  assert(rc == 0);

  while (1) {
    char request_buffer[10] = {0};
    int recv_size = zmq_recv(responder, request_buffer, 10, 0);
    printf("Received request msg: '%s', recv_size: %d, strlen: %lu\n", request_buffer, recv_size, strlen(request_buffer));

    char reply_buffer[20];
    sprintf(reply_buffer, "REP to %s", request_buffer);
    int repl_bytes = strlen(reply_buffer);
    printf("Replying with msg: '%s', strlen: %d\n", reply_buffer, repl_bytes);
    zmq_send(responder, reply_buffer, repl_bytes, 0);
  }
}
