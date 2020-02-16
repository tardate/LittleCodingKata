# Linux Server Hacks

Book notes - Linux Server Hacks by Rob Flickenger
and
Linux Server Hacks, Volume Two (Tips & Tools for Connecting, Monitoring, and Troubleshooting)
by William von Hagen and Brian K. Jones, published by O'Reilly.

## Notes

### Linux Server Hacks Volume 1: Table of Contents - Highlights

#### 1. Server Basics

* 1. Removing Unnecessary Services
* 2. Forgoing the Console Login
* 3. Common Boot Parameters
* 4. Creating a Persistent Daemon with init
* 5. n>&m: Swap Standard Output and Standard Error
* 6. Building Complex Command Lines
* 7. Working with Tricky Files in xargs
* 8. Immutable Files in ext2/ext3
* 9. Speeding Up Compiles
* 10. At Home in Your Shell Environment
* 11. Finding and Eliminating setuid/setgid Binaries
* 12. Make sudo Work Harder
* 13. Using a Makefile to Automate Admin Tasks
* 14. Brute Forcing Your New Domain Name
* 15. Playing Hunt the Disk Hog
* 16. Fun with /proc
* 17. Manipulating Processes Symbolically with procps
* 18. Managing System Resources per Process
* 19. Cleaning Up after Ex-Users
* 20. Eliminating Unnecessary Drivers from the Kernel
* 21. Using Large Amounts of RAM
* 22. hdparm: Fine Tune IDE Drive Parameters

#### 2. Revision Control

* 23. Getting Started with RCS
* 24. Checking Out a Previous Revision in RCS
* 25. Tracking Changes with rcs2log
* 26. Getting Started with CVS
* 27. CVS: Checking Out a Module
* 28. CVS: Updating Your Working Copy
* 29. CVS: Using Tags
* 30. CVS: Making Changes to a Module
* 31. CVS: Merging Files
* 32. CVS: Adding and Removing Files and Directories
* 33. CVS: Branching Development
* 34. CVS: Watching and Locking Files
* 35. CVS: Keeping CVS Secure
* 36. CVS: Anonymous Repositories

#### 3. Backups

* 37. Backing Up with tar over ssh
* 38. Using rsync over ssh
* 39. Archiving with Pax
* 40. Backing Up Your Boot Sector
* 41. Keeping Parts of Filesystems in sync with rsync
* 42. Automated Snapshot-Style Incremental Backups with rsync
* 43. Working with ISOs and CDR/CDRWs
* 44. Burning a CD Without Creating an ISO File

#### 4. Networking

* 45. Creating a Firewall from the Command Line of any Server
* 46. Simple IP Masquerading
* 47. iptables Tips & Tricks
* 48. Forwarding TCP Ports to Arbitrary Machines
* 49. Using Custom Chains in iptables
* 50. Tunneling: IPIP Encapsulation
* 51. Tunneling: GRE Encapsulation
* 52. Using vtun over ssh to Circumvent NAT
* 53. Automatic vtund.conf Generator

#### 5. Monitoring

* 54. Steering syslog
* 55. Watching Jobs with watch
* 56. What’s Holding That Port Open?
* 57. Checking On Open Files and Sockets with lsof
* 58. Monitor System Resources with top
* 59. Constant Load Average Display in the Titlebar
* 60. Network Monitoring with ngrep
* 61. Scanning Your Own Machines with nmap
* 62. Disk Age Analysis
* 63. Cheap IP Takeover
* 64. Running ntop for Real-Time Network Stats
* 65. Monitoring Web Traffic in Real Time with httptop

#### 6. SSH

* 66. Quick Logins with ssh Client Keys
* 67. Turbo-mode ssh Logins
* 68. Using ssh-Agent Effectively
* 69. Running the ssh-Agent in a GUI
* 70. X over ssh
* 71. Forwarding Ports over ssh

#### 7. Scripting

* 72. Get Settled in Quickly with movein.sh
* 73. Global Search and Replace with Perl
* 74. Mincing Your Data into Arbitrary Chunks (in bash)
* 75. Colorized Log Analysis in Your Terminal

