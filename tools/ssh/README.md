# #217 SSH

About Secure Shell (SSH) and common SSH tips and tricks.

## Notes

### SSH Agent Forwarding

SSH agent forwarding allows use of private, local SSH key on a remote server without needing to explicitly transfer or install the key on the remote server.

Enable forwarding in `~/.ssh/config` e.g.:

```txt
Host example.remote.server..com
IdentityFile ~/.ssh/my_key_rsa
ForwardAgent yes
```

Register/add the key to be forwarded:

```sh
ssh-add ~/.ssh/my_key_rsa
```

Connect, with forwarding enabled:

```sh
ssh -v example.remote.server..com
```

### SSH Password-less Authentication

To set up SSH key-based authentication for password-less entry, you need to generate a key pair on your local (client) machine and then copy the public key to the remote (server) machine.

* The public key is recorded in `~/.ssh/authorized_keys` on the remote machine.
* the permissions on the `~/.ssh` folder (700: u+rwx) and `authorized_keys` file (600: u+rw) are critical

#### 1 Generate an SSH Key Pair (Client Machine)

If you don't already have a public/private key to use, create on with `ssh-keygen`.
The ed25519 type is recommended for better security and performance than the older rsa type.

```sh
$ ssh-keygen -t ed25519
# or with id filename and passphrase specified on the command line:
$ ssh-keygen -t ed25519 -f ~/.ssh/id_example_ed25519 -N ""
Generating public/private ed25519 key pair.
Your identification has been saved in /Users/paulgallagher/.ssh/id_example_ed25519
Your public key has been saved in /Users/paulgallagher/.ssh/id_example_ed25519.pub
The key fingerprint is:
SHA256:2Okwnzo9h7RWXJZ3D2JKSUDz31a2ms6/OC0bqce6K1U paulgallagher@Mac
The key's randomart image is:
+--[ED25519 256]--+
|       .+.       |
|         o.      |
|         ... .  o|
|       o .o.*Eooo|
|      + So =ooo+.|
|       =..+. .+ .|
|       o++. .=.  |
|      ..*.. +=o. |
|      .o o.====o.|
+----[SHA256]-----+
```

#### 2 Copy the Public Key to the Remote Server

The easiest method to transfer the public key and configure the server is using the `ssh-copy-id` command.

This is an example of installing the key on a Raspberry Pi:

```sh
$ ssh-copy-id -i ~/.ssh/id_example_ed25519 pi@raspi1.local
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/Users/paulgallagher/.ssh/id_example_ed25519.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
pi@192.168.10.36's password:

Number of key(s) added:        1

Now try logging into the machine, with: "ssh -i /Users/paulgallagher/.ssh/id_example_ed25519 'pi@raspi1.local'"
and check to make sure that only the key(s) you wanted were added.

```

Verifying the login:

```sh
$ cat ~/.ssh/id_example_ed25519.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICMxEq5szPlZj/xoze7R5OZgFi+3Nxa8QCb5IvSuniyF paulgallagher@Mac
$ ssh -i ~/.ssh/id_example_ed25519 'pi@raspi1.local'
Linux raspi1 6.6.74+rpt-rpi-v6 #1 Raspbian 1:6.6.74-1+rpt1 (2025-01-27) armv6l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Feb 12 16:28:33 2026 from 192.168.10.85
pi@raspi1:~ $ cat .ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICMxEq5szPlZj/xoze7R5OZgFi+3Nxa8QCb5IvSuniyF paulgallagher@Mac
```

To make this the default key for the ssh session, can specify in the local `~/ssh/config` file. For example:

```text
Host raspi1.local
  User pi
  IdentityFile ~/.ssh/id_example_ed25519
```

Now full password-less authentication is enabled:

```sh
$ ssh raspi1.local
Linux raspi1 6.6.74+rpt-rpi-v6 #1 Raspbian 1:6.6.74-1+rpt1 (2025-01-27) armv6l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Thu Feb 12 16:30:33 2026 from 192.168.10.85
pi@raspi1:~ $
```

If `ssh-copy-id` is not available, the manual steps are straight-forward:

* create the key as before
* SSH into the remote server using your password

    ```sh
    ssh pi@raspi1.local
    ```

* Once logged in, ensure the ~/.ssh directory exists and has correct permissions:

    ```sh
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    ```

* Append the copied key to the authorized_keys file. (Use >> to append, not > to overwrite existing keys):

    ```sh
    echo "paste_your_public_key_here" >> ~/.ssh/authorized_keys
    ```

* Set the correct permissions for the authorized_keys file:

    ```sh
    chmod 600 ~/.ssh/authorized_keys
    ```

* Logout, test access with the key as before.

## Credits and References

* [Secure Shell](https://en.wikipedia.org/wiki/Secure_Shell)
* [What is SSH Agent Forwarding and How Do You Use It?](https://www.cloudsavvyit.com/25/what-is-ssh-agent-forwarding-and-how-do-you-use-it/)
