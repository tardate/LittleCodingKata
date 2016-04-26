using System;
using Grpc.Core;
using Explainer;

namespace ExplainerClient
{
	class Program
	{
		public static void Main(string[] args)
		{
			// See https://github.com/grpc/grpc/issues/6116
			Grpc.Core.GrpcEnvironment.SetLogger(new Grpc.Core.Logging.NullLogger());

			Channel channel = new Channel("127.0.0.1:50051", ChannelCredentials.Insecure);

			var client = ShiFu.NewClient(channel);
			String problem = "help";

			if (args.Length > 0)
				problem = args [0];

			var reply = client.TellMeWhy(new ExplainerRequest { Problem = problem });
			Console.WriteLine(reply.Explanation);

			channel.ShutdownAsync().Wait();
		}
	}
}
