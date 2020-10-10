=begin
=dRuby reference manual

drb-1.3.2 version

 * retrieval in progress...done. -((-SugHimsi,2001-02.-))

== DRb::DRbIdConv class
The conversion machine of an object and an ID.

=== Methods:

--- to_obj(id)
It changes into an object from an ID.

--- to_id(obj)
It changes into an ID from an object. 


== DRb::DRbUnduped module
The Mix-in class for for call by reference.

===  Methods:

--- dump(dummy)
To make dump ill-done. TypeError exception is generated. 


== DRb::DRbServerNotFound
The error which DRbServer does not find. Probably DRbServer is not prepared. 

=== Superclass:
RuntimeError


== DRb::DRbUnknownError
The proxy exception is generated when a local side receives the exception
when Marshal.load cannot be carried out. 

=== Superclass:
RuntimeError

=== Class methods:
--- new(unknown)

=== Methods:
--- unknown
The proxy DRbUnknown object is made
since Marshal.load cannot be carried out. 


== DRb::DRbUnknown
The proxy object is generated, when an object is passed
since Marshal.load cannot be carried out. 

=== Class methods:
--- new(err, buf)
When Marsahl.load is failed, DRbUnknown is made from the object 
which origin series-ized with the exception. 

--- load(s)
The method called when Marshal.dump of the DRbUnknown is carried out 
and it is loaded. The object will be returned, if load is tried once 
again and the object which origin serialized is succeeded in load.
DRbUnknown will be returned if it fails. 

=== Methods:
--- _dump(lv)
The object which is called and serialized by Marshal.dump is returned
as it is. 

--- reload
To load once again. 

--- exception
DRbUnknownError exception is generated. 


== DRb::DRbProtocol module
The utility in connection with communication. For internal use.

=== Methods:
--- parse_uri(uri)
A host and a port are taken out from URI. 

--- dump(obj, soc)
obj is serialized and it sends to soc.

--- load(soc)
The serialized object is taken out from soc.

--- send_request(soc, ref, msg_id, *arg, &b)
A message is transmited to soc.

--- recv_request(soc)
The message from soc is received.

--- send_reply(soc, succ, result)
The result of a method is transmited to soc.

--- recv_reply(soc)
The result of a method is received from soc.

--- ro_to_obj(ro)
It changes into an object from a reference object.


== DRb::DRbObject class
The object which refers to a remote object.

=== Class methods:

--- new(obj, uri=nil)
The reference object to obj is made. obj serves as the reference to 
front object of DRbServer of uri, when uri is specified by nil. 


=== Methods:

--- __drbref
The ID for specifying an object within a server is returned. 
It is used inside. 


--- method_missing(msg_id, *a, &b)
It is called when there is no method, and a message is transmitted to
a remote object. 

--- to_s
It is undefined and the remote method is invoked.

--- to_a
It is undefined and the remote method is invoked.

--- respond_to?
It is undefined and the remote method is invoked.


== DRb::DRbConn class
The library used in order that DRbObject may start a remote method.
 It is used inside. 

=== Superclass:
DRbProtocol (Mix-in)

=== Class methods:

--- new(remote_uri)
The communication with the server specified by remote_uri is prepared. 

=== Methods:

--- send_message(ref, msg_id, *arg, &block)
A message is transmitted to remote and an evaluation result is received. 

--- untaint_remote
private method. remote_uri is untainted.

== DRb::DRbServer class
The server thread which offers RMI of dRuby. 
Most of all modules which was the function of DRb-1.2 series
are moved to DRbServer. More than one DRbServers can be simultaneously 
used in a process. 

=== Class Methods

--- default_argc_limit(argc)
Set the maximum number of arguments of any method.
It is effective for subsequently created instances of DRbServer.

--- default_load_limit(sz)
Set the maximum size of serialized objects.
It is effective for subsequently created instances of DRbServer.

--- default_acl(acl)
Set up default ACL.  It is effective for subsequently created instances of DRbServer.

--- new(uri=nil, front=nil, acl=nil, idconv=nil)

A DRbServer is created and a server thread is started. The DRbServer first 
generated with application turns into primary_server. 

((|uri|)) serves as own URI of DRbServer. nil and omitted URI of
form can be given to ((|uri|)). If a port number is omitted, a
system will use the port assigned automatically. ((|front|)) is an
object related with URI. When customizing ACL and ((|id_conv|)), it
specifies by ((|acl|)) and ((|idconv|)), respectively.

=== Methods

--- uri
Full URI is returned. 

--- thread
A server thread is returned.

--- front
The front object related to the URI is returned.


--- argc_limit
The maximum number of the arguments of a method is returned.

--- argc_limit=
The maximum number of the arguments of a method is set up.

--- load_limit
The maximum size of the serialized object is returned.

--- load_limit=
The maximum size of the serialized object is set up.

--- alive?
It returns whether the server thread is valid. 

--- stop_service
A server thread is stopped.

--- to_obj(ref)
The object corresponding to an ID is returned. 

--- to_id(obj)
The ID corresponding to an object is returned. 

=== Private instance methods:

--- kill_sub_thread
All the threads started by the server thread are stopped. 

--- run
Main loop.

--- allow?(s)
It returns whether access from socket s is allowed. This is overridden 
to change control of access. 

--- insecure_methods?(msg_id)
It investigates whether it is a dangerous method. If true,
a method is not started. 

--- fake_yield(argv)
For internal use.

--- obj_send(obj, msg_id, *argv)
The method to obj demanded from remote is started. For internal use.


--- proc
A demand of RMI is processed. For internal use.


== DRb module

Many functions are moved to DRbServer from 1.3, and what [ the methods of
DRb ] is transmitted to a primary server and a current server increased. 


=== Methods:
--- start_service(uri=nil, front=nil, acl=nil)
A DRbServer is created and a server thread is started. 

--- primary_server
A primary server is returned.

--- current_server
The current server is returned. If the present thread which will return a
primary server if unrelated in DRbServer to which the present thread relates
is started by RMI, the server which received the RMI is a current server. 

--- stop_service
The server thread of a primary server is stopped. 

--- uri
The URI of the current server is returned.

--- front
The front object of the current server is returned.

--- to_obj(ref)
The object corresponding to an ID is returned by the conversion method of 
the current server.

--- to_id(ref)
The ID corresponding to an object is returned by the conversion method of
the current server.

--- thread
The thread of a primary server is returned. 

--- install_id_conv(idconv)
DRbServer.default_id_conv(idconv)

--- install_acl(acl)
DRbServer.default_acl(acl)
=end
