=begin
=ACL class
Simple Access Control List.
ACL can test the socket for access.

== How to play
      list = %w(
        deny all
        allow 192.168.1.*
        allow 127.0.0.1
      )
      acl = ACL.new(list, ACL::DENY_ALLOW)
      ...
      ns = soc.accept
      unless acl.allow_socket?(ns)
        # forbidden
      end

Hosts is one of following
* All hosts --  --  "all", "*"
* A full/partial IP address -- "192.168.1.1", "192.168.1.*", "192.168.*.1", 
  "*.*.1.1", "::ffff:192.168.*.*", "*:192.168.1.1"
* A full/partial domain-name -- "host.*", "host", "*.domain.jp"

==Superclass:
    Object

==Class Methods:

--- ACL.new(list=nil, order=DENY_ALLOW)
    Create ACL. 

==Methods:

--- ACL#allow_socket?(soc)
    Test soc for access.
    Return true, if soc.peer_addr is allowed.

--- ACL#allow_addr?(addr)
    Test ((|addr|)) for access.
    Return (({true})), if addr is allowed.

--- ACL#install_list(list)
    Install rules. The first element of ((|list|)) is either 'deny' or 'allow', 
    and next elemnt is ((|HOST|)) expression, and so forth.
    example
      list = %w(
        deny all
        allow 192.168.1.*
        allow 127.0.0.1
      )


==Constants:

--- ACL::DENY_ALLOW
    The deny list is evaluated before the allow list. 
    (The initial state is OK.)

--- ACL::ALLOW_DENY
    The allow list is evaluated before the deny list. 
    (The initial state is FORBIDDEN.)


Copyright (c) 2000 Masatoshi SEKI
((<m_seki@mva.biglobe.ne.jp|URL:mailto:m_seki@mva.biglobe.ne.jp>))
=end
