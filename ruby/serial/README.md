# #xxx Serial Communications with Ruby

Options for serial communications in Ruby as they stand in mid-2025.

## Notes

In the past I'd been accustomed to using the old
[serialport](https://rubygems.org/gems/serialport)
gem for serial communications.

It has since fallen into a bit of disrepair:
failing to keep up with [ruby changes](https://github.com/hparra/ruby-serialport/issues/69),
macOS compatibility,
and looking for a [new maintainer](https://github.com/hparra/ruby-serialport/discussions/77).

The following notes take some alternatives for a test drive, and also look at getting
[serialport](https://rubygems.org/gems/serialport) working again.

TLDR:

* prefer the [uart](https://rubygems.org/gems/uart)
* use the [serialport fork](https://github.com/hparra/ruby-serialport/pull/79) if serial port signal control is required

## The serialport gem - older but still widely used

The current released version of the
[serialport](https://rubygems.org/gems/serialport)
gem does not install on my macOS 15.5 on Apple Silicon with Ruby 3.3.3.
Then native extensions cannot compile - see for example [gem_make.out.txt](./serialport_example/gem_make.out.txt).

There is an update that addressed these issues, made by
[larskanis](https://github.com/larskanis/ruby-serialport/tree/update)
but [not yet released](https://github.com/hparra/ruby-serialport/pull/79).
This is the version I am using, as specified in the [Gemfile](./serialport_example/Gemfile).

Key aspects of the serialport gem:

* inherits from the [IO](https://rubydoc.info/stdlib/core/IO) class, and implements the corresponding input/output stream handling methods
    * read/write in binary or character mode
    * read/write text by character, line, or multiple lines
* provides access to all serial port signals:
    * read: DCD, DSR, RI
    * read/write: DTR, RTS

## The rubyserial gem - recommended for simplicity and modern Ruby

The [rubyserial](https://rubygems.org/gems/rubyserial) is a more portable library,
it does not require any native compilation thanks to using using [Ruby-FFI](https://github.com/ffi/ffi/wiki).

Key aspects of the rubyserial gem:

* very simple interface
* all read/write calls are blocking
* does not directly support timeouts
* no access or control over serial port signals

Because of these limitations, in most cases it is probably important to have predictable termination indicators in the incoming data,
and probably run the blocking call in a separate thread (with timeout).

## The uart gem - even cleaner

Aaron Patterson developed a pure Ruby alternative:
[uart](https://rubygems.org/gems/uart).

Key aspects of the uart gem:

* No C code
* No FFI code
* 5 second timeout by default

## Testing

I have an Arduino running a simple
[SerialControl](https://leap.tardate.com/playground/serialcontrol/)
sketch, attached to my mac and showing up as a device as follows:

```sh
$ ls -1 /dev/*serial*
/dev/cu.usbserial-2430
/dev/cu.wchusbserial2430
/dev/tty.usbserial-2430
/dev/tty.wchusbserial2430
```

### Testing the serialport gem

Taking a very basic approach to send a command and read the response:

```ruby
require 'serialport'
...
socket = SerialPort.new(port_name, 'baud' => baud_rate, 'data_bits' => 8, 'stop_bits' => 1, 'parity' => SerialPort::NONE)
socket.timeout = 1
socket.write "#{command}\r\n"
begin
  data = socket.gets rescue nil
  puts data if data
end while data
```

See [serialport_example/example.rb](./serialport_example/example.rb):

```sh
$ cd serialport_example
$ bundle exec example.rb /dev/cu.wchusbserial2430 s32
# SerialPort demonstration
# client initialised for : /dev/cu.wchusbserial2430
#     connection options : {"baud"=>115200, "data_bits"=>8, "stop_bits"=>1, "parity"=>0}
#                signals : {"rts"=>1, "dtr"=>1, "cts"=>1, "dsr"=>1, "dcd"=>1, "ri"=>1}
Random String with length=32:
kPJnkGR7Q0B0MwbPNRB7BJI6dqpRz1gl
$
```

### Testing the rubyserial gem

Taking a very basic approach to send a command and read the response:

```ruby
require 'rubyserial'
...
socket = Serial.new(port_name, baud_rate, 8, :none, 1)
socket.write "#{command}\r\n"
begin
  data = socket.gets
  puts data unless data.chomp.empty?
end until data.chomp.empty?
socket.close
```

See [rubyserial_example/example.rb](./rubyserial_example/example.rb):

```sh
$ cd rubyserial_example
$ bundle exec example.rb /dev/cu.wchusbserial2430 i
# RubySerial demonstration
# client initialised for : /dev/cu.wchusbserial2430
Random Integer:
45
$
```

### Testing the uart gem

Taking a very basic approach to send a command and read the response:

```ruby
require 'uart'
...
UART.open port_name, baud_rate, '8N1' do |socket|
  socket.write "#{command}\r\n"
  begin
    data = socket.gets
    puts data unless data.chomp.empty?
  end until data.chomp.empty?
end
```

See [uart_example/example.rb](./uart_example/example.rb):

```sh
$ cd uart_example
$ bundle exec example.rb /dev/cu.wchusbserial2430 s28
# UART demonstration
# client initialised for : /dev/cu.wchusbserial2430
Random String with length=28:
sDClAyQ67Rr71R83pEVYSS5RyWOL
$ bundle exec example.rb /dev/cu.wchusbserial2430 t
# UART demonstration
# client initialised for : /dev/cu.wchusbserial2430
LED on pin 13: turning LED ON
$
```

## Credits and References

* serialport gem
    * [rubygems](https://rubygems.org/gems/serialport)
    * [documentation](https://www.rubydoc.info/gems/serialport/1.3.2)
    * [source](https://github.com/hparra/ruby-serialport/)
    * working update: <https://github.com/larskanis/ruby-serialport/tree/update>
* rubyserial gem
    * [rubygems](https://rubygems.org/gems/rubyserial)
    * [documentation](https://www.rubydoc.info/gems/rubyserial/0.6.0)
    * [source](https://github.com/hybridgroup/rubyserial)
* uart gem
    * [rubygems](https://rubygems.org/gems/uart)
    * [documentation](https://www.rubydoc.info/gems/uart/1.0.0)
    * [source](https://github.com/tenderlove/uart)
