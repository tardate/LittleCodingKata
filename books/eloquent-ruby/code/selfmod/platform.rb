#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
class DependsOnOS
  if /linux/.match?(RUBY_PLATFORM)
    def an_os_sensitive_method
      # Do the right thing for Linux.
    end
  elsif /mswin|mingw/.match?(RUBY_PLATFORM)
    def an_os_sensitive_method
      # Do the right thing for MS Windows.
    end
  elsif /darwin/.match?(RUBY_PLATFORM)
    def an_os_sensitive_method
      # Do the right thing for MS Windows.
    end
  else
    raise Exception.new("What are we running on?")
  end
end

class ApplicationLogger
  # Look at an environment variable to see if we are
  # running in development mode.
  if ENV["MY_APP_ENV"] == "development"
    def debug(msg)
      puts "DEBUG: #{msg}"
    end
  else
    def debug(msg)
      # Do nothing
    end
  end
end
