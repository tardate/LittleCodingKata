require "gtk3"

class TextWindow < Gtk::Window

  def initialize
    super("Text Sample")
    signal_connect("destroy") { Gtk.main_quit }
    set_default_size(200, 50)

    @text = Gtk::TextView.new
    @text.wrap_mode = :word

    @buffer = @text.buffer
    @buffer.signal_connect("changed") {
      @status.text = "Length: " + @buffer.char_count.to_s
    }
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
￼￼
    @buffer.create_tag('notice',
                        'font' => "Times Bold Italic 18",
                        'foreground' => "red")

    @status = Gtk::Label.new

    scroller = Gtk::ScrolledWindow.new
    scroller.set_policy(:automatic, :never)
    scroller.add(@text)

    box = Gtk::Box.new(:vertical)
    box.add(scroller)
    box.add(@status)
    add(box)

    iter = @buffer.start_iter
    @buffer.insert(iter, "This is an editor")
    iter.offset = 5
    @buffer.insert(iter, "really ", "notice")

    show_all 
  end
end

Gtk.init
TextWindow.new
Gtk.main
