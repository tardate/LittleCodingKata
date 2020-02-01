# Elixir on MacOSX

Installing Elixir on MacOSX

## Notes

Trying two options for running Elixir on MacOSX - brew and docker

### Using Homebrew

Installing with brew and the [Elixir Homebrew Fomula](https://formulae.brew.sh/formula/elixir)

```
$ brew update
$ brew install elixir
$ brew info elixir
elixir: stable 1.10.0 (bottled), HEAD
Functional metaprogramming aware language built on Erlang VM
https://elixir-lang.org/
/usr/local/Cellar/elixir/1.10.0 (430 files, 5.9MB) *
  Poured from bottle on 2020-02-01 at 14:34:05
From: https://github.com/Homebrew/homebrew-core/blob/master/Formula/elixir.rb
==> Dependencies
Required: erlang ✔
==> Options
--HEAD
  Install HEAD version
==> Analytics
install: 7,722 (30 days), 24,418 (90 days), 101,881 (365 days)
install-on-request: 7,290 (30 days), 22,832 (90 days), 94,499 (365 days)
build-error: 0 (30 days)
```

Installed version:

```
$ elixir --version
Erlang/OTP 22 [erts-10.6.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe] [dtrace]

Elixir 1.10.0 (compiled with Erlang/OTP 22)
```

Running the REPL:

```
$ iex
Erlang/OTP 22 [erts-10.6.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.10.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> System.version
"1.10.0"
iex(2)> :c.uptime
34 seconds
:ok
iex(3)>
```

Running scripts:

```
$ elixir demo.exs
System.version: 1.10.0
```

### Using Docker

Official Elixir Docker images are published on [Docker Hub](https://hub.docker.com/_/elixir)

Running interactive:

```
$ docker run -it --rm elixir
Unable to find image 'elixir:latest' locally
latest: Pulling from library/elixir
...
Digest: sha256:d3958dd5ba502b94b467699c595762a4bf2059eabb5f6b68ef4c6b6063362db5
Status: Downloaded newer image for elixir:latest
Erlang/OTP 22 [erts-10.6.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.0) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> System.version
"1.10.0"
iex(2)> :c.uptime
38 seconds
:ok
iex(3)>
```

Run a single Elixir exs script:
this command maps the current directoty to `/usr/src/myapp` in the container and sets this as the working directory
to run the names script:

```
$ docker run -it --rm --name elixir-lckdemo -v "$PWD":/usr/src/myapp -w /usr/src/myapp elixir elixir demo.exs
System.version: 1.10.0
```

## Credits and References

* [Installing Elixir](https://elixir-lang.org/install.html)
* [Official Elixir Docker Images](https://hub.docker.com/_/elixir)
