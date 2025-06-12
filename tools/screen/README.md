# #333 screen

GNU Screen is a terminal multiplexer that can also be used as a general serial console.

## Notes

[GNU Screen](https://en.wikipedia.org/wiki/GNU_Screen) is a terminal multiplexer.

The most common ways I use it:

* connect to multiple servers from a single terminal window on my machine
* use it on a server to establish a long-running login shell that I can detach and reattach at a later time
* as a general purpose serial console

### command-line options

Some of the most common:

* `screen` -- with no options this starts new screen session with a shell in a virtual screen.
* `screen -S <name>` -- starts a session with a given name. This can help find and reconnect to the correct session later.
* `screen -r` -- reconnect to a disconnected session.
* `screen -r <name>` -- reconnect to the named session.
* `screen -rd` -- reconnect to a disconnected session, disconnecting any existing client (if any).
* `screen -ls` -- list all sessions (connected and disconnected).

### control commands used inside of a screen session

All screen commands start with `<ctrl>-a`. The most important ones:

* `<ctrl>-a ?` -- Show help
* `<ctrl>-a d` -- Disconnect the session. The session continues in the background as a daemon which you can reconnect to later.
* `<ctrl>-a k` -- KILL the current screen
* `<ctrl>-a c` -- Create a shell in new virtual screen. This screen is added to the current session.
* `<ctrl>-a n` -- Next screen
* `<ctrl>-a p` -- Previous screen

### using screen as an RS-232 / general serial terminal

Screen makes a very good serial port terminal. You can connect a screen window to any serial device in `/dev`.

On linux, most serial devices in linux are named like `/dev/ttyS0`, `/dev/ttyAMA0`, and `/dev/serial0` for a built-in serial port;
or for USB-to-serial adapters the names are usually like `/dev/ttyUSB0` and `/dev/ttyUSB1`.

The communication settings are a comma separated list of control modes as would be passed to `stty`. See the man page for `stty` for more info.

Old, slow-speed serial devices usually play nice with 9600 8N1 (9600 baud, 8-bits per character, no parity, and 1 stop bit):

```sh
screen /dev/ttyS0 9600,cs8,-parenb,-cstopb,-hupcl
screen /dev/ttyS0 19200,cs8,-parenb,-cstopb,-hupcl
screen /dev/ttyS0 115200,cs8,-parenb,-cstopb,-hupcl
# use odd parity:
screen /dev/ttyS0 9600,cs8,parenb,parodd,-cstopb,-hupcl
# even parity:
screen /dev/ttyS0 9600,cs8,parenb,-parodd,-cstopb,-hupcl
```

The following settings work with the Coyote Point E450si load balancers

```sh
screen /dev/ttyS0 9600,cs8,-parenb,-cstopb,-hupcl
```

### macOS serial devices

On macOS, devices are named like `/dev/cu.*` and `/dev/tty.*`.
A USB-to-Serial device (such as those using the CH340G chip) may appear with up to 4 device file handles, e.g.:

```sh
$ ls -1 /dev/*serial*
/dev/cu.usbserial-2420
/dev/cu.wchusbserial2420
/dev/tty.usbserial-2420
/dev/tty.wchusbserial2420
```

The `/dev/cu.*` (Callout) and `/dev/tty.*` (Terminal) devices in macOS both manage serial communication, but they differ in behavior during initial connection and modem control handling:

* Behavior During Open:
    * `/dev/cu.*` (Callout):
        * Opens immediately, ignoring modem control signals like Carrier Detect (CD).
        * Use this when you want direct access to the port without waiting for a connection handshake (e.g., programming microcontrollers).
    * `/dev/tty.*` (Terminal):
        * Waits for modem signals (like CD) before opening. If the modem isn't ready, opening may block or fail.
        * Use this for terminal sessions requiring modem negotiation (e.g., dial-up).
* Symbolic Link vs. Device File:
    * Both are symbolic links pointing to the same underlying device node (e.g., `/dev/cu.usbserial-2420` → `/dev/tty.usbserial-2420`).
    * Deleting either link doesn't remove the actual device; macOS recreates them dynamically.

Use Cases:

`/dev/cu.*`: Preferred for programmatic control (Arduino, Raspberry Pi, sensors) where you need immediate, unconditional access.

```sh
screen /dev/cu.usbserial-2420 9600  # Opens instantly
```

`/dev/tty.*`: Used for interactive terminals or legacy modem applications where carrier detection is critical.

```sh
screen /dev/tty.usbserial-2420 9600  # Waits for carrier signal
```

Most USB serial devices (Arduino, FTDI) work with either, but `/dev/cu.*` is more reliable for programming (avoids blocking).
Use `/dev/tty.*` only if modem handshaking is explicitly needed.

## Credits and References

* <https://en.wikipedia.org/wiki/GNU_Screen>
* [Screen User Manual](https://www.gnu.org/software/screen/manual/screen.html)
* [An introduction to GNU Screen](https://opensource.com/article/17/3/introduction-gnu-screen)
* [screen notes (archived)](https://web.archive.org/web/20200220232553/http://www.noah.org/wiki/Screen_notes#using_screen_as_an_RS-232_.2F_general_serial_terminal)
