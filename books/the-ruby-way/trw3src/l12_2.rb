require "tk"

def packing(padx, pady, side = "left", anchor = "n")
  { padx: padx, pady: pady, side: side, anchor: anchor }
end

root  = TkRoot.new() { title "Telnet session" }
top   = TkFrame.new(root)
fr1   = TkFrame.new(top)
fr1a  = TkFrame.new(fr1)
fr1b  = TkFrame.new(fr1)
fr2   = TkFrame.new(top)
fr3   = TkFrame.new(top)
fr4   = TkFrame.new(top)

LabelPack   = packing(5, 5, "top", "w")
EntryPack   = packing(5, 2, "top")
ButtonPack  = packing(15, 5, "left", "center")
FramePack   = packing(2, 2, "top")
Frame1Pack  = packing(2, 2, "left")

var_host = TkVariable.new
var_port = TkVariable.new
var_user = TkVariable.new
var_pass = TkVariable.new

lab_host = TkLabel.new(fr1a) do
  text "Host name"
  pack LabelPack
end

ent_host = TkEntry.new(fr1a) do
  textvariable var_host
  font "{Helvetica} 10"
  pack EntryPack
end

lab_port = TkLabel.new(fr1b) do
  text "Port"
  pack LabelPack
end

ent_port = TkEntry.new(fr1b) do
  width 4
  textvariable var_port
  font "{Helvetica} 10"
  pack EntryPack
end

lab_user = TkLabel.new(fr2) do
  text "User name"
  pack LabelPack
end

ent_user = TkEntry.new(fr2) do
  width 21
  font "{Helvetica} 12"
  textvariable var_user
  pack EntryPack
end
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
lab_pass = TkLabel.new(fr3) do
  text "Password"
  pack LabelPack
end

ent_pass = TkEntry.new(fr3) do
  width 21
  show "*"
  textvariable var_pass
  font "{Helvetica} 12"
  pack EntryPack
end

btn_signon = TkButton.new(fr4) do
  text "Sign on"
  command {}        # Does nothing!
  pack ButtonPack
end

btn_cancel = TkButton.new(fr4) do
  text "Cancel"
  command { exit }  # Just exits
  pack ButtonPack
end

top.pack FramePack
fr1.pack FramePack
fr2.pack FramePack
fr3.pack FramePack
fr4.pack FramePack
fr1a.pack Frame1Pack
fr1b.pack Frame1Pack

var_host.value = "addison-wesley.com"
var_user.value = "debra"
var_port.value = 23

ent_pass.focus
foo = ent_user.font

Tk.mainloop
