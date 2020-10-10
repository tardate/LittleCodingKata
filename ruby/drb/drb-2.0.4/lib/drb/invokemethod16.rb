# for ruby-1.6.8

module DRb
  class DRbServer
    module InvokeMethod16Mixin
      def block_yield(x)
	if x.class == Array
	  block_value = @block.__drb_yield(*x)
	else
	  block_value = @block.__drb_yield(x)
	end
      end

      def rescue_local_jump(err)
	case err.message
	when /^retry/	# retry from proc-closure
	  return :retry
	when /^break/	# break from proc-closure
	  return :break
	else
	  return :unknown
	end
      end

      def perform_with_block
	@obj.__send__(@msg_id, *@argv) do |x|
	  jump_error = nil
	  begin
	    block_value = block_yield(x)
	  rescue LocalJumpError
	    jump_error = $!
	  end
	  if jump_error
	    reason ,= rescue_local_jump(jump_error)
	    case reason
	    when :retry
	      retry
	    when :break
	      break
	    else
	      raise jump_error
	    end
	  end
	  block_value
	end
      end
    end
  end
end

