# #293 Homebrew on Apple Silicon

Using Homebrew to manage ARM64 and x86_64 package installations on macOS.

## Notes

With the introduction of the M1 (ARM) chip, Apple once again forced us all to swap underlying processor architecture (remember the Power PC, and 68k?). This is meant to be transparent for users, but it can be a bumpy ride for developers during the transitional years, as foundational packages and libraries all need to be updated.

I often use [Homebrew](https://brew.sh/) to manage software installations on my Mac.

While it is possible to prepend `arch --x86_64` to emulate Intel for any brew command, this will cause it to attempt to install a mix of packages for different architectures and probably won't work.

The best option is obviously to avoid any `x86_64` code at all. But if that is not possible, another alternative is to maintain two separate brew installations - one for each processor architecture.

### Installing Parallel Brews

First install Homebrew for Apple Silicon at `/opt/homebrew` by default:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

A second Intel-emulated installation using the arch command will install to `/usr/local` by default:

    arch --x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

NB: this required Rosetta 2 support to be enabled first; run `softwareupdate --install-rosetta`.

    arch --x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ...
    ==> Next steps:
    - Run these two commands in your terminal to add Homebrew to your PATH:
        (echo; echo 'eval "$(/usr/local/bin/brew shellenv)"') >> /Users/paulgallagher/.bash_profile
        eval "$(/usr/local/bin/brew shellenv)"
    - Run brew help to get started
    - Further documentation:
        https://docs.brew.sh

### Automatically selecting the correct brew

NB: this is for `zsh` only

Adding the following snippet to `.zshrc` will cause the appropriate Homebrew to be added to the path:

    if [ "$(arch)" = "arm64" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi

Running a shell with default `arm64` architecture:

    $ zsh
    % arch
    arm64
    % which brew
    /opt/homebrew/bin/brew

Running a shell with `x86_64` architecture:

    $ arch --x86_64 zsh
    Restored session: Wed Aug  7 11:08:46 +08 2024
    % arch
    i386
    % which brew
    /usr/local/bin/brew

## Credits and References

* [Homebrew](https://brew.sh/)
* [homebrew](https://github.com/Homebrew/brew)
* [SO: How can I run two isolated installations of Homebrew?](https://stackoverflow.com/questions/64951024/how-can-i-run-two-isolated-installations-of-homebrew/64951025#64951025)
* [name](https://stackoverflow.com/questions/71134291/how-do-i-install-sqlite3-gem-on-an-m1-mac)
