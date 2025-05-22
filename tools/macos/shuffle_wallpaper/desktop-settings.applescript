tell application "System Events"
	tell current desktop
    set desktopSettings to {name, id, display name, pictures folder, picture, picture rotation, random order, translucent menu bar, dynamic style, change interval}
    repeat with i from 1 to count of desktopSettings
      set settingLabel to item i of {"Name", "ID", "Display Name", "Pictures Folder", "Picture", "Picture Rotation", "Random Order", "Translucent Menu Bar", "Dynamic Style", "Change Interval"}
      set settingValue to item i of desktopSettings
      log settingLabel & ": " & settingValue
    end repeat
	end tell
end tell
