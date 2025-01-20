# #244 Compiling Ruby

Compiling Ruby (2.6.5-p114) from source and some debugging with llvm.

## Notes

I've had enough reason to look at ruby c source in the past, but never taken the plunge to compile it and start playing around in it.
Catching Andy Pliszka's LA Ruby Conf 2014 presentation finally spurred me on to have a go.
These are my notes...

LA Ruby Conf 2014 - Introduction to CRuby source code by Andy Pliszka:

[![example](https://img.youtube.com/vi/Chk9c8EwrCA/0.jpg)](https://www.youtube.com/watch?v=Chk9c8EwrCA)

### Building From Source (v2.6.5)

Get the source and a stable branch:

    git clone https://github.com/ruby/ruby.git
    cd ruby
    git checkout v2_6_5

Make sure I hav ea suitable OpenSSL lib:

    $ brew info openssl
    openssl@1.1: stable 1.1.1d (bottled) [keg-only]
    Cryptography and SSL/TLS Toolkit
    https://openssl.org/
    /usr/local/Cellar/openssl@1.1/1.1.1b (7,957 files, 17.9MB)
      Poured from bottle on 2019-05-22 at 16:07:11
    From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/openssl@1.1.rb


Configure compilation (MacOS) for installation to `$HOME/myruby`
with optimisation disabled: `-O0` to make debugging easier,
and include c-level debug info `-g`:

    $ autoconf
    $ ./configure --prefix=$HOME/myruby --with-opt-dir=/usr/local/Cellar/openssl@1.1/1.1.1b optflags="-O0" debugflags="-g" --disable-install-doc

Produces this configuration summary:

```
Configuration summary for ruby version 2.6.5

   * Installation prefix: /Users/paulgallagher/myruby
   * exec prefix:         ${prefix}
   * arch:                x86_64-darwin17
   * site arch:           ${arch}
   * RUBY_BASE_NAME:      ruby
   * ruby lib prefix:     ${libdir}/${RUBY_BASE_NAME}
   * site libraries path: ${rubylibprefix}/${sitearch}
   * vendor path:         ${rubylibprefix}/vendor_ruby
   * target OS:           darwin17
   * compiler:            $(CC_WRAPPER) clang
   * with pthread:        yes
   * enable shared libs:  no
   * dynamic library ext: bundle
   * CFLAGS:              ${optflags} ${debugflags} ${warnflags}
   * LDFLAGS:             -L. -fstack-protector-strong -L/usr/local/lib \
                          -L/usr/local/Cellar/openssl@1.1/1.1.1b/lib
   * DLDFLAGS:            -Wl,-undefined,dynamic_lookup \
                          -Wl,-multiply_defined,suppress \
                          -L/usr/local/Cellar/openssl@1.1/1.1.1b/lib
   * optflags:            -O0
   * debugflags:          -g
   * warnflags:           -Wall -Wextra -Wdeclaration-after-statement \
                          -Wdeprecated-declarations -Wdivision-by-zero \
                          -Wimplicit-function-declaration -Wimplicit-int \
                          -Wpointer-arith -Wshorten-64-to-32 \
                          -Wwrite-strings -Wmissing-noreturn \
                          -Wno-constant-logical-operand -Wno-long-long \
                          -Wno-missing-field-initializers \
                          -Wno-overlength-strings -Wno-parentheses-equality \
                          -Wno-self-assign -Wno-tautological-compare \
                          -Wno-unused-parameter -Wno-unused-value \
                          -Wunused-variable -Wextra-tokens
   * strip command:       strip -A -n
   * install doc:         no
   * JIT support:         yes
   * man page type:       doc
```

Compile and run the tests

```
$ make
$ make check
# Running tests:

Finished tests in 1066.946708s, 19.0937 tests/s, 2145.2637 assertions/s.
20372 tests, 2288882 assertions, 0 failures, 0 errors, 29 skips

ruby -v: ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin17]
$ /Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/miniruby -I/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/lib /Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/tool/runruby.rb --archdir=/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby --extout=.ext -- /Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/mspec/bin/mspec-run -B ./spec/default.mspec
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin17]

1)
Time.local handles years from 0 as such FAILED
Expected 1932
 to equal 1933

/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:138:in `block (3 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:136:in `upto'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:136:in `block (2 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/local_spec.rb:5:in `<top (required)>'

2)
Time.mktime handles years from 0 as such FAILED
Expected 1932
 to equal 1933

/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:138:in `block (3 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:136:in `upto'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:136:in `block (2 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/mktime_spec.rb:5:in `<top (required)>'

3)
Time.new handles years from 0 as such FAILED
Expected 1932
 to equal 1933

/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:138:in `block (3 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:136:in `upto'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/shared/time_params.rb:136:in `block (2 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/core/time/new_spec.rb:10:in `<top (required)>'

4)
Socket.getnameinfo using IPv6 using a 3 element Array as the first argument using NI_NUMERICHOST as the flag returns an Array containing the numeric hostname and service name ERROR
SocketError: sockaddr resolved to multiple nodename
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/library/socket/socket/getnameinfo_spec.rb:111:in `getnameinfo'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/library/socket/socket/getnameinfo_spec.rb:111:in `block (6 levels) in <top (required)>'
/Users/paulgallagher/MyGithub/LittleCodingKata/ruby/compiling/ruby/spec/ruby/library/socket/socket/getnameinfo_spec.rb:65:in `<top (required)>'
[- | ==================100%================== | 00:00:00]      3F      1E

Finished in 144.864095 seconds

3711 files, 30400 examples, 103334 expectations, 3 failures, 1 error, 0 tagged
make: *** [yes-test-spec] Error 1
```

3 failures, 1 error - that's interesting.

The three time-related failures look suspiciously like specs that are not timezone-aware.
I'm running UTC+8 by default, but that has changed over time:

    2.3.3 :003 > Time.local 2010
     => 2010-01-01 00:00:00 +0800
    2.3.3 :004 > Time.local 1930
     => 1930-01-01 00:00:00 +0700
    2.3.3 :005 > Time.local 1932
     => 1932-01-01 00:00:00 +0700
    2.3.3 :006 > Time.local 1933
     => 1932-12-31 00:00:00 +0700
    2.3.3 :007 > Time.local 1934
     => 1934-01-01 00:00:00 +0720

Re-running the tests with my system set to UTC makes these errors go away

For the IPv6, the essential code from the spec is trying to do this:

```
2.3.3 :025 > family, ip_address, family_name = Socket::AF_INET6, '::1', 'AF_INET6'
 => [30, "::1", "AF_INET6"]
2.3.3 :026 > @hostname = Socket.getaddrinfo(ip_address, nil, 0, 0, 0, 0, true)[0][2]
 => "localhost"
2.3.3 :027 > @addr = [family_name, 21, @hostname]
 => ["AF_INET6", 21, "localhost"]
2.3.3 :028 > Socket.getnameinfo(@addr, Socket::NI_NUMERICHOST)
Traceback (most recent call last):
        5: from /Users/paulgallagher/myruby/bin/irb:23:in `<main>'
        4: from /Users/paulgallagher/myruby/bin/irb:23:in `load'
        3: from /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        2: from (irb):28
        1: from (irb):28:in `getnameinfo'
SocketError (sockaddr resolved to multiple nodename)
```

Suspecting a bad assumption based on my `/etc/hosts` configuration, I was able to confirm that by commenting out the second localhost IPv6 definition cleared the error.
This entry appears to be [for standard link-local naming](https://superuser.com/questions/241642/what-is-the-relevance-of-fe801lo0-localhost-in-etc-hosts).

```
$ cat /etc/hosts
::1             localhost
#fe80::1%lo0     localhost
(...etc...)
```

With timezone and hosts file changes, `make check` is now 100% clean:

```
$ make check
(...etc...)
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin17]
[- | ==================100%================== | 00:00:00]      0F      0E .

Finished in 149.153653 seconds

3711 files, 30400 examples, 103836 expectations, 0 failures, 0 errors, 0 tagged
check succeeded
```

### Installing

Install (to `--prefix=$HOME/myruby`)
```
$ make install
./revision.h unchanged
  BASERUBY = /Users/paulgallagher/.rvm/rubies/ruby-2.3.3/bin/ruby --disable=gems
  CC = ./tool/darwin-cc clang
  LD = ld
  LDSHARED = ./tool/darwin-cc clang -dynamiclib
  CFLAGS = -O0 -g -Wall -Wextra -Wdeclaration-after-statement -Wdeprecated-declarations -Wdivision-by-zero -Wimplicit-function-declaration -Wimplicit-int -Wpointer-arith -Wshorten-64-to-32 -Wwrite-strings -Wmissing-noreturn -Wno-constant-logical-operand -Wno-long-long -Wno-missing-field-initializers -Wno-overlength-strings -Wno-parentheses-equality -Wno-self-assign -Wno-tautological-compare -Wno-unused-parameter -Wno-unused-value -Wunused-variable -Wextra-tokens   -pipe
  XCFLAGS = -fstack-protector-strong -fno-strict-overflow -fvisibility=hidden -DRUBY_EXPORT -fPIE -DCANONICALIZATION_FOR_MATHN
  CPPFLAGS = -I/usr/local/Cellar/openssl@1.1/1.1.1b/include -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE -D_DARWIN_UNLIMITED_SELECT -D_REENTRANT   -I. -I.ext/include/x86_64-darwin17 -I./include -I. -I./enc/unicode/12.1.0
  DLDFLAGS = -Wl,-undefined,dynamic_lookup -Wl,-multiply_defined,suppress -L/usr/local/Cellar/openssl@1.1/1.1.1b/lib -fstack-protector-strong -Wl,-pie -framework Security -framework Foundation
  SOLIBS = -lpthread -lgmp -ldl -lobjc
  LANG =
  LC_ALL =
  LC_CTYPE = UTF-8
Apple LLVM version 10.0.0 (clang-1000.11.45.5)
Target: x86_64-apple-darwin17.7.0
Thread model: posix
installing binary commands:         /Users/paulgallagher/myruby/bin
installing base libraries:          /Users/paulgallagher/myruby/lib
installing arch files:              /Users/paulgallagher/myruby/lib/ruby/2.6.0/x86_64-darwin17
installing pkgconfig data:          /Users/paulgallagher/myruby/lib/pkgconfig
installing command scripts:         /Users/paulgallagher/myruby/bin
installing library scripts:         /Users/paulgallagher/myruby/lib/ruby/2.6.0
installing common headers:          /Users/paulgallagher/myruby/include/ruby-2.6.0
installing manpages:                /Users/paulgallagher/myruby/share/man (man1, man5)
installing extension objects:       /Users/paulgallagher/myruby/lib/ruby/2.6.0/x86_64-darwin17
installing extension objects:       /Users/paulgallagher/myruby/lib/ruby/site_ruby/2.6.0/x86_64-darwin17
installing extension objects:       /Users/paulgallagher/myruby/lib/ruby/vendor_ruby/2.6.0/x86_64-darwin17
installing extension headers:       /Users/paulgallagher/myruby/include/ruby-2.6.0/x86_64-darwin17
installing extension scripts:       /Users/paulgallagher/myruby/lib/ruby/2.6.0
installing extension scripts:       /Users/paulgallagher/myruby/lib/ruby/site_ruby/2.6.0
installing extension scripts:       /Users/paulgallagher/myruby/lib/ruby/vendor_ruby/2.6.0
installing extension headers:       /Users/paulgallagher/myruby/include/ruby-2.6.0/ruby
installing default gems from lib:   /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0 (build_info, cache, doc, extensions, gems, specifications)
                                    bundler 1.17.2
                                    cmath 1.0.0
                                    csv 3.0.9
                                    e2mmap 0.1.0
                                    fileutils 1.1.0
                                    forwardable 1.2.0
                                    ipaddr 1.2.2
                                    irb 1.0.0
                                    logger 1.3.0
                                    matrix 0.1.0
                                    mutex_m 0.1.0
                                    ostruct 0.1.0
                                    prime 0.1.0
                                    rdoc 6.1.2
                                    rexml 3.1.9
                                    rss 0.2.7
                                    scanf 1.0.0
                                    shell 0.7
                                    sync 0.5.0
                                    thwait 0.1.0
                                    tracer 0.1.0
                                    webrick 1.4.2
installing default gems from ext:   /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0 (build_info, cache, doc, extensions, gems, specifications)
                                    bigdecimal 1.4.1
                                    date 2.0.0
                                    dbm 1.0.0
                                    etc 1.0.1
                                    fcntl 1.0.0
                                    fiddle 1.0.0
                                    gdbm 2.0.0
                                    io-console 0.4.7
                                    json 2.1.0
                                    openssl 2.1.2
                                    psych 3.1.0
                                    sdbm 1.0.0
                                    stringio 0.0.2
                                    strscan 1.0.0
                                    zlib 1.0.0
installing bundled gems:            /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0 (build_info, cache, doc, extensions, gems, specifications)
```

### Using `myruby`

Taking it for a test drive. I use rvm, so first I disable it with `rvm use system` before trying my new ruby build.

```
$ rvm use system
$ which ruby
/usr/bin/ruby
$ ruby --version
ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin17]
```

Set the new ruby path:

```
export PATH=$HOME/myruby/bin:$PATH
export GEM_HOME=$HOME/myruby/lib/ruby/gems/2.6.0
export GEM_PATH=$HOME/myruby/lib/ruby/gems/2.6.0
```

Check I'm finding the newly-installed ruby:

```
$ which ruby
/Users/paulgallagher/myruby/bin/ruby
$ which irb
/Users/paulgallagher/myruby/bin/irb
```

Check irb is functional..

```
$ irb
2.6.0 :001 > raise "hi"
Traceback (most recent call last):
        4: from /Users/paulgallagher/myruby/bin/irb:23:in `<main>'
        3: from /Users/paulgallagher/myruby/bin/irb:23:in `load'
        2: from /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        1: from (irb):1
RuntimeError (hi)
2.6.0 :002 > "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
 => "2.6.5-p114"
```

gem env

```
$ gem env
RubyGems Environment:
  - RUBYGEMS VERSION: 3.0.3
  - RUBY VERSION: 2.6.5 (2019-10-01 patchlevel 114) [x86_64-darwin17]
  - INSTALLATION DIRECTORY: /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0
  - USER INSTALLATION DIRECTORY: /Users/paulgallagher/.gem/ruby/2.6.0
  - RUBY EXECUTABLE: /Users/paulgallagher/myruby/bin/ruby
  - GIT EXECUTABLE: /usr/bin/git
  - EXECUTABLE DIRECTORY: /Users/paulgallagher/myruby/bin
  - SPEC CACHE DIRECTORY: /Users/paulgallagher/.gem/specs
  - SYSTEM CONFIGURATION DIRECTORY: /Users/paulgallagher/myruby/etc
  - RUBYGEMS PLATFORMS:
    - ruby
    - x86_64-darwin-17
  - GEM PATHS:
     - /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0
  - GEM CONFIGURATION:
     - :update_sources => true
     - :verbose => true
     - :backtrace => false
     - :bulk_threshold => 1000
  - REMOTE SOURCES:
     - https://rubygems.org/
  - SHELL PATH:
     - /Users/paulgallagher/myruby/bin
     (...etc...)
```

### Building a Rails App

Rails is perhaps one of the best ways of validating a ruby build with realistic usage.

```
$ gem install rails --no-doc
(...etc...)
$ rails new HelloMyruby
(...etc...)
$ cd HelloMyruby
$ rails s
=> Booting Puma
=> Rails 6.0.2 application starting in development
=> Run `rails server --help` for more startup options
Puma starting in single mode...
* Version 4.3.1 (ruby 2.6.5-p114), codename: Mysterious Traveller
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://127.0.0.1:3000
* Listening on tcp://[::1]:3000
* Listening on tcp://127.94.0.2:3000
* Listening on tcp://127.94.0.1:3000
Use Ctrl-C to stop
Started GET "/" for ::1 at 2019-12-15 13:34:34 +0800
   (6.5ms)  SELECT sqlite_version(*)
Processing by Rails::WelcomeController#index as HTML
  Rendering /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0/gems/railties-6.0.2/lib/rails/templates/rails/welcome/index.html.erb
  Rendered /Users/paulgallagher/myruby/lib/ruby/gems/2.6.0/gems/railties-6.0.2/lib/rails/templates/rails/welcome/index.html.erb (Duration: 19.8ms | Allocations: 479)
Completed 200 OK in 43ms (Views: 29.4ms | ActiveRecord: 0.0ms | Allocations: 3739)
```

![rails](./assets/rails.png?raw=true)

So far so good. Next steps: debugging and writing/modifying ruby source?

## Debugging

The [upstring.rb](./upstring.rb) is a simple script that makes a call to `String#upcase`.
I'm on a Mac, so I'll use lldb to try c-level debugging.

In this version of ruby, the relevant method in `ruby/string.c` is `rb_str_upcase_bang`:

```
6624 static VALUE
6625 rb_str_upcase_bang(int argc, VALUE *argv, VALUE str)
6626 {
6627     rb_encoding *enc;
6628     OnigCaseFoldType flags = ONIGENC_CASE_UPCASE;
6629
6630     flags = check_case_options(argc, argv, flags);
6631     str_modify_keep_cr(str);
6632     enc = STR_ENC_GET(str);
6633     rb_str_check_dummy_enc(enc);
6634     if (((flags&ONIGENC_CASE_ASCII_ONLY) && (enc==rb_utf8_encoding() || rb_enc_mbmaxlen(enc)==1))
```

I'll break on 6634:

```
$ lldb ~/myruby/bin/ruby upstring.rb
(lldb) target create "/Users/paulgallagher/myruby/bin/ruby"
Current executable set to '/Users/paulgallagher/myruby/bin/ruby' (x86_64).
(lldb) settings set -- target.run-args  "upstring.rb"
(lldb) breakpoint set -l 6634 -f string.c
Breakpoint 1: where = ruby`rb_str_upcase_bang + 92 at string.c:6634, address = 0x000000010025f71c
(lldb) run
Process 78325 launched: '/Users/paulgallagher/myruby/bin/ruby' (x86_64)
Process 78325 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x000000010025f71c ruby`rb_str_upcase_bang(argc=0, argv=0x0000000101400180, str=4338172560) at string.c:6634
   6631     str_modify_keep_cr(str);
   6632     enc = STR_ENC_GET(str);
   6633     rb_str_check_dummy_enc(enc);
-> 6634     if (((flags&ONIGENC_CASE_ASCII_ONLY) && (enc==rb_utf8_encoding() || rb_enc_mbmaxlen(enc)==1))
   6635   || (!(flags&ONIGENC_CASE_FOLD_TURKISH_AZERI) && ENC_CODERANGE(str)==ENC_CODERANGE_7BIT)) {
   6636         char *s = RSTRING_PTR(str), *send = RSTRING_END(str);
   6637
Target 0: (ruby) stopped.
(lldb) thread step-over
[.. some stepping ensues...]
(lldb) thread step-over
Process 78325 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = step over
    frame #0: 0x000000010025f814 ruby`rb_str_upcase_bang(argc=0, argv=0x0000000101400180, str=4338172560) at string.c:6638
   6635   || (!(flags&ONIGENC_CASE_FOLD_TURKISH_AZERI) && ENC_CODERANGE(str)==ENC_CODERANGE_7BIT)) {
   6636         char *s = RSTRING_PTR(str), *send = RSTRING_END(str);
   6637
-> 6638   while (s < send) {
   6639       unsigned int c = *(unsigned char*)s;
   6640
   6641       if (rb_enc_isascii(c, enc) && 'a' <= c && c <= 'z') {
Target 0: (ruby) stopped.
(lldb) frame variable
(int) argc = 0
(VALUE *) argv = 0x0000000101400180
(VALUE) str = 4338172560
(rb_encoding *) enc = 0x0000000101205c40
(OnigCaseFoldType) flags = 8192
(char *) s = 0x00000001029342a0 "did_you_mean"
(char *) send = 0x00000001029342ac ""
[.. some stepping ensues...]
(lldb) continue
Process 78325 resuming
HELLO
Process 78325 exited with status = 0 (0x00000000)
(lldb) ^D
```

## Credits and References

* [ruby](https://github.com/ruby/ruby/) - GitHub mirror of the source
* [Ruby Issue Tracking](https://bugs.ruby-lang.org/issues)
* [lldb tutorial](https://lldb.llvm.org/use/tutorial.html)
* [lldb cheatsheet](https://www.nesono.com/sites/default/files/lldb%20cheat%20sheet.pdf)
