# iReasoning MIB browser

Testing the iReasoning MIB browser on MacOS

## Notes

[ireasoning](https://www.ireasoning.com/) offer a range of networking tools, including a GUI
SNMP MIB browser - available in fere and paid versions.

| Feature                                 | Personal Edition | Professional Edition | Enterprise Edition |
|-----------------------------------------|------------------|----------------------|--------------------|
| Multiple platforms                      | √                | √                    | √                  |
| Supports basic SNMP operations          | √                | √                    | √                  |
| Table view for MIB tables               | √                | √                    | √                  |
| Trap Receiver                           | √                | √                    | √                  |
| Supports IPv6                           | √                | √                    | √                  |
| Supports SNMPv1/v2c                     | √                | √                    | √                  |
| Supports standard or private MIB        | √                | √                    | √                  |
| Maximum number of MIBs loaded           | 10               | No restrictions      | No restrictions    |
| Supports SNMPv3                         |                  | √                    | √                  |
| Network discovery                       |                  | √                    | √                  |
| ICMP Ping tool                          |                  | √                    | √                  |
| ICMP Traceroute tool                    |                  | √                    | √                  |
| SNMPv3 USM user management              |                  | √                    | √                  |
| Compares devices                        |                  | √                    | √                  |
| Performance graph                       |                  | √                    | √                  |
| Port view for network interface cards   |                  | √                    | √                  |
| Switch port mapper                      |                  | √                    | √                  |
| Device snapshot                         |                  | √                    | √                  |
| Cisco device snapshot                   |                  | √                    | √                  |
| Forwards traps via email                |                  | √                    | √                  |
| Periodically refreshes table            |                  | √                    | √                  |
| Dynamic table row creation and deletion |                  | √                    | √                  |
| Rule engine for processing traps        |                  | √                    | √                  |
| Watch actions                           |                  |                      | √                  |
| Run as service                          |                  |                      | √                  |
| Email template                          |                  |                      | √                  |
| Price                                   | Free             | 295.00 USD           | 595.00 USD         |


### Installing the Free Personal Edition

Visit the [site](https://www.ireasoning.com/mibbrowser.shtml) to compare versions.

Installing the portable free version:

    $ mkdir example_source
    $ cd example_source
    $ wget https://www.ireasoning.com/download/mibfree/mibbrowser.zip
    $ unzip mibbrowser.zip
    $ rm mibbrowser.zip

### Running

On MacOS, use the startup schell script:

    $ ireasoning/mibbrowser/browser.sh

Example scan and inspec a service:

![example.png](./assets/example.png?raw=true)

## Credits and References

* [iReasoning MIB browser](https://www.ireasoning.com/mibbrowser.shtml)
