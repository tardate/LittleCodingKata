#! /usr/bin/env ruby
app = "System Events"
message = "Ruby task finished"
system("osascript -e 'tell app \"#{app}\" to display alert \"#{message}\"'")
