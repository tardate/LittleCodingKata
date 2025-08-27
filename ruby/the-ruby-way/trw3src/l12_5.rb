require "gtk3"

class SampleWindow < Gtk::Window

  def initialize
    super("Ruby/GTK3 Sample")
    signal_connect("destroy") { Gtk.main_quit }

    entry = Gtk::Entry.new

    button = Gtk::Button.new("All Caps!   ")
    button.signal_connect("clicked") {
      entry.text = entry.text.upcase
    }

    box = Gtk::HBox.new
    box.add(Gtk::Label.new("Text:"))
    box.add(entry)
    box.add(button)

    add(box)
    show_all 
  end
end

Gtk.init
SampleWindow.new
Gtk.main
