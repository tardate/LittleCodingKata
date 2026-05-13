
module Radiustar
  class Packet
    def encode(value, secret)
      raise "Authenticator must be 16 bytes" unless @authenticator.bytesize == 16

      # memo the shared secret for use in Message-Authenticator calculation
      @shared_secret = secret

      # pad password to multiple of 16 bytes
      padded = value.dup.b
      padded << "\x00" * ((16 - padded.bytesize % 16) % 16)

      result = +""
      previous = @authenticator

      padded.bytes.each_slice(16) do |slice|
        block = slice.pack('C*')

        hash = Digest::MD5.digest(secret + previous)

        encrypted =
          block.bytes.zip(hash.bytes).map { |a, b| a ^ b }.pack('C*')

        result << encrypted
        previous = encrypted
      end

      # puts "Encrypting password '#{value}' with secret '#{secret}' and authenticator '#{@authenticator.unpack1('H*')}' to '#{result.unpack1('H*')}'"
      result
    end
  end
end
