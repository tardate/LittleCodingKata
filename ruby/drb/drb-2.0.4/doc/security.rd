=begin
= dRubySecurity.en

== About the security of dRuby

* What is dRuby?
   * dRuby is a Ruby library that allows Ruby objects to call the methods
     of other Ruby objects across the network.

* How does dRuby protect communications?
   * dRuby does not perform encryption or authentication.

* Is a dRuby service protected from a malicious method call?
   * No, it is not protected nor does dRuby provide a sandbox model.

* Can anyone call a method?
   * Any host or process can call a method but this can be limited by:
     * ACL's can be used to limit the hosts that a connection can come from.
     * drb-1.3.7 can provide its service to be available only to localhost
       connections (e.g. druby://localhost:port)
     * SSL and UNIX domain sockets can be used in drb-2.x

* Can any method be called?
   * Although dRuby strives to implmement the same visibility model as
     Ruby, it is not extactly the same.  The behavior is:
     * A private method cannot be directly called (see below).
     * A protected method can be called.

* Is it safe if the method which you don't want to be called is
  declared private?
   * Although private methods cannot be directly called, one can get
     around this with the :send, :method and :extend (and possibly others).

* Can the :eval method be called?
   * Yes it can unless the safe level is set to $SAFE=1. 
     In this case, the Ruby interpreter raises a SecurityError.
=end
