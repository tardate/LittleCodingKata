tell application "System Events"
	tell current desktop
		set intervalSeconds to get change interval
		set change interval to intervalSeconds
	end tell
end tell