#### 8. Information Servers

* 76. Running BIND in a chroot Jail
* 77. Views in BIND 9
* 78. Setting Up Caching DNS with Authority for Local Domains
* 79. Distributing Server Load with Round-Robin DNS
* 80. Running Your Own Top-Level Domain
* 81. Monitoring MySQL Health with mtop
* 82. Setting Up Replication in MySQL
* 83. Restoring a Single Table from a Large MySQL Dump
* 84. MySQL Server Tuning
* 85. Using proftpd with a mysql Authentication Source
* 86. Optimizing glibc, linuxthreads, and the Kernel for a Super MySQL Server
* 87. Apache Toolbox
* 88. Display the Full Filename in Indexes
* 89. Quick Configuration Changes with IfDefine
* 90. Simplistic Ad Referral Tracking
* 91. Mimicking FTP Servers with Apache
* 92. Rotate and compress Apache Server Logs
* 93. Generating an SSL cert and Certificate Signing Request
* 94. Creating Your Own CA
* 95. Distributing Your CA to Client Browsers
* 96. Serving multiple sites with the same DocumentRoot
* 97. Delivering Content Based on the Query String Using mod_rewrite
* 98. Using mod_proxy on Apache for Speed
* 99. Distributing Load with Apache RewriteMap
* 100. Ultrahosting: Mass Web Site Hosting with Wildcards, Proxy, and Rewrite


### Linux Server Hacks, Volume Two: Table of Contents - Highlights

Tips & Tools for Connecting, Monitoring, and Troubleshooting

#### 1. Linux Authentication

* 1. Disable User Accounts Instantly
* 2. Edit Your Password File for Greater Access Control
* 3. Deny All Access in One Second or Less
* 4. Customize Authentication with PAMs
* 5. Authenticate Linux Users with a Windows Domain Controller
* 6. Centralize Logins with LDAP
* 7. Secure Your System with Kerberos
* 8. Authenticate NFS-Lovers with NIS
* 9. Sync LDAP Data with NIS

#### 2. Remote GUI Connectivity

* 10. Access Systems Remotely with VNC
* 11. Access VNC Servers over the Web
* 12. Secure VNC via SSH
* 13. Autostart VNC Servers on Demand
* 14. Put Your Desktops on a Thin Client Diet (LTSP)
* 15. Run Windows over the Network
* 16. Secure, Lightweight X Connections with FreeNX
* 17. Secure VNC Connections with FreeNX
* 18. Secure Windows Terminal Connections with FreeNX
* 19. Remote Administration with Webmin

#### 3. System Services

* 20. Quick and Easy DHCP Setup
* 21. Integrate DHCP and DNS with Dynamic DNS Updates (BIND, ISC DHCP)
* 22. Synchronize Your Watches!
* 23. Centralize X Window System Font Resources
* 24. Create a CUPS Print Server
* 25. Configure Linux Connections to Remote CUPS Printers
* 26. Integrate Windows Printing with CUPS
* 27. Centralize Macintosh Printing with CUPS
* 28. Define a Secure CUPS Printer

#### 4. Cool Sysadmin Tools and Tips

* 29. Execute Commands Simultaneously on Multiple Servers
* 30. Collaborate Safely with a Secured Wiki (MediaWiki)
* 31. Edit Your GRUB Configuration with grubby
* 32. Give Your Tab Key a Workout
* 33. Keep Processes Running After a Shell Exits (nohup, disown)
* 34. Disconnect Your Console Without Ending Your Session (screen)
* 35. Use script to Save Yourself Time and Train Others
* 36. Install Linux Simply by Booting
* 37. Turn Your Laptop into a Makeshift Console
* 38. Usable Documentation for the Inherently Lazy
* 39. Exploit the Power of Vim
* 40. Move Your PHP Web Scripting Skills to the Command Line
* 41. Enable Quick telnet/SSH Connections from the Desktop
* 42. Speed Up Compiles (distcc)
* 43. Avoid Common Junior Mistakes
* 44. Get Linux Past the Gatekeeper
* 45. Prioritize Your Work

