# SSH

About Secure Shell (SSH) and common SSH tips and tricks.

## Notes

### SSH Agent Forwarding

SSH agent forwarding allows use of private, local SSH key on a remote server without needing to explicitly transfer or install the key on the remote server.

Enable forwarding in `~/.ssh/config` e.g.:

    Host example.remote.server..com
    IdentityFile ~/.ssh/my_key_rsa
    ForwardAgent yes

Register/add the key to be forwarded:

    $ ssh-add ~/.ssh/my_key_rsa

Connect, with formwarding enabled:

    $ ssh -v example.remote.server..com

## Credits and References

* [Secure Shell](https://en.wikipedia.org/wiki/Secure_Shell)
* [What is SSH Agent Forwarding and How Do You Use It?](https://www.cloudsavvyit.com/25/what-is-ssh-agent-forwarding-and-how-do-you-use-it/)
