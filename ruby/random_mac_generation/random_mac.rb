#! /usr/bin/env ruby
#
# Generate random MAC address
# Inspired by http://www.linux-kvm.com/sites/default/files/macgen.py


DEFAULT_OUI = '00-16-3e'  # Xensource, Inc.

# Returns a random MAC address, with optional +oui+ override
# Note: assumes PRNG seed already suitable. Call `srand` if you care to re-seed.
def random_mac(oui=nil)
  mac_parts = [oui||DEFAULT_OUI]
  [0x7f, 0xff, 0xff].each do |limit|
    mac_parts << "%02x" % rand(limit + 1)
  end
  mac_parts.join('-')
end

if __FILE__==$PROGRAM_NAME
  puts random_mac(ARGV[0])
end
