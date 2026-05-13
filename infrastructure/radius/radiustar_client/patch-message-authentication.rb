
module Radiustar
  class Packet
    class Attribute
      alias_method :original_pack_attribute, :pack_attribute
      def pack_attribute attribute
        if attribute.type == "octets"
          anum = attribute.id
          val = @value
          [anum,
            val.length + 2,
            val
          ].pack(P_ATTR)
        else
          original_pack_attribute attribute
        end
      end
    end

    alias_method :original_gen_auth_authenticator, :gen_auth_authenticator
    def gen_auth_authenticator
      original_gen_auth_authenticator
      # use fixed authenticator for testing, should be random in real implementation
      # @authenticator = ["fa02f811e8aadf8cd786aee5188d6a29"].pack('H*')
      set_attribute('Message-Authenticator', @authenticator)
    end

    alias_method :original_pack, :pack
    def pack
      if @attributes.has_key? 'Message-Authenticator'
        @attributes['Message-Authenticator'].value = "\x00" * 16
        packed = original_pack
        ma = OpenSSL::HMAC.digest('md5', @shared_secret, packed)
        @attributes['Message-Authenticator'].value = ma
      end
      @packed = original_pack
      # puts "Packing packet with code '#{CODES[@code]}', id '#{@id}', authenticator '#{@authenticator.unpack1('H*')}' to '#{@packed.unpack1('H*')}'"
      @packed
    end
  end
end
