# #218 SFTP

About SSH File Transfer Protocol

## Notes


### Running SFTP Server on MacOS

MacOS has SFTP support built-in, but disabled by default.

![macos_sharing](./assets/macos_sharing.png?raw=true)

Use sftp to make a connection:

    $ sftp paulgallagher@labarrossa
    Password:
    Connected to paulgallagher@labarrossa.
    sftp> ls Downloads
    ...
    sftp>


### Common FTP Commands

| Command          | Description |
|------------------|-------------|
| bye, close, quit | Terminates an FTP connection. |
| cd               | Changes the current working directory on the FTP host server. |
| cwd              | Changes the current directory to the specified remote directory. |
| dir              | Requests a directory of files uploaded or available for download. |
| get              | Downloads a single file. |
| ls               | Requests a list of file names uploaded or available for download. |
| mget             | Interactively downloads multiple files. |
| mput             | Interactively uploads multiple files. |
| open             | Starts an FTP connection. |
| pasv             | Tells the server to enter passive mode, in which the server waits for the client to establish a connection rather than attempting to connect to a port the client specifies. |
| put              | Uploads a single file. |
| pwd              | Queries the current working directory. |
| ren              | Renames or moves a file. |
| site             | Executes a site-specific command. |
| type             | Sets the file transfer mode: ASCII,  Binary |

## Credits and References

* [File Transfer Protocol](https://en.wikipedia.org/wiki/File_Transfer_Protocol)
* [SSH File Transfer Protocol](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol)
* [Start an FTP or SFTP Server in Mac OS X](https://osxdaily.com/2011/09/29/start-an-ftp-or-sftp-server-in-mac-os-x-lion/)
* [How To Turn On Your Mac’s SFTP Server](https://www.maciverse.com/how-to-turn-on-your-macs-sftp.html)
* [List of FTP commands](https://en.wikipedia.org/wiki/List_of_FTP_commands) - server commands, but note clients usually use more familiar aliases
* [Summary of FTP Client Commands](https://www.ibm.com/docs/en/scbn?topic=SSRJDU/gateway_services/ftp_globalec/SCN_Summary_of_FTP_Client_Commands_b.html)
