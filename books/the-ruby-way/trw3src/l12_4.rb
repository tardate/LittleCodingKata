require "tk"

root = TkRoot.new { title "Radiobutton demo" }
top = TkFrame.new(root)

pack_opts = { side: "top", anchor: "w" }

major = TkVariable.new

b1 = TkRadioButton.new(top) do
  variable major
  text "Computer science"
  value 1
  command { puts "Major = #{major.value}" }
  pack pack_opts
end

b2 = TkRadioButton.new(top) do
  variable major
  text "Music"
  value 2
  command { puts "Major = #{major.value}" }
  pack pack_opts
end

b3 = TkRadioButton.new(top) do
  variable major
  text "Literature"
  value 3
  command { puts "Major = #{major.value}" }
  pack pack_opts
end

top.pack pack_opts

Tk.mainloop

