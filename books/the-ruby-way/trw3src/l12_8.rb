require "gtk3"

class MenuWindow < Gtk::Window

  def initialize
    super("Ruby/GTK2 Menu Sample")
    signal_connect("destroy") { Gtk.main_quit }

    file_exit_item = Gtk::MenuItem.new("_Exit")
    file_exit_item.signal_connect("activate") { Gtk.main_quit }

    file_menu = Gtk::Menu.new
    file_menu.add(file_exit_item)

    file_menu_item = Gtk::MenuItem.new("_File")
    file_menu_item.submenu = file_menu

    menubar = Gtk::MenuBar.new
    menubar.append(file_menu_item)
    menubar.append(Gtk::MenuItem.new("_Nothing"))
    menubar.append(Gtk::MenuItem.new("_Useless"))

    file_exit_item.set_tooltip_text "Exit the app"

    box = Gtk::Box.new(:vertical)
    box.pack_start(menubar, expand: false, fill: false, padding: 0)
    box.add(Gtk::Label.new("Try the menu and tooltips!"))

    add(box)
    set_default_size(400, 100)
    show_all
  end 
end

Gtk.init
MenuWindow.new
Gtk.main
