require 'socket'
require 'drb/drb'
require 'monitor'
require 'singleton'
require 'thread'

module DRb
  module DRbUDPSocket
    class StrStream
      def initialize(str='')
	@buf = str
      end
      attr_reader :buf

      def read(n)
	begin
	  return @buf[0,n]
	ensure
	  @buf[0,n] = ''
	end
      end

      def write(s)
	@buf.concat s
      end
    end

    private
    def self.parse_uri(uri)
      if uri =~ /^drbudp:\/\/(.*?):(\d+)(.*)$/
	host = $1
	port = $2.to_i
	option = $3
	[host, port, option]
      else
	raise(DRbBadScheme, uri) unless uri =~ /^drbudp:/
	raise(DRbBadURI, 'can\'t parse uri:' + uri)
      end
    end

    public
    def self.open(uri, config)
      host, port, option = parse_uri(uri)
      ClientSide.new(host, port, config)
    end
    
    def self.open_server(uri, config)
      host, port, option = parse_uri(uri)
      Server.new(host, port, config)
    end

    def self.uri_option(uri, config)
      host, port, option = parse_uri(uri)
      return "drbudp://#{host}:#{port}", option
    end
    
    class ClientSide
      def initialize(host, port, config)
	@host = host
	@port = port
	@config = config
	@msg = DRbMessage.new(config)
	@ep = NoNameEndPoint.instance
	@ep.start
      end
      
      def close; end
      def alive?; false; end
      
      def send_request(ref, msg_id, *arg, &b)
	stream = StrStream.new
	@msg.send_request(stream, ref, msg_id, *arg, &b)
	@reply_stream = StrStream.new
	@key = @ep.request(@host, @port, stream.buf)
      end
      
      def recv_reply
	buf = @ep.recv(@key)
	@msg.recv_reply(StrStream.new(buf))
      end
    end

    class Server
      def initialize(host, port, config)
	@config = config
	host = nil if host.size == 0
	@ep = EndPoint.new(host, port, config[:load_limit] || 10240)
	@ep.start
	host = Socket.gethostname unless host
	port = @ep.port
	@uri = "drbudp://#{host}:#{port}"
      end
      attr_reader :uri

      def close
	@ep.close if @ep
	@ep = nil
      end

      def accept
	ServerSide.new(@ep, @uri, @config)
      end
    end

    class ServerSide
      def initialize(ep, uri, config)
	@ep = ep
	@config = config
	@buf, @addr, @key = @ep.accept
	@msg = DRbMessage.new(@config)
      end

      def close
	@ep = nil
      end

      def recv_request
	# recv_from_ep unless @buf
	@msg.recv_request(StrStream.new(@buf))
      rescue
	# close
	raise $!
      ensure
	@buf = nil
      end
      
      def send_reply(succ, result)
	return unless @ep
	return unless @addr
	return unless @key
	stream = StrStream.new
	@msg.send_reply(stream, succ, result)
	@ep.reply(@addr[3], @addr[1], @key, stream.buf)
	@addr, @key = nil
      rescue
	close
	raise $!
      end

      def peeraddr
	@addr
      end
    end
    
    class EndPoint
      include MonitorMixin
      def initialize(host, port, packet_size=10240)
	super()
	@packet_size = packet_size
	@socket = UDPSocket.open
	if defined? Fcntl::FD_CLOEXEC
	  @socket.fcntl(Fcntl::F_SETFL, Fcntl::FD_CLOEXEC) 
	end
	@socket.bind(host, port)
	@port = @socket.addr[1]
	@key = 1
	@wait = {}
	@chan = {}
	@thread = nil
	@listen = Queue.new
      end
      attr_reader :socket, :port
      attr_accessor :packet_size

      def start
	synchronize do
	  @thread = make_reader unless @thread
	end
      end

      def close
	@socket.close if @socket
	@socket = nil
      end

      def request(host, port, buf)
	key = make_key
	@socket.send('Q' + [key].pack('N') + buf, 0, host, port)
	return key
      end

      def recv(key)
	data, addr, key = pop(key)
	return data
      end

      def reply(host, port, key, buf)
	@socket.send('A' + [key].pack('N') + buf, 0, host, port)
      end
      
      def accept
	pop(0)
      end
      
      private
      def make_key
	synchronize do
	  @key = (@key + 1) % 0x100000000
	  return @key
	end
      end

      def pop(key)
	if key == 0
	  return @listen.pop
	end
	while true
	  Thread.exclusive do 
	    @chan[key] ||= []
	    if @chan[key].size > 0
	      @wait[key] = nil
	      return @chan[key].shift 
	    end
	    @wait[key] = Thread.current
	    Thread.stop
	  end
	end
      end
      
      def push(key, tuple)
	if key == 0
	  @listen.push(tuple)
	  return
	end
	Thread.exclusive do
	  @chan[key] ||= []
	  @chan[key].push(tuple)
	  @wait[key].wakeup if @wait[key]
	  @wait[key] = nil
	end
      end

      def shift_head(buf)
	return nil, nil unless buf.size >= 5
	c = buf[0]
	n = buf[1,4]
	return nil unless n.size == 4
	return c, n.unpack('N')[0]
      ensure
	buf[0,5] = ''
      end
      
      def make_reader
	Thread.new do
	  while true
	    data, addr = @socket.recvfrom(@packet_size)
	    cmd, key = shift_head(data)
	    next unless key
	    if cmd == ?Q
	      push(0, [data, addr, key])
	    elsif cmd == ?A
	      push(key, [data, addr, key])
	    end
	  end
	end
      end
    end

    class NoNameEndPoint < EndPoint
      include Singleton
      def initialize
	super(nil, 0)
      end
    end
  end

  DRbProtocol.add_protocol(DRbUDPSocket)
end

if __FILE__ == $0
  def foo(e, port)
    sleep 2
    200.times do |n|
      key = e.request("localhost", port, "hello" + n.to_s)
      data = e.recv(key)
      if data == "hello#{n}" * 2
	puts n
      else
	exit
      end
    end
  end

  e = DRb::DRbUDPSocket::NoNameEndPoint.instance
  e.start
  puts e.port

  if port = ARGV.shift
    port = port.to_i
    t1 = Thread.new { foo(e, port) }
    t2 = Thread.new { foo(e, port) }
    t3 = Thread.new { foo(e, port) }
    t1.join
    t2.join
    t3.join
  else
    while true
      buf, addr, key = e.accept
      e.reply(addr[3], addr[1], key, buf + buf)
    end
  end
end
