require 'tk'

# Common packing options...
top  = { side: 'top', padx: 5, pady: 5 }
left = { side: 'left', padx: 5, pady: 5 }
bottom = { side: 'bottom', padx: 5, pady: 5 }

# Starting temperature...
temp = 74

root = TkRoot.new { title "Thermostat" }
tframe = TkFrame.new(root) { background "#606060" }
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
bframe = TkFrame.new(root)
tlab = TkLabel.new(tframe) do
  text temp.to_s
  font "{Helvetica} 54 {bold}"
  foreground "green"
  background "#606060"
  pack left 
end

# the "degree" symbol
TkLabel.new(tframe) do
  text "o"
  font "{Helvetica} 14 {bold}"
  foreground "green"
  background "#606060"
  # Anchor-north above text like a degree symbol
  pack left.update(anchor: 'n')
end

TkButton.new(bframe) do
  text " Up "
  pack left
  command do
    temp += 1
    tlab.configure(text: temp.to_s)
  end
end

TkButton.new(bframe) do
  text "Down"
  pack left
  command do
    temp -= 1
    tlab.configure(text: temp.to_s)
  end
end

tframe.pack top
bframe.pack bottom

Tk.mainloop

