require 'Qt'

class MyWidget < Qt::Widget
  slots 'buttonClickedSlot()'

  def initialize(parent = nil)
    super(parent)

    setWindowTitle("QtRuby example");

    @lineedit = Qt::LineEdit.new(self)
    @button = Qt::PushButton.new("All Caps!",self)

    connect(@button, SIGNAL('clicked()'),
            self, SLOT('buttonClickedSlot()'))

    box = Qt::HBoxLayout.new
    box.addWidget(Qt::Label.new("Text:"))
    box.addWidget(@lineedit)
    box.addWidget(@button)

    setLayout(box)
  end

  def buttonClickedSlot
    @lineedit.setText(@lineedit.text.upcase)
  end 
end

app = Qt::Application.new(ARGV)
widget = MyWidget.new
widget.show
app.exec
