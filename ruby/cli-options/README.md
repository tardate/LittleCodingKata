# #370 Command Line Options with Ruby

Comparing all the various ways of parsing command line arguments with the Ruby standard library.

## Notes

Building tools with ruby that run in a terminal generally requires handling command-line options and arguments.
See also: [The Ruby Way](../the-ruby-way/) 14.2 Command-Line Options and Arguments.

There are a range of gems that offer improved or simplified CLI options handling,
but I'll just focus here on what is already provided by the rich standard library support.

What I'll cover here:

* [ARGV & ARGF](https://ruby-doc.org/3.4.1/ARGF.html) - raw arguments
* [GetoptLong](https://ruby-doc.org/3.4.1/gems/getoptlong/GetoptLong.html) - fashioned after the GNU getopt_long() C library
* [OptionParser](https://ruby-doc.org/3.4.1/stdlibs/optparse/OptionParser.html) - more advanced and "Ruby-oriented" than GetoptLong

NB: a few examples of third-party gems include:

* <https://rubygems.org/gems/getopt> - The getopt library provides two different command line option parsers. They are meant as easier and more convenient replacements for the command line parsers that ship as part of the Ruby standard library
* <https://rubygems.org/gems/optparse-plus> - provides a lot of small but useful features for developing a command-line app
* <https://rubygems.org/gems/cli-modular_options> - facilitates modular application design by allowing you to declare CLI options in the context of a class or module and consume them in the context of an object instance using conventional ruby inheritance semantics
* <https://rubygems.org/gems/mixlib-cli> - A simple mixin for CLI interfaces, including option parsing
* <https://rubygems.org/gems/gli> - Build command-suite CLI apps that are awesome. Bootstrap your app, add commands, options and documentation while maintaining a well-tested idiomatic command-line app

### ARGV & ARGF

If one just needs to grab 1 or 2 arguments without anything fancy,
the ARGV global variable and ARGF class is all we really need. See [ARGV & ARGF](https://ruby-doc.org/3.4.1/ARGF.html) for library details.

Where this approach starts to fall down is when adding more than one optional parameter, or we have so many options that keeping the help/doc in line with the code starts to become a pain.

The ARGV global variable provides access to an array of options for us to do with as we wish.

See [argv_example.rb](./argv_example.rb) for a demonstration:

```ruby
p ['ARGV', ARGV]
ARGV.each do |arg|
  case arg
  when '--help', '-h'
    puts 'Help: This is a simple example of using ARGV to handle command-line options.'
    puts 'Usage: ruby argv_example.rb [options]'
    puts 'Options:'
    puts '  --help, -h     Show this help message'
    puts '  --version, -v  Show version information'
    exit
  when '--version', '-v'
    puts 'Version 1.0.0'
    exit
  else
    puts "Unknown option: #{arg}"
  end
end
```

Example usage:

```sh
$ ./argv_example.rb --help
["ARGV", ["--help"]]
Help: This is a simple example of using ARGV to handle command-line options.
Usage: ruby argv_example.rb [options]
Options:
  --help, -h     Show this help message
  --version, -v  Show version information
$ ./argv_example.rb -v
["ARGV", ["-v"]]
Version 1.0.0
```

The [ARGF](https://ruby-doc.org/3.4.1/ARGF.html) class works with the array at global variable ARGV to make $stdin and file streams available in the Ruby program.

See [argf_example.rb](./argf_example.rb) for a demonstration:

```ruby
p ['ARGV', ARGV]
p ['ARGF.read', ARGF.read]
```

Example usage:

```sh
$ echo "Open the pod bay doors, Hal." | ./argf_example.rb
["ARGV", []]
["ARGF.read", "Open the pod bay doors, Hal.\n"]
$ ./argf_example.rb foo.txt bar.txt
["ARGV", ["foo.txt", "bar.txt"]]
["ARGF.read", "Foo 0\nFoo 1\nBar 0\nBar 1\nBar 2\nBar 3\n"]
```

### GetoptLong (part of Ruby's standard library)

This class is also based on the GNU getopt_long() C library call and offers similar functionality to the Getopt::Long from the getopt gem. It allows for both POSIX-style options (e.g., --file) and single-letter options (e.g., -f).
See [GetoptLong](https://ruby-doc.org/3.4.1/gems/getoptlong/GetoptLong.html) for library details.

See [getoptlong_example.rb](./getoptlong_example.rb) for a demonstration:

```ruby
require 'getoptlong'
options = GetoptLong.new(
  ['--help', '-h', GetoptLong::NO_ARGUMENT],
  ['--verbose', '-v', GetoptLong::NO_ARGUMENT],
  ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT]
)
options.each do |option, arg|
  case option
  when '--verbose'
    puts "Verbose mode enabled."
  when '--output'
    puts "Output file: #{arg}"
  when '--help'
    puts "Usage: script.rb [options]"
    puts "--help, -h          Show this help message"
    puts "--verbose, -v       Enable verbose mode"
    puts "--output, -o FILE   Specify output file"
  end
end
```

Example usage:

```sh
$ ./getoptlong_example.rb --help
Usage: script.rb [options]
--help, -h          Show this help message
--verbose, -v       Enable verbose mode
--output, -o FILE   Specify output file
$ ./getoptlong_example.rb -v -o test.txt
Verbose mode enabled.
Output file: test.txt
```

### OptionParser (part of Ruby's standard library)

Considered more advanced and "Ruby-oriented" than GetoptLong. It provides a more flexible and declarative way to define options, automatically generate help messages, and handle argument type conversions.
See [OptionParser](https://ruby-doc.org/3.4.1/stdlibs/optparse/OptionParser.html) for library details.

OptionParser also supports a long list of [Built-In Argument Converters](https://ruby-doc.org/3.4.1/optparse/argument_converters_rdoc.html), and it is possible to add custom converters.

See [optparse_example.rb](./optparse_example.rb) for a demonstration:

```ruby
require 'optparse'
require 'optparse/date'

options = {}
OptionParser.new do |parser|
  parser.banner = "Usage: example.rb [options]"
  parser.on('-a', '--array=ARRAY', Array, 'provide a comma-separated list of values') # e.g., --array val1,val2,val3
  parser.on('-d', '--date=DATE', Date, 'provide a date (in the format YYYY-MM-DD)') # e.g., --date 2023-10-31
  parser.on('-v', '--[no-]verbose', 'Run verbosely')
  parser.on('-o', '--output FILE', 'Write to FILE')
  parser.on '-t', '--[no-]timeout [TIMEOUT]', Numeric, 'Timeout (in seconds) before timer aborts the run (Default: 1.8)' do |timeout|
    if timeout.is_a?(Numeric)
      timeout
    elsif timeout.nil?
      1.8
    elsif timeout == false
      -1
    end
  end
end.parse!(into: options)

puts "Options: #{options.inspect}"
puts "Array: #{options[:array].inspect}" if options[:array]
puts "Date: #{options[:date].inspect}" if options[:date]
puts "Output to #{options[:output]}" if options[:output]
puts "Timeout: #{options[:timeout].inspect}" if options[:timeout]
puts "Verbose output..." if options[:verbose]
```

Example usage:

```sh
$ ./optparse_example.rb --help
Usage: example.rb [options]
    -a, --array=ARRAY                provide a comma-separated list of values
    -d, --date=DATE                  provide a date (in the format YYYY-MM-DD)
    -v, --[no-]verbose               Run verbosely
    -o, --output FILE                Write to FILE
    -t, --[no-]timeout [TIMEOUT]     Timeout (in seconds) before timer aborts the run (Default: 1.8)

$ ./optparse_example.rb -v --no-timeout -o test.txt -a one,two,three -d 2025-10-02
Options: {:verbose=>true, :timeout=>-1, :output=>"test.txt", :array=>["one", "two", "three"], :date=>#<Date: 2025-10-02 ((2460951j,0s,0n),+0s,2299161j)>}
Array: ["one", "two", "three"]
Date: #<Date: 2025-10-02 ((2460951j,0s,0n),+0s,2299161j)>
Output to test.txt
Timeout: -1
Verbose output...
$ ./optparse_example.rb -t 12.34
Options: {:timeout=>12.34}
Timeout: 12.34
```

### CLI Sub-commands with OptionParser

I just saw an interesting article by David Bryant Copeland: [Building a Sub-command Ruby CLI with just OptionParser](https://naildrivin5.com/blog/2025/10/07/building-a-sub-command-ruby-cli-with-just-optionparser.html)

It describes a technique for using multiple Option Parsers in order to handle options that are conditional on the selected command.
This makes for an elegant way of handling command line designs like this:

```text
> ./optparse_subcommand_example.rb --verbose audit --type text foo.txt
  -----------------+-------------- ----+---- --+-- ------+---- ---+---
                   |                   |       |         |        |
App----------------+                   |       |         |        |
Global Options-------------------------+       |         |        |
Command----------------------------------------+         |        |
Command Options------------------------------------------+        |
Arguments---------------------------------------------------------+
```

See [optparse_subcommand_example.rb](./optparse_subcommand_example.rb)
for a demonstration:

```ruby
require 'optparse'

global_parser = OptionParser.new do |parser|
  parser.banner = "#{$0} [global options] command [command options] [command args...]"
  parser.on("--verbose", "Show additional logging/debug information")
end

commands = {}
commands["audit"] = OptionParser.new do |parser|
  parser.banner = "#{$0} [global options] audit [command options] [command args...]"
  parser.on("--type TYPE", "Set the type of test to audit. Omit to audit all types")
end

global_options  = {}
command_options = {}

global_parser.order!(into: global_options)
command = ARGV.shift
command_parser = commands[command]
command_parser&.parse!(into: command_options)

puts "global_options: #{global_options.inspect}"
puts "command: #{command}"
puts "command_options: #{command_options.inspect}"
puts "ARGV: #{ARGV.inspect}"
```

Example usage:

```sh
$ ./optparse_subcommand_example.rb -h
./optparse_subcommand_example.rb [global options] command [command options] [command args...]
        --verbose                    Show additional logging/debug information
$ ./optparse_subcommand_example.rb audit -h
./optparse_subcommand_example.rb [global options] audit [command options] [command args...]
        --type TYPE                  Set the type of test to audit. Omit to audit all types
$ ./optparse_subcommand_example.rb -v audit -t file foo.txt
global_options: {:verbose=>true}
command: audit
command_options: {:type=>"file"}
ARGV: ["foo.txt"]
$ ./optparse_subcommand_example.rb -v invalid -t file foo.txt
global_options: {:verbose=>true}
command: invalid
command_options: {}
ARGV: ["-t", "file", "foo.txt"]
```

## Credits and References

* <https://ruby-doc.org/3.4.1/ARGF.html>
* <https://ruby-doc.org/3.4.1/gems/getoptlong/GetoptLong.html>
* <https://ruby-doc.org/3.4.1/stdlibs/optparse/OptionParser.html>
* <https://justin.searls.co/posts/ruby-makes-advanced-cli-options-easy/>
* <https://naildrivin5.com/blog/2025/10/07/building-a-sub-command-ruby-cli-with-just-optionparser.html>
* [The Ruby Way](../the-ruby-way/) 14.2 Command-Line Options and Arguments
