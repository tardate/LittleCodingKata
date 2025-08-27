require 'Qt'

class MyWindow < Qt::Widget
  slots 'somethingClicked(QAbstractButton *)'

  def initialize(parent = nil)
    super(parent)

    groupbox = Qt::GroupBox.new("Some Radio Button",self)

    radio1 = Qt::RadioButton.new("Radio Button 1", groupbox)
    radio2 = Qt::RadioButton.new("Radio Button 2", groupbox)

    check1 = Qt::CheckBox.new("Check Box 1", groupbox)

    vbox = Qt::VBoxLayout.new
    vbox.addWidget(radio1)
    vbox.addWidget(radio2)
    vbox.addWidget(check1)

    groupbox.setLayout(vbox)

    bg = Qt::ButtonGroup.new(self)
    bg.addButton(radio1)
    bg.addButton(radio2)
    bg.addButton(check1)

    connect(bg, SIGNAL('buttonClicked(QAbstractButton *)'),
            self, SLOT('somethingClicked(QAbstractButton *)') )
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
    @label = Qt::Label.new(self)

    vbox = Qt::VBoxLayout.new
    vbox.addWidget(groupbox)
    vbox.addWidget(@label)

    setLayout(vbox)
  end

  def somethingClicked(who)
    @label.setText("You clicked on a " + who.className)
  end 
end

app = Qt::Application.new(ARGV)
widget = MyWindow.new
widget.show
app.exec