#### 5. Storage Management and Backups

* 46. Create Flexible Storage with LVM
* 47. Combine LVM and Software RAID
* 48. Create a Copy-on-Write Snapshot of an LVM Volume
* 49. Clone Systems Quickly and Easily (partimage)
* 50. Make Disk-to-Disk Backups for Large Drives
* 51. Free Up Disk Space Now
* 52. Share Files Using Linux Groups
* 53. Refine Permissions with ACLs
* 54. Make Files Easier to Find with Extended Attributes
* 55. Prevent Disk Hogs with Quotas

#### 6. Standardizing, Sharing, and Synchronizing Resources

* 56. Centralize Resources Using NFS
* 57. Automount NFS Home Directories with autofs
* 58. Keep Filesystems Handy, but Out of Your Way
* 59. Synchronize root Environments with rsync
* 60. Share Files Across Platforms Using Samba
* 61. Quick and Dirty NAS
* 62. Share Files and Directories over the Web

#### 7. Security

* 63. Increase Security by Disabling Unnecessary Services
* 64. Allow or Deny Access by IP Address
* 65. Detect Network Intruders with snort
* 66. Tame Tripwire
* 67. Verify Fileystem Integrity with Afick
* 68. Check for Rootkits and Other Attacks (chkrootkit)

#### 8. Troubleshooting and Performance

* 69. Find Resource Hogs with Standard Commands
* 70. Reduce Restart Times with Journaling Filesystems
* 71. Grok and Optimize Your System with sysctl
* 72. Get the Big Picture with Multiple Displays
* 73. Maximize Resources with a Minimalist Window Manager (Fluxbox)
* 74. Profile Your Systems Using /proc
* 75. Kill Processes the Right Way
* 76. Use a Serial Console for Centralized Access to Your Systems
* 77. Clean Up NIS After Users Depart

#### 9. Logfiles and Monitoring

* 78. Avoid Catastrophic Disk Failure
* 79. Monitor Network Traffic with MRTG
* 80. Keep a Constant Watch on Hosts
* 81. Remotely Monitor and Configure a Variety of Networked Equipment
* 82. Force Standalone Apps to Use syslog
* 83. Monitor Your Logfiles (log-guardian, logcheck)
* 84. Send Log Messages to Your Jabber Client
* 85. Monitor Service Availability with Zabbix
* 86. Fine-Tune the syslog Daemon
* 87. Centralize System Logs Securely (stunnel, syslog-ng)
* 88. Keep Tabs on Systems and Services (Nagios)

#### 10. System Rescue, Recovery, and Repair

* 89. Resolve Common Boot and Startup Problems (BIOS, runlevel)
* 90. Rescue Me! (rescue disk)
* 91. Bypass the Standard Init Sequence for Quick Repairs
* 92. Find Out Why You Can’t Unmount a Partition
* 93. Recover Lost Partitions
* 94. Recover Data from Crashed Disks
* 95. Repair and Recover ReiserFS Filesystems
* 96. Piece Together Data from the lost+found
* 97. Recover Deleted Files
* 98. Permanently Delete Files (shred)
* 99. Permanently Erase Hard Disks (shred, Darik’s Boot and Nuke)
* 100. Recover Lost Files and Perform Forensic Analysis (The Sleuth Kit, Autopsy)

### Getting the Source

Volume 1 examples are available form the O'Reilly git server:

```
$ git clone https://resources.oreilly.com/examples/9780596004613.git example_source/vol1
```

It seems there is no published example code for volume 2.

## Credits and References

* Linux Server Hacks, Volume One:
  * [O'Reilly](https://learning.oreilly.com/library/view/linux-server-hacks/0596004613/)
  * [goodreads](https://www.goodreads.com/book/show/86607.Linux_Server_Hacks)
  * [example source](https://resources.oreilly.com/examples/9780596004613/)
* Linux Server Hacks, Volume Two
  * [O'Reilly](https://learning.oreilly.com/library/view/linux-server-hacks/0596100825/)
  * [goodreads](https://www.goodreads.com/book/show/166717.Linux_Server_Hacks_Volume_Two)
