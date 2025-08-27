require "tk"

root = TkRoot.new { title "Checkbutton demo" }
top = TkFrame.new(root)

pack_opts  = { side: "top", anchor: "w" }

cb1var = TkVariable.new
cb2var = TkVariable.new
cb3var = TkVariable.new

cb1 = TkCheckButton.new(top) do
  variable cb1var
  text "Computer science"
  command { puts "Button 1 = #{cb1var.value}" }
  pack pack_opts
end

cb2 = TkCheckButton.new(top) do
  variable cb2var
  text "Music"
  command { puts "Button 2 = #{cb2var.value}" }
  pack pack_opts
end

cb3 = TkCheckButton.new(top) do
  variable cb3var
  text "Literature"
  command { puts "Button 3 = #{cb3var.value}" }
  pack pack_opts
end

top.pack pack_opts

Tk.mainloop
