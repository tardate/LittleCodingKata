var PROTO_PATH = __dirname + '/../protocols/explainer.proto';

var grpc = require('grpc');
var explainer_proto = grpc.load(PROTO_PATH).explainer;

function main() {
  var client = new explainer_proto.ShiFu('localhost:50051', grpc.credentials.createInsecure());
  var problem = 'help';
  if (process.argv.length >= 3) {
    problem = process.argv[2];
  }
  client.tellMeWhy({problem: problem}, function(err, response) {
    console.log(response.explanation);
  });
}

main();
